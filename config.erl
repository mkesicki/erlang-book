-module(config).
-export([read/0, parse_map/1,parse_element/1, is_valid/1, map_search_pred/2]).

read() ->
   {ok, File} = file:read_file("settings.json"),

  Data=parse_map(File),
  Map=maps:from_list(Data),

  is_valid(Map).

parse_map(Bin) when is_binary(Bin) ->
   Bin,
   parse_map(binary_to_list(Bin));

parse_map([]) -> [];

parse_map(List) when is_list(List) ->

  Tokens = [string:trim(X,both,"{}") || X <-string:split(List,"},")],
  [H | T] = Tokens,

  Settings =  [string:trim(X) || X <-string:tokens(H,"\n")],
  [_, Name | Params] = Settings,

    [{string:trim(Name,both,", :\r\n{}\""), parse_element(Params)}  | parse_map(T)].

parse_element([H|T]) ->

   if length(T) > 1 ->
     [erlang:list_to_tuple(string:split(string:trim(H,both,",\""),":")) | parse_element(T)];
     true -> [erlang:list_to_tuple(string:split(string:trim(H,both,",\r\n\"{}"),":"))]
   end;

parse_element([]) -> [].

is_valid(Config) ->

   Size = maps:size(Config),

   Result = if Size == 3 ->
      true;
      true -> false
   end,

   Key = maps:is_key("settings", Config),

   Result2 = if Key == true ->
      true;
      true -> false
   end,

   Predicate = fun(E) -> E == true end,

   [lists:all(Predicate, [Result, Result2]), Config].

map_search_pred(Map, Pred) when is_map(Map) ->
   Maps =   maps:filter(Pred,Map),
   List = maps:to_list(Maps),

   [H|_]  = List,
   H.


