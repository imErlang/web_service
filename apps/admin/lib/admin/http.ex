defmodule Admin.Ejabberd do
  require Logger

  def notify(host_info) do
    users = Ejabberd.HostUsers.get_users(host_info.id)

    users
    |> Enum.each(fn user ->
      notice = %{
        from: "admin@#{host_info.host}",
        to: %{userId: "user.user_id@#{host_info.host}"},
        category: 1,
        data: ""
      }

      case client() |> Tesla.post("/qtalk/send_notify", notice) do
        {:ok, _} ->
          Logger.debug("send notify to #{user.user_id}")

        {:error, _} ->
          Logger.debug("send notify error #{user.user_id}")
      end
    end)
  end

  # build dynamic client based on runtime arguments
  def client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, Application.get_env(:admin, :im_url, "http://127.0.0.1:10050")},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware)
  end
end
