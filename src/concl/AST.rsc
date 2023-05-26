module concl::AST

/*
 * Define the Abstract Syntax for ConCL
 *
 * - make sure there is an almost one-to-one correspondence with the grammar in Syntax.rsc
 */

alias ConsoleName = str;

data AST_ConsolePack(loc src=|unknown:///|) = console_pack(AST_Game game);

data AST_Controller(loc src=|unknown:///|) = controller(AST_Colour colour);
data AST_Colour(loc src=|unknown:///|)
	= black()
	| white()
	| red()
	| blue()
	| gold()
	| silver()
	| green();

data AST_Game(loc src=|unknown:///|)
	= gameHedwig()
	| gameLink();
