-module(chapter2).
-export([my_time_func/1, my_date_string/0]).

my_time_func(F) when is_function(F)->
    [erlang:timestamp(),F(),erlang:timestamp()].

my_date_string() ->
    {{Year, Month, Day}, {Hour, Minute, Second}} = erlang:localtime(),
    io:format("Current time is: ~4..0w-~2..0w-~2..0w ~2..0w:~2..0w:~2..0w~n", [Year, Month, Day, Hour, Minute, Second]).




