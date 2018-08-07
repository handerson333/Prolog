male({
  abe,clancy,
  herb,homer,
  bart
  }).

female({
    mona,jackie,
    marge,patty,selma,
    lisa,maggie,ling
  }).

smarried(abe,mona).
smarried(clancy,jackie).
smarried(marge,homer).

married(X,Y) :- smarried(X,Y).
married(X,Y) :- smarried(Y,X).

sibling(marge,patty,selma).
sibling(bart,lisa,maggie).
sibling(herb,homer).

siblings(X,Y,Z) :- sibling(X,Y,Z).
siblings(X,Y,Z) :- sibling(X,Z,Y).
siblings(X,Y,Z) :- sibling(Y,X,Z).
siblings(X,Y,Z) :- sibling(Y,Z,X).
siblings(X,Y,Z) :- sibling(Z,Y,X).
siblings(X,Y,Z) :- sibling(Z,X,Y).
siblings(X,Y)   :- sibling(X,Y).
siblings(X,Y)   :- sibling(Y,X).
