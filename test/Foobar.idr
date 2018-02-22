module Foobar

data Vect : Nat -> ty -> Type where
  Nil : Vect Z ty
  (::) : (element : ty)
      -> (rest    : Vect length ty)
      -> Vect (S length) ty

vectMap : (func : typeA -> typeB) -> (input : Vect length typeA) -> Vect length typeB
vectMap f Nil     = Nil
vectMap f (x::xs) = f x :: vectMap f xs


myFirstVect : Vect 2 Int
myFirstVect = [1,10]

mySecondVect : Vect 2 Bool
mySecondVect = vectMap (\x => x > 5) myFirstVect


namespace Main
  main : IO ()
  main = do
    putStrLn "My First IO"
    printLn 12345
