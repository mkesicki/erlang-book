-module(my_tuple).
-export([my_tuple_to_list/1]).

my_tuple_to_list({}) -> [];

my_tuple_to_list(X) when is_tuple(X) ->
    [element(1,X) | my_tuple_to_list(erlang:delete_element(1, X))].