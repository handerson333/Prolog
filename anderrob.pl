% -- Robert Hayden Anderson
% -- anderrob
% -- anderrob@oregonstate.edu
% -- cs381
% -- summer 2018


male(abe).
male(clancy).
male(herb).
male(homer).
male(bart).

female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).
female(ling).


smarried(abe,mona).
smarried(clancy,jackie).
smarried(marge,homer).

married(X,Y) :- smarried(X,Y).
married(X,Y) :- smarried(Y,X).

parent(marge,bart).
parent(marge,lisa).
parent(marge,maggie).
parent(homer,bart).
parent(homer,lisa).
parent(homer,maggie).

parent(abe,homer).
parent(abe,herb).
parent(mona,homer).
parent(mona,herb).

parent(clancy,marge).
parent(clancy,patty).
parent(clancy,selma).
parent(jackie,marge).
parent(jackie,patty).
parent(jackie,selma).

parent(selma,ling).

child(X,Y) :- parent(Y,X).

isMother(X) :- child(_,X),female(X).
isFather(X) :- child(_,X),male(X).

grandparent(X,Y) :- parent(X,Z),parent(Z,Y).

sibling(X,Y) :- parent(Z,X),parent(Z,Y), \+X=Y.
sib5(X,Y) :- setof((X,Y), P^(parent(P,X),parent(P,Y), \+X=Y), Sibs),
  member((X,Y), Sibs),
  \+ (Y@<X, member((Y,X), Sibs)).  

sister(X,Y) :- sibling(X,Y),female(X).
brother(X,Y) :- sibling(X,Y),male(X).

siblingInLaw(X,Y) :- sibling(Z,Y),married(X,Z).
siblingInLaw(X,Y) :- sibling(X,Z),married(Z,Y).


aunt(X,Y) :- (sibling(X,Z);siblingInLaw(X,Z)),parent(Z,Y),female(X).
uncle(X,Y) :- (sibling(X,Z);siblingInLaw(X,Z)),parent(Z,Y),male(X).  

cousin(X,Y) :- child(X,Z), sibling(Z,W), parent(W,Y).
ancestor(X,Y) :- parent(X,Y);
                (parent(X,Z),ancestor(Z,Y)).
                    

  % Extra Credit: Define the predicate related/2. This predicate should be true for any two people connected by a family tree, no matter how distantly. Therefore, a query such as related(herb,X) should enumerate every other person in the tree.
  
  % The challenge in this problem is structuring your predicate in a way that enumerates all members of the tree and doesn’t infinitely loop. You may want to use a helper predicate.
  
  % (Note: my solution does not infinitely loop, but also never stops finding solutions. If someone can produce a better implementation, bonus bonus points!)
descendent(X, Y) :-
      parent(Y, X).
descendent(X, Y) :-
      parent(Z, X),
      descendent(Z, Y).
  
bloodRelative(X, Y) :-
      descendent(Y, X).
bloodRelative(X, Y) :-
      descendent(X, Y).
bloodRelative(X, Y) :-
      descendent(X, Z),
      descendent(Y, Z),
      X \= Y.

related(X, Y) :- bloodRelative(X, Y).
related(X, Y) :- ancestor(X, Z), married(Z, W), bloodRelative(W, Y).
related(X, Y) :- descendent(X, Z), married(Z, W), bloodRelative(W, Y).
% % relative( X , Y ) :- ancestor( Z , X ) , ancestor( Z , Y ).
% % related(X, Y) :- related(X,Z),married(Z,Y),!.
% related(X, Y) :- ancestor(X, Y).
% related(X, Y) :- ancestor(Y, X).
% % related(X, Y) :- descendent(X, Y).
% % related(X, Y) :- descendent(Y, X).
% related(X, Y) :- cousin(X, Y).
% related(X, Y) :- cousin(Y, X).
% related(X, Y) :- aunt(X, Y).
% related(X, Y) :- aunt(Y, X).
% related(X, Y) :- uncle(X, Y).
% related(X, Y) :- uncle(Y, X).
% related(X, Y) :- siblingInLaw(X, Y).
% related(X, Y) :- siblingInLaw(Y, X).
% related(X, Y) :- sibling(X, Y).
% related(X, Y) :- sibling(Y, X).
% related(X, Y) :- married(X, Y).
% related(X, Y) :- married(Y, X).
% % call bloodRelated on the married parent or child


% cmd/3
cmd(N, T, [ N | T ]) :- number(N).
cmd(S, T, [ S | T ]) :- string(S).

cmd(t, T, [ t | T ]).
cmd(f, T, [ f | T ]).

cmd(add, [ L, R | T ], [ H | T ]) :- number(L), number(R), H is L + R.

cmd(lte, [ L, R | T ], [ t | T ]) :- number(L), number(R), L =< R.
cmd(lte, [ L, R | T ], [ f | T ]) :- number(L), number(R), L > R.

cmd(if(L, _), [ t | T ], H) :- prog(L, T, H).
cmd(if(_, R), [ f | T ], H) :- prog(R, T, H).


prog([H]  , S, S2) :- cmd(H, S, S2).
prog([H|T], S, S2) :- cmd(H, S, S3), prog(T, S3, S2).