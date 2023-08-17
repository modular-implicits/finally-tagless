









module type Symantics = sig
  type 'a repr
  val int : int -> 'c * int repr
  val bool : bool -> 'c * bool repr
  val lam : ('c * 'da repr -> 'c * 'db repr) -> 'c * ('da -> 'db) repr
  val app : ('c * ('da -> 'db) repr) -> ('c * 'da repr) -> 'c * 'db repr
  val fix : ('x -> 'x) -> (('c * ('da -> 'db) repr) as 'x)
  val add : ('c * int repr) -> ('c * int repr) -> 'c * int repr
  val mul : ('c * int repr) -> ('c * int repr) -> 'c * int repr
  val leq : ('c * int repr) -> ('c * int repr) -> 'c * bool repr
  val if_ : ('c * bool repr) -> (unit -> 'x) -> (unit -> 'x)
              -> (('c * 'da repr) as 'x)
end