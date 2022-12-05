-module(types).
-export([f/1, test/0]).

-spec f(non_neg_integer()) -> pos_integer().

f(Param) when is_integer(Param) -> Param.

test() -> f([1,2,3]).