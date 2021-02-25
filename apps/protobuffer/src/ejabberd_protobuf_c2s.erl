-module(ejabberd_protobuf_c2s).

-behaviour(ejabberd_listener).
-include_lib("ejabberd/include/logger.hrl").

-export([start/3, start_link/3, accept/1, listen_opt_type/1, listen_options/0]).

start(SockMod, Socket, Opts) ->
    ?DEBUG("start ~p ~p ~p ~n", [SockMod, Socket, Opts]),
    'Elixir.Mod.Protobuf':start(SockMod, Socket, Opts).
start_link(SockMod, Socket, Opts) ->
    ?DEBUG("start link ~p ~p ~p ~n", [SockMod, Socket, Opts]),
    Ret = 'Elixir.Mod.Protobuf':start_link(SockMod, Socket, Opts),
    ?DEBUG("start link ~p ~n", [Ret]),
    Ret.

accept(Ref) ->
    'Elixir.Mod.Protobuf':accept(Ref).

listen_opt_type(Opt) ->
    ejabberd_c2s:listen_opt_type(Opt).

listen_options() ->
    ejabberd_c2s:listen_options().
