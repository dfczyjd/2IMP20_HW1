module concl::Syntax

/*
 * Define a concrete syntax for ConCL. The langauge's specification is available in the PDF (Section 3)
 */

start syntax Pack = "console_pack" Name "{" Components "}";
syntax Components = Component ("," Component)*;
syntax Component = Console
	| Controller
	| Game;

syntax Console = "console" "{"
	((Storage "," Display) | (Display "," Storage))
	"}";
syntax Storage = "storage" ":" Natural "GB";

syntax Display = "display" "{"
	( (Diagonal "," DisplayType "," Resolution)
	| (Diagonal "," Resolution "," DisplayType)
	| (DisplayType "," Diagonal "," Resolution)
	| (DisplayType "," Resolution "," Diagonal)
	| (Resolution "," DisplayType "," Diagonal)
	| (Resolution "," Diagonal "," DisplayType)
	) "}";
syntax Diagonal = "diagonal" ":" Real "inch";
syntax DisplayType = "type" ":" (TypeLED | TypeOLED);
syntax Resolution = "resolution" ":" (ResHD | ResFullHD | Res4K | Res5K);

syntax Controller = "controller" "{" ControllerColour "}";
syntax ControllerColour = "colour" ":" Colour;

syntax Game = "game" "{" GameName "}";
syntax GameName = "name" ":" (GameLink | GameHedwig);

// Lexicals
lexical Name = [A-Za-z_][A-Za-z0-9_]*;
lexical Natural = "0" | [1-9][0-9]*;
lexical Real = Natural ("."[0-9]*[1-9])?;

lexical TypeLED = "LED";
lexical TypeOLED = "OLED";
lexical ResHD = "HD";
lexical ResFullHD = "Full-HD";
lexical Res4K = "4K";
lexical Res5K = "5K";

lexical Colour = Black
	| White
	| Red
	| Blue
	| Gold
	| Silver
	| Green;

// "Keyword" lexicals, left as lexicals for pattern matching
lexical Black = "black";
lexical White = "white";
lexical Red = "red";
lexical Blue = "blue";
lexical Gold = "gold";
lexical Silver = "silver";
lexical Green = "green";

lexical GameHedwig = "Hedwig the Hedgehog";
lexical GameLink = "Link\'s Resolution";


layout Whitespace = [\ \t\n\r]* !>> [\ \t\n\r];
