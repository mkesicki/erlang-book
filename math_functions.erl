-module(math_functions).
-export([even/1, odd/1, filter/2]).

even(X) -> X rem 2 == 0.

odd(X) -> X rem 2 /= 0.

filter(F, []) -> [];
filter(F,L) when is_function(F) ->

    [Head | Tail] = L,
    Check = F(Head),

    if
        Check == true -> [Head | filter(F, Tail)];
        true -> filter(F, Tail)
    end.

 

