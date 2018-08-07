hobbit(bilbo, rivendell).
hobbit(frodo, hobbiton).
hobbit(sam, hobbiton).

alive(frodo) :- hobbit(frodo).
stupidFatHobbit(sam) :- hobbit(sam).
foolOfATook(pippin) :- hobbit(pippin).
place(L) :- hobbit(_,L).

hobbit(X) :- hobbit(X,_).


likes(sam,frodo).
likes(frodo,sam).
likes(bilbo,ring).
likes(frodo,ring).

likes(X,beer) :- hobbit(X).
hobbit{bilbo,frodo,sam,merry,pippin}
place{rivendell,mordor,isengaard,hobbiton,shire,fangorn}

likes{(sam,frodo),(bilbo,frodo)}
