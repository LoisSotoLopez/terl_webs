-module(terl_webs).

-behaviour(application).

%%% START/STOP EXPORTS
-export([
    start/2,
    stop/1
]).

%%% PUBLIC EXPORTS
-export([
    add_dispatcher/2,
    get_dispatcher/1,
    remove_dispatcher/1,
    get_dispatcher_tokens/1
]).

%%% -----------------------------------------------------------------
%%% START/STOP EXPORTS
%%% -----------------------------------------------------------------
start(_StartType, _StartArgs) ->
    terl_webs_sup:start_link().

stop(_State) ->
    ok.

%%% -----------------------------------------------------------------
%%% PUBLIC EXPORTS
%%% -----------------------------------------------------------------
-spec add_dispatcher(UpdateToken, Dispatcher) -> Resp when
    UpdateToken :: binary(),
    Dispatcher :: {module(), atom()},
    Resp :: true.
add_dispatcher(UpdateToken, {_Module, _Function} = Dispatcher) ->
    terl_webs_dispatchers:add_dispatcher(UpdateToken, Dispatcher).

-spec get_dispatcher(UpdateToken) -> Resp when
    UpdateToken :: binary(),
    Resp :: {module(), atom()}.
get_dispatcher(UpdateToken) ->
    terl_webs_dispatchers:get_dispatcher(UpdateToken).

-spec remove_dispatcher(UpdateToken) -> Resp when
    UpdateToken :: binary(),
    Resp :: true.
remove_dispatcher(UpdateToken) ->
    terl_webs_dispatchers:remove_dispatcher(UpdateToken).

-spec get_dispatcher_tokens(Dispatcher) -> Resp when
    Dispatcher :: {module(), atom()},
    Resp :: [UpdateToken],
    UpdateToken :: binary().
get_dispatcher_tokens({_Module, _Function} = Dispatcher) ->
    terl_webs_dispatchers:get_dispatcher_tokens(Dispatcher).
