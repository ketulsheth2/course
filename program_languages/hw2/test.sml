use "hw2.sml";

all_excep_option("123", ["123", "456", "789"]) = SOME ["123","456","789"];
all_excep_option("1234", ["123", "456", "789"]) = NONE;
