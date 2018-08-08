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

  %   Define a predicate grandparent/2.

  % ?- grandparent(abe,X).
  % X = bart ;
  % X = lisa ;
  % X = maggie .
  
  % ?- grandparent(X,ling).
  % X = clancy ;
  % X = jackie .
  % Define a predicate sibling/2. Siblings share at least one parent.

grandparent(X,Y) :- parent(X,Z),parent(Z,Y).
  
  % ?- sibling(homer,X).
  % X = herb .
  
  % ?- sibling(X,lisa).
  % X = bart ;
  % X = maggie .
  % Define two predicates brother/2 and sister/2.
sibling(X,Y) :- parent(Z,X),parent(Z,Y), X \= Y.  

  % ?- sister(lisa,X).
  % X = bart ;
  % X = maggie .

  % ?- sister(X,lisa).
  % X = maggie .
sister(X,Y) :- sibling(X,Y),female(X).
  % ?- brother(bart,X).
  % X = lisa ;
  % X = maggie .
  
  % ?- brother(X,bart).
  % false.
  % Define a predicate siblingInLaw/2. A sibling-in-law is either married to a sibling or the sibling of a spouse.
brother(X,Y) :- sibling(X,Y),male(X).
  % ?- siblingInLaw(selma,X).
  % X = homer .
  
  % ?- siblingInLaw(marge,X).
  % X = herb .
  
  % ?- siblingInLaw(X,homer).
  % X = patty ;
  % X = selma .

siblingInLaw(X,Y) :- sibling(Z,Y),married(X,Z).
siblingInLaw(X,Y) :- sibling(X,Z),married(Z,Y).

  % Define two predicates aunt/2 and uncle/2. Your definitions of these predicates should include aunts and uncles by marriage.
  
  % ?- aunt(patty,X).
  % X = bart ;
  % X = lisa ;
  % X = maggie ;
  % X = ling .
aunt(X,Y) :- (sibling(X,Z);siblingInLaw(X,Z)),parent(Z,Y),female(X).


  % ?- uncle(X,ling).
  % X = homer .
uncle(X,Y) :- (sibling(X,Z);siblingInLaw(X,Z)),parent(Z,Y),male(X).  
  % Define the predicate cousin/2.
  % ?- cousin(maggie,X).
  % X = ling .
  
  % ?- cousin(X,ling).
  % X = bart ;
  % X = lisa ;
  % X = maggie .
cousin(X,Y) :- child(X,Z), sibling(Z,W), parent(W,Y).
  % Define the predicate ancestor/2.
  
  % ?- ancestor(abe,X).
  % X = herb ;
  % X = homer ;
  % X = bart ;
  % X = lisa ;
  % X = maggie .
  
  % ?- ancestor(X,lisa).
  % X = homer ;
  % X = marge ;
  % X = abe ;
  % X = mona ;
  % X = clancy ;
  % X = jackie .

ancestor(X,Y) :- parent(X,Y);
                (parent(X,Z),parent(Z,Y)).
                    

  % Extra Credit: Define the predicate related/2. This predicate should be true for any two people connected by a family tree, no matter how distantly. Therefore, a query such as related(herb,X) should enumerate every other person in the tree.
  
  % The challenge in this problem is structuring your predicate in a way that enumerates all members of the tree and doesn’t infinitely loop. You may want to use a helper predicate.
  
  % (Note: my solution does not infinitely loop, but also never stops finding solutions. If someone can produce a better implementation, bonus bonus points!)
related(X, Y) :- ancestor(X, Y).
related(X, Y) :- ancestor(Y, X).
related(X, Y) :- cousin(X, Y).
related(X, Y) :- cousin(Y, X).
related(X, Y) :- aunt(X, Y).
related(X, Y) :- aunt(Y, X).
related(X, Y) :- uncle(X, Y).
related(X, Y) :- uncle(Y, X).
related(X, Y) :- siblingInLaw(X, Y).
related(X, Y) :- siblingInLaw(Y, X).
related(X, Y) :- sibling(X, Y).
related(X, Y) :- sibling(Y, X).
related(X, Y) :- married(X, Y).
related(X, Y) :- married(Y, X).