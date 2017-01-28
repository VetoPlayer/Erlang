% Binary trees in Erlang
-module(tree).
-compile(export_all).

% Nodes are tuples of the form {anode, {key, value, [Branches]+}}



empty() -> {anode, 'nil'}.



% Let's insert things inside the tree:

insert(Key, Val, {anode, 'nil'}) -> {anode, {Key, Val, {anode, 'nil'} , {anode, 'nil'}}};
insert(NewKey, NewVal, {anode, {Key, Value, Right, Left}}) when NewKey > Key ->
        {Key, Value,instert(NewKey, NewVal, Left ), Right};
insert(NewKey, NewVal, {anode, {Key, Value, Right, Left}}) when NewKey < Key ->
        {Key, Value,Left,instert(NewKey, NewVal, Right)};
insert(Key, Val, {anode, {Key, _, Left, Right}}) -> 
        {anode, {Key, Val, Left, Right}}.   
        
        

lookup(_, {anode, 'nil'}) ->
	undefined;
lookup(Key, {anode, {Key, Val, _, _}}) ->
	{ok, Val};
lookup(Key, {anode, {NodeKey, _, Left, _}}) when Key < NodeKey ->
	lookup(Key, Left);
lookup(Key, {anode, {_, _, _, Right}}) -> %all the other cases
lookup(Key, Right).
