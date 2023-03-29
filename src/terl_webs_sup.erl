%%%-------------------------------------------------------------------
%% @doc terl_webs top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(terl_webs_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
init([]) ->
    terl_webs_dispatchers:init_dispatchers_storage(),
    SupFlags = #{
        strategy => one_for_all,
        intensity => 0,
        period => 1
    },
    ElliOpts = [{callback, terl_webs_cb}, {port, 8080}],
    ChildSpecs = [
        #{
            id => elli,
            start => {elli, start_link, [ElliOpts]}
        }
    ],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
