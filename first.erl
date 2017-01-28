-module(first).
-compile(export_all).
% We export all for simplicity sake. In real world you should export only those functions intented as module inteface.

add(X,Y) ->
        X + Y.
        
        
helloWorld() -> io:format("Hello world!!~n").

% Boolean Guards:

greet(male, Name) ->
        io:format("Hello, mr. ~s ~n" , [Name]);
greet(female, Name) ->
        io:format("Hello, mrs. ~s ~n" , [Name]);
greet(_, Name) ->
        io:format("Hello, ~s ~n" , [Name]).
        
% Recursion:

fact(0) -> 1;
fact(N) -> N*fact(N - 1).


% bmi: when keyword is intented to looking forward different values of the variable:
bmi(H, W) when (H/W)*(H/W) < 18.5
        -> skinny;
bmi(H, W) when (H/W)*(H/W) >= 18.5
        -> fat.
        


% tail-recursive version of factorial:
tail_fact(N) -> tail_fact(N, 1). % We define another function, the tail recursive helper that we do not expose outside our module.
tail_fact(0,Accum) -> Accum; 
tail_fact(N,Accum) -> tail_fact(N-1,Accum*N). 

% Compute the length of a list, tail recursive version:

mylstlength(Lst) -> tail_length(Lst, 0). % . When you finish that function.
tail_length([], Length) -> Length;
tail_length([_|T], Length) -> tail_length(T, Length + 1).


% Quicksort


quicksort([]) -> [];
quicksort([Pivot| Rest]) -> { Smaller, Larger} = partition (Rest, Pivot, [] , []),
                        quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).


% Partition is tail recursive: 3° argument: Smaller, 4° argument: Larger

partition([],_, Smaller, Larger) -> {Smaller, Larger};
partition([H|T], Pivot, Smaller, Larger) ->
                                if H =< Pivot -> partition(T, Pivot, [H | Smaller], Larger);
                                   H > Pivot -> partition(T,Pivot, Smaller, [H | Larger])
                                end. 

% Higher Order Functions:

increment(X) -> X + 1.


%% Map
map(_,[]) -> [];
map(F, [H|T]) -> [F(H)|map(F,T)]. 


%% Filter
filter(_,[]) -> [];
filter(Predicate, [H|T]) ->
                           case Predicate(H) of
                              true -> [H | filter(Predicate,T)];
                              false -> filter(Predicate,T)
                            end.


odd(X) -> if X rem 2 =/= 0 ->
                true;
             true -> false
          end.

%% To use it, the terminal wants to know that you are passing a function to map, and not a generic atom!!

%% you need to call map as: first:map(fun first:increment/1, [1,2,3]).


foldL(_,Accum, []) -> Accum;
foldL(Funct,Accum, [H|T]) -> foldL(Funct, Funct(H,Accum) , T).


foldR(_,Accum, []) -> Accum;
foldR(Funct, Accum, [H|[]]) -> Funct(H, Accum);
foldR(Funct, Accum, [H|T]) -> Funct(H, foldR(Funct, Accum, T)).



reverseL(List) ->
        foldL(fun(X,Accum) -> [X|Accum] end,[], List).

reverseR(List) ->
        foldR(fun(X,Accum) -> Accum ++ [X] end, [], List).



map2(F,L) ->
        lists:reverse(foldL(fun(X,Acc) -> [F(X)|Acc] end, [], L)).



map3(F,L) -> 
        lists:reverse(foldR(fun(X,Accum) -> [F(X)|Accum] end, [], L)).






%% Defining λ
%% let's have some fun()

base(A) ->
        B = A + 1,
        F = fun() -> A * B end,
        F().







 

























