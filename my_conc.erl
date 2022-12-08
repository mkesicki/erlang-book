-module(my_conc).
-export([start/2, start/0]).

start(AnAtom, Fun) ->

    Exists = lists:member(AnAtom, registered()),

    if Exists == false ->
        Pid = spawn(Fun),
        register(AnAtom, Pid),
        [Pid]
    end.

start() ->

    Nada = fun() -> []  end,
    start(add,Nada).
