
module type Repr = sig 
  type 'a t
end


module type Arithmetic = sig
  type 'a t 
  val num : int -> int t
  val add : int t -> int t -> int t
  val mul : int t -> int t -> int t
end

type 'a eval = Eval of 'a

implicit module EvalInterpreter : Arithmetic = struct
  type 'a t = 'a eval
  let num x = Eval x
  let add (Eval x) (Eval y) = Eval (x + y)
  let mul (Eval x) (Eval y) = Eval (x * y)
end

type 'a pretty_print = PrettyPrint of string

implicit module PrettyPrintInterpreter : Arithmetic = struct
  type 'a t = 'a pretty_print
  let num x = PrettyPrint (string_of_int x)
  let add (PrettyPrint x) (PrettyPrint y) = PrettyPrint ("(" ^ x ^ " + " ^ y ^ ")")
  let mul (PrettyPrint x) (PrettyPrint y) = PrettyPrint ("(" ^ x ^ " * " ^ y ^ ")")
end


