open Tagless.Tag;;


let () = print_endline "Hello World";;

(* Slightly takes away from the beauty that you have to state the 
    type of the representation *)

let () = 
  begin 
    let x = ((num 5) : int eval) in 
    let y = add (num 10) x in
    assert (15 = y.unEval); 
    let z = add ((num 10) : int pretty_print) (num 5) in
    assert ("(10 + 5)" = z.unPrettyPrint);
end