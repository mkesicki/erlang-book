-module(try_test).
-export([demo/0, generate_exception/1]).

generate_exception(5) -> error(a).

demo() ->

    try generate_exception(5)
    catch
        error:X:Stacktrace ->
            {
                {"Error message", X, error, "OOPS Something wrong happened."},
                {"Detail error:", X, error, Stacktrace}
            }
    end.
