defmodule Handler.Share do
  @moduledoc """
  host router
  """
  require Logger

  @max_time_interval 600_000
  @pattern_match ~r{(\[obj type="([\w]+)" value="([\S]+)"([\w|=|\s|.]+)?\])}

  def gen_url("https://" <> _ = value) do
    value
  end

  def gen_url("http://" <> _ = value) do
    value
  end

  def gen_url(value) do
    download_url = Application.get_env(:admin, :download_url)
    download_url <> value
  end

  def share_msg(conn) do
    {:ok, jdata} =
      Map.get(conn.query_params, "jdata", "")
      |> String.replace("_", "+")
      |> String.replace("_", "/")
      |> String.replace(".", "+")
      |> Base.decode64()

    username = Map.get(conn.query_params, "username", "")
    rk = Map.get(conn.query_params, "rk", "")
    user_id = Map.get(conn.query_params, "user_id", "")
    company = Map.get(conn.query_params, "company", "")
    domain = Map.get(conn.query_params, "domain", "")
    Logger.debug("jdata: #{jdata}, username: #{username}, rk: #{rk}")
    Logger.debug("user_id: #{user_id}, company: #{company}, domain: #{domain}")
    {:ok, data} = Tesla.get(jdata)
    {:ok, histories} = data.body |> Jason.decode()
    histories = histories |> Enum.sort_by(fn his -> Map.get(his, "s") end)
    Logger.debug("histories: #{inspect(histories)}")

    now_time = DateTime.utc_now() |> DateTime.to_unix(:millisecond)

    {content, last_time} =
      histories
      |> Enum.reduce({"", now_time}, fn history, {acc, last_time} ->
        Logger.debug("history: #{inspect(history)}")
        nick = Map.get(history, "n")
        history_time = Map.get(history, "s")
        body = Map.get(history, "b")
        speaker = Map.get(history, "d")
        type = Map.get(history, "t")

        {acc, last_time} =
          cond do
            nick !== nil && body !== nil && history_time !== nil && speaker !== nil &&
                history_time - last_time > @max_time_interval ->
              {:ok, date} = history_time |> DateTime.from_unix()

              format_date =
                "#{date.year}-#{date.month}-#{date.day} #{date.hour}:#{date.minute}:#{date.second}"

              {"#{acc}<div>#{format_date}", history_time}

            true ->
              {acc, last_time}
          end

        Logger.debug("acc: #{acc}, last_time: #{last_time}")

        history_body =
          cond do
            type == 1 || type == 3 || type == 12 || type == 30 ->
              items = Regex.scan(@pattern_match, body)
              Logger.debug("items: #{inspect(items)}, body: #{body}")

              new_body =
                items
                |> Enum.reduce(body, fn item, new_body ->
                  [item_body, item_body, item_type, item_value, item_opts] = item

                  new_body =
                    case item_type do
                      "image" ->
                        String.replace(new_body, item_body, "<img src=#{gen_url(item_value)} />")

                      "url" ->
                        String.replace(
                          new_body,
                          item_body,
                          "<a href=#{item_value}>#{item_value}</a>"
                        )

                      "emoticon" ->
                        [_, em_type] = Regex.run(~r{.*=(.+) .+=.*}, item_opts)
                        [_, em_value] = Regex.run(~r{\[(.+)\]}, item_value)
                        emo_url = gen_url("file/v2/emo/d/e/#{em_type}#{em_value}/org")

                        Logger.debug(
                          "em_type: #{em_type}, em_value: #{em_value}, emo_url: #{emo_url}"
                        )

                        String.replace(new_body, item_body, "<img src=#{emo_url} />")
                    end

                  Logger.debug("replace url new_body: #{new_body}")
                  new_body
                end)

              Logger.debug("replace url new_body: #{new_body}")
              new_body

            type == 5 ->
              {:ok, json_body} = Jason.decode(body)
              file_size = Map.get(json_body, "FileSize", 0)
              http_url = Map.get(json_body, "HttpUrl", "") |> gen_url()
              file_name = Map.get(json_body, "FileName", "")
              "<a href=\"#{http_url}\">下载文件: #{file_name},文件大小: #{file_size}</a>"

            type == 2 ->
              {:ok, json_body} = Jason.decode(body)
              seconds = Map.get(json_body, "Seconds", 0)
              http_url = Map.get(json_body, "HttpUrl", "") |> gen_url()
              "<a href=\"#{http_url}\">语音:#{seconds}秒,点击下载</a>"

            type == 32 ->
              {:ok, json_body} = Jason.decode(body)
              file_size = Map.get(json_body, "FileSize", 0)
              duration = Map.get(json_body, "Duration", 0)
              file_url = Map.get(json_body, "FileUrl", "") |> gen_url()
              thum_url = Map.get(json_body, "ThumUrl", "") |> gen_url()

              "点击图片下载视频:#{file_size}时长:#{duration}<br><a href=\"#{file_url}\"><img src=\"#{
                thum_url
              }\" /></a>"

            type == 16 ->
              {:ok, json_body} = Jason.decode(body)
              address = Map.get(json_body, "address", "")
              latitude = Map.get(json_body, "latitude", "")
              longitude = Map.get(json_body, "longitude", "")
              file_url = Map.get(json_body, "fileUrl", "") |> gen_url()

              "点击图片查看位置: #{address} <br><a href=\"http://api.map.baidu.com/marker?location=#{
                latitude
              },#{longitude}&title=我的位置&content=#{address}&output=html\"><img src=\"#{file_url}\" /></a>"

            type == 666 ->
              {:ok, json_body} = Jason.decode(body)
              desc = Map.get(json_body, "desc", "点击查看全文")
              default_img = Application.get_env(:admin, :default_img)
              img = Map.get(json_body, "img", default_img) |> gen_url()
              link_url = Map.get(json_body, "linkurl")
              title = Map.get(json_body, "title")

              "<a href=#{link_url}><div class=\"g-flexbox\"><div class=\"extleft\"><img src=#{img} alt=\"../{{default.png}}\"/></div><div class=\"flex\"><p class=\"line\">#{
                title
              }</p><p class=\"line2\">#{desc}</p></div></div></a>"

            true ->
              body
          end

        Logger.debug("history_new_body: #{history_body}")

        speaker_body =
          case speaker == 1 do
            true ->
              ~s(<div class="rightd"><div class="main"><div class="speech right">#{history_body}</div></div><div class="rightimg">#{
                nick
              }</div></div>)

            false ->
              ~s(<div class="leftd"><div class="leftimg">#{history_body}</div><div class="main"><div class="speech left">#{
                nick
              }</div></div></div>)
          end

        Logger.debug("speaker body: #{speaker_body}")
        {acc <> speaker_body, last_time}
      end)

    Logger.debug("content: #{inspect(content)}, last_time: #{last_time}")

    render("sharemsg.html", content: content)
  end

  @template_dir "apps/admin/lib/templates"

  defp render(template, assigns) do
    @template_dir
    |> Path.join(template)
    |> String.replace_suffix(".html", ".html.eex")
    |> EEx.eval_file(assigns)
  end
end
