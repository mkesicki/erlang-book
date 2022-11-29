-module(my_binary).
-export([reverse/1, reverse_bits/1, term_to_packet/1, packet_to_term/1, test/0]).

reverse(Bin) when is_binary(Bin) ->
    List = binary_to_list(Bin),
    lists:reverse(List).

reverse_bits(<<A:1, B:1, C:1, D:1, E:1, F:1, G:1, H:1>>) -> <<H:1, G:1, F:1, E:1, D:1, C:1, B:1, A:1>>.


term_to_packet(Term) ->
    Bin = term_to_binary(Term),
    split_binary(Bin, 4).


packet_to_term(Packet) ->
   {_, Body} = Packet,
   Body.


test() ->
    {<<131,107,0,4>>,<<"dupa">>} = term_to_packet("dupa"),
    <<"dupa">> = packet_to_term(term_to_packet("dupa")),
    test_worked.



