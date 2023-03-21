-module(cpu).
-export([print/0]).


print() ->
    os:cmd("wmic cpu get caption").