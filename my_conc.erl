-module(my_conc).
-export([start/2, start/0, my_spawn/3, startSpawn/0, test_func/0, startClock/3, my_spawn_clock/3, print/0, my_monitor/0, test/0, welcome_message/1]).

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

my_spawn(Mod,Fun, Args) ->
    Pid = spawn(Mod, Fun, Args),
    statistics(wall_clock),
    on_exit(Pid, Fun),
    Pid.

on_exit(Pid, Fun) ->
    spawn(fun() ->
		  Ref = monitor(process, Pid),     %% <label id="code.onexit2"/>
		  receive
		        {'DOWN',Ref, process, Pid, Why} ->
                {_, Time1} = statistics(wall_clock),
                io:format("Process spawn time = ~p microsecond ~n",[Time1]),
                Fun(Why)
		  end
	  end).

test_func() ->
    receive
        X -> list_to_atom(X)
    end.

print() ->
    io:format("Function works!~n").

my_spawn_clock(Mod,Fun, Args) ->
    Pid = spawn(Mod, Fun, Args),

    startClock(Pid, 5000, Fun),
    Pid.

startSpawn() ->
    % Pid = 2my_spawn(my_conc, test_func, []),
    % Pid ! error.
    Pid = my_spawn_clock(my_conc, print, []).

startClock(Pid, Time, Fun) ->
    register(clock, spawn(fun() -> tick(Pid, Time, Fun) end)).

stop() -> clock ! stop.

tick(Pid, Time, Fun) ->

    receive
	stop ->
	    void
    after Time ->
       exit(Pid, "It is just time to die"),
       stop()
    end.

keep_alive(Name, Fun) ->
    Pid = start2(Name, 5000, Fun),
    on_exit(Pid, fun(_Why) ->
            io:format("Restarting!~n"),
            keep_alive(Name, Fun)
        end
    ),
    Pid.

start2(Name,Time, Fun) ->
    register(Name, Pid = spawn(fun() -> tick2(Time, Fun) end)),
    Pid.

tick2(Time, Fun) ->
    receive
	stop ->
	    void
    after Time ->
	    Fun(),
	    tick2(Time, Fun)
    end.

my_monitor() ->
    Fun = fun() -> io:format("Still alive!~n") end,
    Pid = keep_alive(myProcess, Fun),
    exit(Pid, "Test").

on_exit2(Pid, X) ->
    spawn(fun() ->
		  Ref = monitor(process, Pid),     %% <label id="code.onexit2"/>
		  receive
		        {'DOWN',Ref, process, Pid, Why} ->
                io:format("Restarting ~n"),
                spawn(my_conc,welcome_message, [X])
		  end
	  end).


on_exit3(Pid, X) ->
    spawn(fun() ->
		  Ref = monitor(process, Pid),     %% <label id="code.onexit2"/>
		  receive
		        {'DOWN',Ref, process, Pid, Why} ->
                io:format("Died #~p - ~p ~n", [X, Why]),
                spawn(my_conc,welcome_message, [X]),
                io:format("Restarted ~p ~n", [X])
		  end
	  end).

welcome_message(X) ->
        io:format("Welcome Process #~p~n!", [X]).

test() ->
    Pid1 = spawn_link(my_conc, welcome_message, [1]),
    Pid2 = spawn_link(my_conc, welcome_message, [2]),
    on_exit3(Pid1, 1),
    on_exit3(Pid2, 2).
