move(state(middle,on_box,middle,false),
     grasp,
     state(middle,on_box,middle,true)).

move(state(Pos,on_floor,Pos,Has),
     climb,
     state(Pos,on_box,Pos,Has)).

move(state(_,on_floor,BPos,Has),
     push(BPos,NewPos),
     state(NewPos,on_floor,NewPos,Has)).

move(state(_,on_floor,BPos,Has),
     walk(NewPos),
     state(NewPos,on_floor,BPos,Has)).

can_get(state(_,_,_,true)).
can_get(State) :-
    move(State,_,NextState),
    can_get(NextState).