-module(terl_webs_cb).
-export([
    handle/2,
    handle_event/3
]).

-include_lib("elli/include/elli.hrl").
-include_lib("kernel/include/logger.hrl").

-behaviour(elli_handler).

handle(Req, _Args) ->
    handle(Req#req.method, elli_request:path(Req), Req).

handle('POST', [<<"update">>], Req) ->
    Update = njson:decode(Req#req.body),
    Headers = Req#req.headers,
    case proplists:lookup(<<"X-Telegram-Bot-Api-Secret-Token">>, Headers) of
        none ->
            ?LOG_ALERT("No token on update ~s", [Update]);
        {_Key, UpdateToken} ->
            case terl_webs_dispatchers:get_dispatcher(UpdateToken) of
                {ok, {Module, Function}} ->
                    Module:Function(Update);
                _ ->
                    ?LOG_ALERT("Unexpected token ~s for update ~s", [UpdateToken, Update])
            end
    end,
    {204, [], <<>>};
handle(_, _, _Req) ->
    {404, [], <<"Not Found">>}.

handle_event(_Event, _Data, _Args) ->
    ok.
