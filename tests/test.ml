open Tagless.Tag;;


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

let () = 
  begin 
    let x = ((num 5) : int eval) in 
    let y = add (num 10) x in
    assert (15 = y.unEval); 
    let z = add ((num 10) : int pretty_print) (num 5) in
    assert ("(10 + 5)" = z.unPrettyPrint);
  end;;



