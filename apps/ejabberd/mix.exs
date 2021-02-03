defmodule Ejabberd.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ejabberd,
      version: "16.8.0",
      description: description(),
      elixir: "~> 1.2",
      elixirc_paths: ["lib"],
      compile_path: ".",
      compilers: [:asn1] ++ Mix.compilers(),
      erlc_options: erlc_options(),
      erlc_paths: ["asn1", "src"],
      # Elixir tests are starting the part of ejabberd they need
      aliases: [test: "test --no-start"],
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    """
    Robust, ubiquitous and massively scalable Jabber / XMPP Instant Messaging platform.
    """
  end

  def application do
    [
      mod: {:ejabberd_app, []},
      applications: [:ssl],
      included_applications: [
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
        :p1_mysql,
        :p1_pgsql,
        :recon_ex,
        :protobuf
      ]
    ]
  end

  defp erlc_options do
    # Use our own includes + includes from all dependencies
    includes = ["include"] ++ Path.wildcard(Path.join("..", "/*/include"))
    [:debug_info] ++ Enum.map(includes, fn path -> {:i, path} end)
  end

  defp deps do
    [
      {:lager, "~> 3.2"},
      {:cowboy, "~> 1.0.1"},
      {:poolboy, "~> 1.5"},
      {:p1_utils, "~> 1.0"},
      {:cache_tab, "~> 1.0"},
      {:stringprep, "~> 1.0"},
      {:fast_yaml, "~> 1.0"},
      {:fast_tls, "~> 1.0"},
      {:fast_xml, "~> 1.1"},
      {:stun, "~> 1.0"},
      {:esip, "~> 1.0"},
      {:jiffy, "~> 1.0"},
      {:p1_oauth2, "~> 0.6.1"},
      {:p1_mysql, "~> 1.0"},
      {:p1_pgsql, "~> 1.1"},
      {:ezlib, "~> 1.0"},
      {:iconv, "~> 1.0"},
      {:eredis, "~> 1.0"},
      {:brod, "~> 3.15"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:meck, "~> 0.8.4", only: :test, override: true},
      {:moka, github: "processone/moka", tag: "1.0.5c", only: :test},
      {:protobuffs, github: "processone/erlang_protobuffs"},
      {:recon_ex, "~> 0.9.1"},
      {:rfc4627_jsonrpc, github: "tonyg/erlang-rfc4627"},
      {:distillery, "~> 2.1"},
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:protobuf, "~> 0.7.1"}
    ]
  end

  defp package do
    # These are the default files included in the package
    [
      files: ["lib", "src", "priv", "mix.exs", "include", "README.md", "COPYING"],
      maintainers: ["ProcessOne"],
      licenses: ["GPLv2"],
      links: %{
        "Site" => "https://www.ejabberd.im",
        "Documentation" => "http://docs.ejabberd.im",
        "Source" => "https://github.com/processone/ejabberd",
        "ProcessOne" => "http://www.process-one.net/"
      }
    ]
  end
end

defmodule Mix.Tasks.Compile.Asn1 do
  use Mix.Task
  alias Mix.Compilers.Erlang

  @recursive true
  @manifest ".compile.asn1"

  def run(args) do
    {opts, _, _} = OptionParser.parse(args, switches: [force: :boolean])

    project = Mix.Project.config()
    source_paths = project[:asn1_paths] || ["asn1"]
    dest_paths = project[:asn1_target] || ["src"]
    mappings = Enum.zip(source_paths, dest_paths)
    options = project[:asn1_options] || []

    Erlang.compile(manifest(), mappings, :asn1, :erl, opts[:force], fn
      input, output ->
        options = options ++ [:noobj, outdir: Erlang.to_erl_file(Path.dirname(output))]

        case :asn1ct.compile(Erlang.to_erl_file(input), options) do
          :ok -> {:ok, :done}
          error -> error
        end
    end)
  end

  def manifests, do: [manifest()]
  defp manifest, do: Path.join(Mix.Project.manifest_path(), @manifest)

  def clean, do: Erlang.clean(manifest())
end
