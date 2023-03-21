-module(file_info).
-export([compare/1, checksum/1, checksum2/1, find/1]).
-include_lib("kernel/include/file.hrl").

% -define(BLOCKSIZE, 32768).
-define(BLOCKSIZE, 10485760).


% https://github.com/everpeace/programming-erlang-code/blob/master/code/lib_md5.erl

compare(File) ->
    {ok, BInfo} = file:read_file_info(File ++ ".beam"),

    io:format("Binfo ~p~n", [BInfo#file_info.mtime]),
    {ok, EInfo} = file:read_file_info(File ++ ".erl"),
    io:format("EInfo ~p~n", [EInfo#file_info.mtime]),

    if BInfo#file_info.mtime /= EInfo#file_info.mtime ->  io:format("Compile file~n");
        true ->  io:format("Do not need to compile~n")
    end.

checksum(File) ->

        {ok, Data} = file:read_file(File),
        Hash = erlang:md5(Data),
        binary:encode_hex(Hash).



process_lines(F, Context) ->
    case file:read(F, ?BLOCKSIZE) of

        {ok, Line} ->
            %% do something with Line
            NewContext = erlang:md5_update(Context, Line),
            process_lines(F, NewContext);

        eof ->

            file:close(F),
            Hash = erlang:md5_final(Context),
            binary:encode_hex(Hash)
    end.

checksum2(File) ->
    {ok, F} = file:open(File, [read,binary,raw]),
    process_lines(F, erlang:md5_init()).

hash([], _, Duplicates) ->

     io:format("Found duplicates: ~p~n", [Duplicates]);
    % Duplicates;
hash(Files, Hashes, Duplicates) ->

    [File | T ] = Files,
    A = binary_to_list(checksum(File)),
    NewHashes = lists:append([A], Hashes),
        %  lists:append([{A, File}], Hashes),

         io:format("Processing file: ~p~n", [File]),

        case lists:member(A, Hashes) of
            true ->
                NewDuplicates = lists:append([{A, File}], Duplicates);
            false ->
                NewDuplicates = Duplicates
        end,

    hash(T, NewHashes, NewDuplicates).

find(Dir) ->
    Files = lib_find:files(Dir, "*.jpg", true),
    hash(Files, [], []).