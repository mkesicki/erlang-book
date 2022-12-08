-module(my_benchmark).
-export([start/1, cancel/1, init/1]).

start(Message) -> spawn(fun() -> message(Message) end).
cancel(Pid) -> Pid ! cancel.

message(Message) ->
    receive
        send ->
            io:format("Message: ~p~p~n", [Message, erlang:timestamp()])
    end.

init(N) ->
    Pids = [],
    init(N, Pids).

init(0, Pids) when is_list(Pids) ->

    [H | T] = Pids,
    H ! send,
    Size = length(T),

    if  Size > 0 ->
        init(0, T);
        true -> true
    end;

init(N, Pids) ->
    Message = "My Message " ++ integer_to_list(N),
    Pid = start(Message),
    init(N-1, Pids ++ [Pid] ).
    % Pid ! send.
