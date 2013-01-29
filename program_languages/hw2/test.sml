use "hw2.sml";

all_excep_option("123", ["123", "456", "789"]) = SOME ["456","789"];
all_excep_option("1234", ["123", "456", "789"]) = NONE;
all_excep_option("Fred", ["Fred","Fredrick"]) = SOME ["Fredrick"];

get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred") = ["Fredrick","Freddie","F"];
get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff") = ["Jeffrey","Geoff","Jeffrey"];


