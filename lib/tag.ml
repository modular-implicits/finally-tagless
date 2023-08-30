
module type Arithmetic = sig
  type 'a t 
  val num : int -> int t
  val add : int t -> int t -> int t
  val mul : int t -> int t -> int t
end

let num {A : Arithmetic} = A.num
let add {A : Arithmetic} = A.add
let mul {A : Arithmetic} = A.mul

type 'a eval = {unEval : int}

(* This is currently hiding the implementation type which is not what I want*)

implicit module EvalInterpreter : Arithmetic with type 'a t = 'a eval = struct
  type 'a t = 'a eval
  let num x = { unEval = x }
  let add x y = { unEval = (x.unEval + y.unEval) }
  let mul x y = { unEval = (x.unEval * y.unEval) }
end

type 'a pretty_print = {unPrettyPrint : string}


implicit module PrettyPrintInterpreter : Arithmetic with type 'a t = 'a pretty_print = struct
  type 'a t = 'a pretty_print
  let num x = { unPrettyPrint = string_of_int x }
  let add x y = { unPrettyPrint = "(" ^ x.unPrettyPrint ^ " + " ^ y.unPrettyPrint ^ ")" }
  let mul x y = { unPrettyPrint = "(" ^ x.unPrettyPrint ^ " * " ^ y.unPrettyPrint ^ ")" }
end
