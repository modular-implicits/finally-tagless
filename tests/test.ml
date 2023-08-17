open Tagless.Tag;;
open Tagless.Symantics;;


let () = print_endline "Hello World";;

(* Slightly takes away from the beauty that you have to state the 
    type of the representation *)

(* This is very nice and works well *)
(* same data two different computations! *)
  
let () = 
  begin
    let x {M : Arithmetic} = M.add (M.num 5) (M.num 10) in
    let y = x {EvalInterpreter} in
    assert (15 = y.unEval);
    let z = x {PrettyPrintInterpreter} in
    assert ("(5 + 10)" = z.unPrettyPrint);
end;;

(* Using proper finally tagless with functions,
with implicits also works well here:*)

let () = 
    begin 
      let test1 {S : Symantics} () = app (lam (fun x -> x)) (bool true) in 
      let x = test1 {R} () in 
      assert (x);
      let x = test1 {L} () in
      assert (3 = x);
    end

(* Instead of needing something horrible like let x = let module E = EX {L} in E.test1 ()*)




