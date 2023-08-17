








(*
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
*)
module type Symantics = sig
  type 'dv repr
  val int : int  -> int repr
  val bool: bool -> bool repr
  val lam : ('da repr -> 'db repr) -> ('da -> 'db) repr
  val app : ('da -> 'db) repr -> 'da repr -> 'db repr
  val fix : ('x -> 'x) -> (('da -> 'db) repr as 'x)
  val add : int repr -> int repr -> int repr
  val mul : int repr -> int repr -> int repr
  val leq : int repr -> int repr -> bool repr
  val if_ : bool repr -> (unit -> 'x) -> (unit -> 'x) -> ('da repr as 'x)
end

let int {S : Symantics} = S.int
let bool {S : Symantics} = S.bool
let lam {S : Symantics} = S.lam
let app {S : Symantics} = S.app
let fix {S : Symantics} = S.fix
let add {S : Symantics} = S.add
let mul {S : Symantics} = S.mul
let leq {S : Symantics} = S.leq
let if_ {S : Symantics} = S.if_


(* This is fine but kind of meh, which is where implicits come in *)

implicit module EX {S: Symantics} = struct
  open S
  let test1 () = app (lam (fun x -> x)) (bool true)
  let testpowfix () =
       lam (fun x -> fix (fun self -> lam (fun n ->
        if_ (leq n (int 0)) (fun () -> int 1)
            (fun () -> mul x (app self (add n (int (-1))))))))
  let testpowfix7 = lam (fun x -> app (app (testpowfix ()) x) (int 7))
end


module R = struct 
  type 'a repr = 'a
  let int (x : int) = x
  let bool (x : bool) = x
  let lam f = f
  let app f x = f x
  let fix f = let rec self n = f self n in self
  let add x y = x + y
  let mul x y = x * y
  let leq x y = x <= y
  let if_ b t e = if b then t () else e ()
end

module EXR = EX {R}

module L = struct 
  type 'a repr = int 
  let int (x : int) = 1
  let bool (x : bool) = 1
  let lam f = f 0 + 1
  let app f x = f + x + 1
  let fix f = f 0 + 1
  let add x y = x + y + 1
  let mul x y = x * y + 1
  let leq x y = x + y + 1
  let if_ b t e = b + t () + e () + 1
  end 

(* Instead having to create a seperate module we can do this *)

let test1 {S : Symantics} () = app (lam (fun x -> x)) (bool true)

(* Instead of needing something like this we can then do *)
let x = let module E = EX {L} in E.test1 ()

(* We can do this instead! *)
let x = test1 {R} ()