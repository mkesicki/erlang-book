-module(my_make).
-export([tests/0]).

add(A, B) -> A + B.

sub(A, B) -> A - B.

multipy(A, B) -> A * B.

testAdd() ->
    3 = add(1,2),
    test_add_ok.

testSub() ->
    1 = sub(2,1),
    test_sub_ok.

testMultiply() ->
    3 = multipy(1,3),
    test_multipply_ok.

tests() ->
    io:format("Tests...~n"),
    test_add_ok = testAdd(),
    test_sub_ok = testSub(),
    test_multipply_ok=testMultiply(),
    io:format("Tests OK!~n").