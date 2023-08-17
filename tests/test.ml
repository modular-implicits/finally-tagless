open Tagless.Tag;;


let () = print_endline "Hello World";;

let () = 
  begin 
    let x = num 5 in 
    print_endline (string_of_int (x.unEval)); 
  end