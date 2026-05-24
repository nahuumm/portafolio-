can_cook(priya).
can_cook(jasmin).
can_cook(timoteo).
likes(priya,jasmin) :- can_cook(jasmin).
likes(priya,timoteo) :- can_cook(timoteo).