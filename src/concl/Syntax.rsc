module concl::Syntax

/*
 * Define a concrete syntax for ConCL. The langauge's specification is available in the PDF (Section 3)
 */

/*
start syntax Pack = "console_pack" Name;
lexical Name = [A-Za-z]*;

layout Whitespace = [\ \t\n\r]*;// !>> [\ \t\n\r];
*/
start syntax Pack = "console_pack" Name "{" Component ComponentTail "}";
syntax ComponentTail = ComponentTailItem*;
syntax ComponentTailItem = "," Component;
syntax Component = Console
	| Controller
	| Game;

syntax Console = "console" "{"
	(Storage "," Display) | (Display "," Storage)
	"}";
//syntax ConsoleItem = Storage | Display;
syntax Storage = "storage:" Number "GB";

syntax Display = "display" "{" DisplayItem "," DisplayItem "," DisplayItem "}";
syntax DisplayItem = Diagonal | DisplayType | Resolution;
syntax Diagonal = "diagonal:" Number "inch";
syntax DisplayType = "type:" (TypeLED | TypeOLED);
syntax Resolution = "resolution:" (ResHD | ResFullHD | Res4K | Res5K);

syntax Controller = "controller" "{" ControllerColour "}";
syntax ControllerColour = "colour:" Colour;

syntax Game = "game" "{" GameName "}";
syntax GameName = "name:" (GameLink | GameHedwig);

// Lexicals
lexical Name = [A-Za-z_][A-Za-z0-9_]*;
lexical Number = [1-9][0-9]*("."[0-9]*[1-9])?;

lexical TypeLED = "LED";
lexical TypeOLED = "OLED";
lexical ResHD = "HD";
lexical ResFullHD = "Full-HD";
lexical Res4K = "4K";
lexical Res5K = "5K";

lexical Colour = "black"
	| "white"
	| "red"
	| "blue"
	| "gold"
	| "silver"
	| "green";

lexical GameHedwig = "Hedwig the Hedgehog";
lexical GameLink = "Link\'s Resolution";


layout Whitespace = [\ \t\n\r]* !>> [\ \t\n\r];

//start syntax Pack = "console_pack" Name "{" (Component*) "}";
//syntax Component = Console

//exical Name = [A-Za-z_][A-Za-z0-9_]*
