(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
(* a. Write a function all_except_option, which takes a string and a string
 list. Return NONE if the string is not in the list, else return SOME lst 
where lst is identical to the argument list except the string is not in it.
 You may assume the string is in the list at most once. Use same_string, 
provided to you,to compare strings. Sample solution is around 8 lines.*)
(* val all_except_option = fn : string * string list -> string list option *)
fun all_excep_option(opt, all) = 
    case all of
	[] => NONE
      | first::rest => if same_string(opt, first)
			       then SOME rest
			       else case all_excep_option(opt, rest) of
					NONE => NONE
				      | SOME aeo => SOME (first::aeo) 

(* b *)
fun get_substitutions1(subs, opt) =
    case subs of
	[] => []
     |  first::subs_rest => case all_excep_option(opt, first) of
			   NONE => (get_substitutions1(subs_rest, opt))
			 | SOME aeo =>  aeo@(get_substitutions1(subs_rest, opt))

(* c *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
