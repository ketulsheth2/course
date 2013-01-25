(* the version 0 *)
(* A date is a triple of year*month*day *)
fun is_older(date1 : int*int*int, date2 : int*int*int) =
    let
	fun is_valid(date : int*int*int) =
	    if(#1 date) < 0 orelse (#2 date) < 0 orelse (#3 date) < 0 then false
	    else if(#2 date) > 12 then false
	    else if(#3 date) > 31 then false
	    else true	
    in
    if(not(is_valid(date1)) orelse not(is_valid(date2))) then false
    else if((#1 date1) <> (#1 date2)) then (#1 date1) < (#1 date2)
    else if((#2 date1) <> (#2 date2)) then (#2 date1) < (#2 date2)
    else if((#3 date1) <> (#3 date2)) then (#3 date1) < (#3 date2)
    else false
    end
	     
					       
	      
fun number_in_month(dates : (int*int*int) list, month : int) =
    let 
	fun is_in(date : int*int*int, month : int)=
	    if(#2 date) = month then 1 else 0
    in
	if null(dates) then 0
	else is_in(hd(dates), month)+number_in_month(tl(dates), month)
    end

fun number_in_months(dates : (int*int*int) list, months : int list) =
    if(null(months)) then 0
    else number_in_month(dates, hd(months))+number_in_months(dates, tl(months))
	    

fun dates_in_month(dates : (int*int*int) list, month : int) =
    if null dates then []
    else 
	let 
	    val first = hd(dates)
	in
	    if(#2 first) = month 
	    then first :: dates_in_month(tl(dates), month)
	    else dates_in_month(tl(dates), month)
	end

fun dates_in_months(dates : (int*int*int) list, months : int list)=
    if null months then []
    else dates_in_month(dates, hd months)@dates_in_months(dates, tl months)

fun get_nth(strs : string list, n : int) =
    if n = 1 then hd strs
    else get_nth(tl strs, n - 1)

fun date_to_string(date : int*int*int)=
    let
	val months = ["January", "February", "March", "April", 
		      "May", "June", "July", "August", "September", 
		      "October", "November", "December"]
    in
	get_nth(months, #2 date)^" "^Int.toString(#3 date)^", "^Int.toString(#1 date)
    end

fun number_before_reaching_sum(sum : int, ints : int list) =
    if hd ints >= sum then 0
    else 1 + (number_before_reaching_sum(sum - hd ints, tl ints))

(* 9. Write a function what_month that takes a day of year 
(i.e., an int between 1 and 365) and returns what month 
that day is in (1 for January, 2 for February, etc.). 
Use a list holding 12 integers and your answer to the previous problem.*)

fun what_month( day : int)=
    let
	(* The number of days in each month for non-leap year are: 
           jan 31   feb 28   mar 31   apr 30   may 31 jun 30 jul 31
           aug 31   sep 30   oct 31   nov 30   dec 31*)
	val days_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
	number_before_reaching_sum(day, days_in_months)+1
    end
										


(* 10 Write a function month_range that takes two days of the year day1 and day2
 and returns an int list [m1,m2,...,mn] where m1 is the month of day1, m2 is the
 month of day1+1, ..., and mn is the month of day day2. Note the result will
 have length day2 - day1 + 1 or length 0 if day1>day2.*)

fun month_range( day1 : int, day2 : int)=
    if day1 > day2 then []
    else 
	let
	    val mon1 = what_month(day1)
	    val mon2 = what_month(day2)
	    fun month_conc(m : int)=
		if m >= mon2 then [] 
		else m+1::month_conc(m+1)
	in
	    mon1::month_conc(mon1)
	end

(* 11. Write a function oldest that takes a list of dates and evaluates 
to an (int*int*int) option. It evaluates to NONE if the list has no 
dates and SOME d if the date d is the oldest date in the list. *)
fun oldest(dates : (int*int*int) list)=
    if null dates then  NONE
    else 
	let
	    val oldest2 = oldest(tl dates)
	in
	    if isSome oldest2 andalso is_older(valOf oldest2, hd dates) then oldest2
	    else SOME (hd dates)
	end
