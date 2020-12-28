defmodule Admin.Config do
  use Toml.Transform
  require Logger

  def transform(:admin, v) do
    Enum.map(v, fn
      {:ecto_repos, repos} ->
        Logger.info("ecto repos #{inspect(repos)}")

        {:ecto_repos,
         Enum.map(repos, fn
           "user" ->
             User.Repo

         end)}

      {:user, user} ->
        Logger.info("ectos #{inspect(user)}")

        {User.Repo,
         [
           database: user.database,
           username: user.username,
           password: user.password,
           hostname: user.hostname
         ]}

      {k, v} ->
        {k, v}
    end)
  end

  def transform(_k, v) do
    v
  end
end
