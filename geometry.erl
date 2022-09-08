-module(geometry).
-export([area/1]).
-export([perimeter/1]).

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side}) -> Side * Side;
area({circle, R}) -> 3.14 * R * R;
area({triangle, A, B}) -> A * B / 2.

perimeter({circle, R}) -> 2 * 3.14 * R;
perimeter({square, A}) -> 4 * A;
perimeter({triangle, A, B, C}) -> A + B + C.




