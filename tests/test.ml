open Tagless.Tag;;


let () = print_endline "Hello World";;

let () = 
  begin 
    let x = ((num 5) : int eval) in 
    let y = add (num 10) x in
    print_endline (string_of_int (y.unEval)); 
  end