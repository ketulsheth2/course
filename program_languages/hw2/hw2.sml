(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
(* a *)
fun all_except_option(opt, all) = 
    case all of
	[] => NONE
      | first::rest => if same_string(opt, first)
			       then SOME rest
			       else case all_except_option(opt, rest) of
					NONE => NONE
				      | SOME aeo => SOME (first::aeo) 
(* b *)
fun get_substitutions1(subs, opt) =
    case subs of
	[] => []
     |  first::subs_rest => case all_except_option(opt, first) of
			   NONE => (get_substitutions1(subs_rest, opt))
			 | SOME aeo =>  aeo@(get_substitutions1(subs_rest, opt))
(* c *)
fun get_substitutions2(subs, opt) =
    let 
	fun get_sub(got, subs_rest) =
	    case subs_rest of
		[] => got
	     |  first::subs_rest => case all_except_option(opt, first) of
					NONE => get_sub(got, subs_rest)
				      | SOME aeo =>  get_sub(got@aeo, subs_rest)	    
    in
	get_sub([], subs)
    end
(* d *)
fun similar_names(subs, fullname) = 
    let 
	fun othernames(candidate, mid, lst) =
	    case candidate of
		[] => []
	      | fst::rst => [{first=fst, middle=mid, last=lst}]@othernames(rst, mid, lst)
    in
	case fullname of
	    {first, middle, last} => [fullname]@othernames(get_substitutions1(subs, first), middle, last)
    end						  
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove
	      
(* put your solutions for problem 2 here *)
(* a *)
fun card_color(xcard) =
    case xcard of 
	(Spades, x) => Black
     |  (Clubs, x) => Black
     |  (Hearts, x) => Red
     |  (Diamonds, x) => Red
(* b *)		      
fun card_value(xcard)=
    case xcard of
	(x, Jack) => 10
      | (x, Queen) => 10
      | (x, King) => 10
      | (x, Ace) => 11
      | (x, Num i) => i
(* c *)
fun remove_card(cs, c, e)=
    case cs of
	[] => raise e
     |  x::cs => if x = c then cs
		 else x::remove_card(cs, c, e)
(* d *)
fun all_same_color(cs)=
    case cs of
	[] => true
      | c1::cs1 => case cs1 of
		      [] => true
		    | c2::cs2 => card_color(c1) = card_color(c2) andalso all_same_color(cs1) 
(* e *)
fun sum_cards(cs)=
    let
	fun sum_cards_tail(sum, rest_cs)=
	    case rest_cs of
		[] => sum
	      | c::rest_cs => sum_cards_tail(sum+card_value(c), rest_cs)
    in
	sum_cards_tail(0, cs)
    end
(* f *)
fun score(cs, goal)=
    let 
	val sum = sum_cards(cs)
	val score = if sum > goal then (sum - goal) + (sum - goal) + (sum - goal) (* what's the MUL operator? *)
		    else goal - sum
    in
	if all_same_color(cs) then score div 2
	else score
    end
(* g *)
fun officiate(cs, ms, goal)=
    let
	val heldcards = []
	fun play(hs, cs2, ms)=
	    case ms of
		[] => score(hs, goal)
	      | Draw::ms => 
		let 
		in
		    case cs2 of
			[] => score(hs, goal)
		      | c::cs2 => if sum_cards(c::hs) > goal then score(c::hs, goal)
				  else play(c::hs, cs2, ms)
		end
	      | Discard c::ms => play(remove_card(hs, c, IllegalMove), cs2,ms) 
    in
	play(heldcards, cs, ms)
    end
