-module(math_functions).
-export([even/1, odd/1, filter/2, split/1, acc_evens_odds/3, split2/1]).

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

split(L) -> acc_evens_odds(L, [], []).

acc_evens_odds([H|T], Odds, Evens) ->

   case (H rem 2) of
       1 -> acc_evens_odds(T, [H|Odds], Evens);
       0 -> acc_evens_odds(T, Odds, [H|Evens])
   end;

acc_evens_odds([], Evens, Odds) -> {Evens, Odds}.

split2(L) ->

    Even = fun(X) -> X rem 2 == 0 end,
    Odd = fun(X) -> X rem 2 /= 0 end,
    {filter(Even, L),filter(Odd,L)}.

