-module(myfile).
-export([read/1]).

read(File) ->
    {ok, FileInfo} = file:read_file_info(File),
    % FileInfo = element(0,data),
    Mode = element(4,FileInfo),
    % Mode.

    FP = if
        Mode == read -> file:read_file(File);
        Mode  == read_write -> file:read_file(File);
        true -> throw("File can not be read")
    end,
    FP.


