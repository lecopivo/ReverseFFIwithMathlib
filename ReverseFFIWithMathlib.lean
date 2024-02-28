import Std.Data.RBMap.Basic

@[export min_number]
def minNumber (x y z : USize) : Float := 
  let map : Std.RBSet USize compare := Std.RBSet.ofList [x,y,z] _
  (map.toList.head!).toUInt64.toFloat
