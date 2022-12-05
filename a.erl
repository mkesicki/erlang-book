-module(a).

-type font() :: integer().
-opaque rich_text() :: [{font(), char()}].

-export_type([rich_text/0]).
-export([make_text/1, bounding_box/1]).

-spec make_text(string()) -> rich_text().
-spec bounding_box(rich_text()) -> {Height::integer(), Width::integer()}.

make_text(Text) -> rich_text().
bounding_box([{A, B}]) -> {A, B}.

rich_text() -> [{10,20}].

