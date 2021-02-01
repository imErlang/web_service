%% Feel free to use, reuse and abuse the code in this file.

-module(http_healthcheck).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).
-include("ejabberd.hrl").
-include("logger.hrl").

init(_Transport, Req, []) ->
	{ok, Req, undefined}.

handle(Req, State) ->
	{Method, _} = cowboy_req:method(Req),
	case Method of 
	<<"GET">> ->
	{ok, Req1} = get_echo(Method,Req),
	{ok, Req1, State};
	_ ->
	{ok,Req1} = echo(undefined, Req),
	{ok, Req1, State}
	end.
    	
get_echo(<<"GET">>,Req) ->
	cowboy_req:reply(200, [], [], Req);
get_echo(_,Req) ->
	cowboy_req:reply(405, Req).

echo(undefined, Req) ->
    cowboy_req:reply(400, [], <<"Missing parameter.">>, Req);
echo(Echo, Req) ->
    cowboy_req:reply(200, [
			        {<<"content-type">>, <<"text/plain; charset=utf-8">>}
	    			    ], Echo, Req).

terminate(_Reason, _Req, _State) ->
	ok.

