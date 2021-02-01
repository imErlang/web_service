# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Distillery.Releases.Config,
    # This sets the default release built by `mix distillery.release`
    default_release: :default,
    # This sets the default environment used by `mix distillery.release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  # If you are running Phoenix, you should make sure that
  # server: true is set and the code reloader is disabled,
  # even in dev mode.
  # It is recommended that you build with MIX_ENV=prod and pass
  # the --env flag to Distillery explicitly if you want to use
  # dev mode.
  set dev_mode: true
  set include_erts: false
  set cookie: :"?PgZE!KY]ztBP(.[ckiLGTz%T(z:!f0h_!9eO:n)YAL6D)3Z|y^G~*.qsN.W%P.p"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"O<0yDpb@4<OeNtZNt(0!9sr}a1WuigT>Y$YM0|TuT2br&mtuX6QR[)25l?%.p2Vm"
  set vm_args: "rel/vm.args"

  set(
    overlays: [
      {:mkdir, "var/log/ejabberd"},
      {:mkdir, "var/lock"},
      {:mkdir, "var/lib/ejabberd"},
      {:mkdir, "etc/ejabberd"},
      {:mkdir, "doc"},
      {:template, "ejabberdctl.template", "bin/ejabberdctl"},
      {:copy, "ejabberdctl.cfg.example", "etc/ejabberd/ejabberdctl.cfg"},
      {:copy, "config/ejabberd.yml", "etc/ejabberd/ejabberd.yml"},
      {:copy, "server.pem", "server.pem"},
      {:copy, "inetrc", "etc/ejabberd/inetrc"},
      {:copy, "rel/files/install_upgrade.escript", "bin/install_upgrade.escript"}
    ]
  )
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix distillery.release`, the first release in the file
# will be used by default

release :ejabberd do
  set version: current_version(:ejabberd)
  set applications: [
    :runtime_tools,
    :lager,
    :mnesia,
    :p1_utils,
    :cache_tab,
    :fast_tls,
    :stringprep,
    :fast_xml,
    :stun,
    :fast_yaml,
    :ezlib,
    :iconv,
    :esip,
    :jiffy,
    :p1_oauth2,
    :eredis,
    :p1_pgsql,
    :ranch,
    :protobuffs,
    rfc4627_jsonrpc: :load,
    cowboy: :permanent,
    poolboy: :permanent,
    brod: :permanent,
    distillery: :permanent
  ]
end
