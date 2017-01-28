-module(actor).
-compile(export_all).

%% Clients communicate to the server and subscribe for a certain topic.

start() ->
        Pid = spawn(?MODULE, server, []),
        register(server, Pid), % Register the server Pid, so anybody can send messages to the server without explicitly having its ID.
        [spawn(?MODULE, client, [haskell]) || _ <- lists:seq(1,3)], % Starts the clients giving them as input a list)
        [spawn(?MODULE, client, [scheme]) || _ <- lists:seq(1,3)],
        [spawn(?MODULE, client, [erlang]) || _ <- lists:seq(1,3)].
        
        
        
        
client(T) ->
        server ! {subscribe, T, self()},
        client_loop(T).
        
        
        
client_loop(T) ->
        receive
                {publish, T, Msg} ->
                        io:format("I received the message ~s about ~w~n", [Msg,T]),
                        client_loop(T)
        end.
        
        


server() ->
        Map = #{ erlang => [], haskell => [], scheme => []},
        server_loop(Map, Map).
        
        
server_loop(Topics, Messages) ->
        receive
                {subscribe, Topic, Pid} ->
                io:format("Registering ~w for topic ~w~n", [Pid, Topic]),
                #{Topic := Pids} = Topics,
                server_loop(Topics#{Topic := [Pid|Pids]});
                {spread, Topic, Msg} ->
                        #{Topic := Pids} = Topics,
                        [P ! {publish, Topic, Msg} || P <- Pids],
                        server_loop(Topics, );
                        
        end.
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
