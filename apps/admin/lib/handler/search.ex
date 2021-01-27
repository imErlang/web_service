defmodule Handler.Search do
  @moduledoc """
  host router
  """
  require Logger
  import Bitwise

  @user_group "Q01"
  @group_group "Q02"
  @chat_group "Q03"
  @file_group "Q04"

  @qtalk_open_user_vcard 0
  @qtalk_open_group_vcard 1

  def search(conn) do
    len = Map.get(conn.body_params, "length", 10)
    start = Map.get(conn.body_params, "start", 0)
    qtalk_id = Map.get(conn.body_params, "qtalkId", "")
    key = Map.get(conn.body_params, "key", "") |> String.trim()
    key = if String.length(key) > 20, do: String.slice(key, 1..20), else: key
    platform = Map.get(conn.body_params, "platform", "")
    group_id = Map.get(conn.body_params, "groupId", "")
    action = Map.get(conn.body_params, "action", "")
    Logger.debug("len: #{inspect(len)}, start: #{start}, qtalk_id: #{qtalk_id}")

    Logger.debug(
      "key: #{inspect(key)}, platform: #{platform}, group_id: #{group_id}, action: #{action}"
    )

    group_id = if platform !== "", do: "", else: group_id
    Logger.debug("group id with platform: #{group_id}")

    action = if action == "63", do: "31", else: action

    action =
      case Kernel.is_binary(action) do
        true ->
          String.to_integer(action)

        false ->
          action
      end

    user_flag = get_bit(action, 0)
    group_flag = get_bit(action, 1)
    single_flag = get_bit(action, 3)
    muc_flag = get_bit(action, 4)
    file_flag = get_bit(action, 5)

    Logger.debug(
      "user_flag: #{user_flag}, group_flag: #{group_flag}, single_flag: #{single_flag}"
    )

    Logger.debug("muc_flag: #{muc_flag}, file_flag: #{file_flag}")

    results = []

    results =
      case user_flag do
        true ->
          user_result = get_users(qtalk_id, key, len + 1, start)

          if length(user_result.info) > 0, do: [user_result | results], else: results

        false ->
          results
      end

    results =
      case group_flag do
        true ->
          group_result = get_groups(qtalk_id, key, len + 1, start)

          if length(group_result.info) > 0, do: [group_result | results], else: results

        false ->
          results
      end

    {chat_result_type, chat_histories} =
      case single_flag do
        true ->
          user_histories = Handler.History.get_user_history(qtalk_id, key, len + 1, start)

          case length(user_histories) > 0 do
            true ->
              {8, user_histories}

            false ->
              {0, []}
          end

        false ->
          {0, []}
      end

    {chat_result_type, chat_histories} =
      case muc_flag do
        true ->
          muc_histories = Handler.History.get_muc_history(qtalk_id, key, len + 1, start)

          case length(muc_histories) > 0 do
            true ->
              {chat_result_type + 16, muc_histories}

            false ->
              {chat_result_type, chat_histories}
          end

        false ->
          {chat_result_type, chat_histories}
      end

    results =
      case chat_result_type > 0 do
        true ->
          chat_result = %{
            groupLabel: "聊天记录",
            groupId: @chat_group,
            info: chat_histories,
            resultType: chat_result_type,
            hasMore: true
          }

          [chat_result | results]

        false ->
          results
      end

    results =
      case file_flag do
        true ->
          files = Handler.History.get_file_history(qtalk_id, key, len + 1, start)

          case length(files) > 0 do
            true ->
              file_result = %{
                groupLabel: "文件",
                groupId: @file_group,
                info: files,
                resultType: 32,
                hasMore: len < length(files)
              }

              [file_result | results]

            false ->
              results
          end

        false ->
          results
      end

    Logger.debug("results: #{inspect(results)}")

    Ejabberd.Util.success(results)
  end

  def get_bit(action, num) do
    (action >>> num &&& 0b01) > 0
  end

  def get_groups(user_id, key, limit, offset) do
    groups =
      Ejabberd.UserRegisterMucs.search_group(user_id, key, limit, offset)
      |> Enum.map(fn
        [mucname, _domain, show_name, muc_title, muc_pic, tags] ->
          todo_type = tags |> Enum.reduce(4, fn tag, acc -> if tag == [""], do: 6, else: acc end)

          %{
            uri: mucname,
            label: show_name,
            content: muc_title,
            icon: muc_pic,
            hit: [key],
            todoType: todo_type
          }
      end)

    has_more = limit < length(groups) - 1
    muc_portrait = Application.get_env(:admin, :muc_portrait, "")
    file_url = Application.get_env(:admin, :file_url, "")

    %{
      resultType: 6,
      groupLabel: "群组",
      groupId: @group_group,
      groupPriority: 0,
      todoType: @qtalk_open_group_vcard,
      defaultportrait: "#{file_url}#{muc_portrait}",
      hasMore: has_more,
      info: groups
    }
  end

  def get_users(user_id, keyword, limit, offset) do
    users =
      Ejabberd.HostUsers.search_user(user_id, keyword, limit, offset)
      |> Enum.map(fn [userid, department, icon, user_name, mood, pinyin] ->
        label = "#{user_name}(#{userid})"
        label = if mood !== nil, do: "#{label}-#{mood}", else: label
        [user_s_name | _] = String.split(userid, "@")

        %{
          qtalkname: user_s_name,
          uri: userid,
          content: department,
          icon: icon,
          name: user_name,
          label: label,
          pinyin: pinyin
        }
      end)

    has_more = limit < length(users) - 1
    single_portrait = Application.get_env(:admin, :single_portrait, "")
    file_url = Application.get_env(:admin, :file_url, "")

    %{
      resultType: 1,
      groupLabel: "联系人",
      groupId: @user_group,
      groupPriority: 0,
      todoType: @qtalk_open_user_vcard,
      defaultportrait: "#{file_url}#{single_portrait}",
      hasMore: has_more,
      info: users
    }
  end
end
