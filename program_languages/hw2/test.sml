use "hw2.sml";

all_excep_option("123", ["123", "456", "789"]) = SOME ["456","789"];
all_excep_option("1234", ["123", "456", "789"]) = NONE;
all_excep_option("Fred", ["Fred","Fredrick"]) = SOME ["Fredrick"];

get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred") = ["Fredrick","Freddie","F"];
get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff") = ["Jeffrey","Geoff","Jeffrey"];

get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred") = ["Fredrick","Freddie","F"];
get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff") = ["Jeffrey","Geoff","Jeffrey"];

similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) = [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},{first="Freddie", last="Smith", middle="W"},{first="F", last="Smith", middle="W"}];

card_color(Spades, "") = Black;
card_color(Clubs, "") = Black;
card_color(Hearts, "") = Red;
card_color(Diamonds, "") = Red;

card_value(1, Num 5) = 5;
card_value(1, Jack) = 10;
card_value(1, Ace) = 11;

remove_card([(Spades, Num 5), (Clubs,Num 2), (Hearts, Ace)], (Clubs,Num 2), IllegalMove) = [(Spades,Num 5),(Hearts,Ace)];
(remove_card([(Spades, Num 5), (Clubs,Num 2), (Hearts, Ace)], (Clubs,Num 9), IllegalMove) handle IllegalMove => [(Clubs, Num 1)]) = [(Clubs,Num 1)];

all_same_color([(Spades, Num 5), (Clubs,Num 2), (Hearts, Ace)])=false;
all_same_color([(Spades, Num 5), (Clubs,Num 2), (Clubs, Ace)])=true;
all_same_color([(Diamonds, Num 5), (Clubs,Num 2), (Clubs, Ace)])=false;
all_same_color([(Diamonds, Num 5), (Clubs,Num 2), (Clubs, Ace)])=false;

sum_cards([(Diamonds, Num 5), (Clubs,Num 2), (Clubs, Ace)])=18;

score([(Diamonds, Num 5), (Clubs,Num 2), (Clubs, Ace)], 18) = 0;
score([(Diamonds, Num 5), (Clubs,Num 2), (Clubs, Ace)], 19) = 1;
score([(Diamonds, Num 5), (Clubs,Num 2), (Clubs, Ace)], 17) = 37;
score([(Spades, Num 5), (Clubs,Num 2), (Clubs, Ace)],10) = 22;

officiate([(Spades, Num 5), (Clubs,Num 2), (Clubs, Ace)], [Draw], 19) = 7;
officiate([(Spades, Num 5), (Clubs,Num 2), (Clubs, Ace)], [Draw, Draw], 19) = 6;
officiate([(Spades, Num 5), (Clubs,Num 2), (Clubs, Ace)], [Draw, Draw, Draw], 19) = 0;

officiate([(Spades, Num 5), (Clubs,Num 2), (Clubs, Ace)], [Draw, Draw, Draw, Draw], 19) = 0;
officiate([(Spades, Num 5), (Clubs,Num 2), (Clubs, Ace)], [Draw, Draw, Draw, Discard (Spades, Num 5)], 19) = 3;
(officiate([(Spades, Num 5), (Clubs,Num 2), (Clubs, Ace)], [Draw, Draw, Draw, Discard (Spades, Num 6)], 19) handle IllegalMove => 0-1) = 0-1;


