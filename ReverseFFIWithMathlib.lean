import Batteries.Data.RBMap.Basic

@[export min_number]
def minNumber (x y z : USize) : Float :=
  let map : Batteries.RBSet USize compare := Batteries.RBSet.ofList [x,y,z] _
  (map.toList.head!).toUInt64.toFloat
