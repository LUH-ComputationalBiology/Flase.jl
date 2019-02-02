using Flase

dog = Flase.Dog([1.,2.],[1.,0.])
motion = Flase.ConstVelocity( 0.5, 1. )
Flase.move( dog, 0.01, motion )
