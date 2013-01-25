(* A date is a triple of year*month*day *)

fun is_valid(date : int*int*int) =
    if(#1 date) < 0 orelse (#2 date) < 0 orelse (#3 date) < 0 then false
    else if(#2 date) > 12 then false
    else if(#3 date) > 31 then false
    else true



fun is_older(date1 : int*int*int, date2 : int*int*int) =
    if(not(is_valid(date1)) orelse not(is_valid(date2))) then false
    else if((#1 date1) <> (#1 date2)) then (#1 date1) < (#1 date2)
    else if((#2 date1) <> (#2 date2)) then (#2 date1) < (#2 date2)
    else if((#3 date1) <> (#3 date2)) then (#3 date1) < (#3 date2)
    else false
	     
					       
	      

	    
