-module(terl_webs_dispatchers).

-export([
    init_dispatchers_storage/0,
    add_dispatcher/2,
    get_dispatcher/1,
    remove_dispatcher/1,
    get_dispatcher_tokens/1
]).

init_dispatchers_storage() ->
    ets:new(?MODULE, [public, named_table]).

add_dispatcher(UpdateToken, {_Module, _Function} = Dispatcher) ->
    ets:insert(?MODULE, {UpdateToken, Dispatcher}).

get_dispatcher(UpdateToken) ->
    ets:lookup_element(?MODULE, UpdateToken, 2).

remove_dispatcher(UpdateToken) ->
    ets:delete(?MODULE, UpdateToken).

get_dispatcher_tokens({_Module, _Function} = Dispatcher) ->
    lists:flatten(ets:match(?MODULE, {'$1', Dispatcher})).
