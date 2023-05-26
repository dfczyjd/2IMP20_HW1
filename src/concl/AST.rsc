module concl::AST

/*
 * Define the Abstract Syntax for ConCL
 *
 * - make sure there is an almost one-to-one correspondence with the grammar in Syntax.rsc
 */

data ConsolePack(loc src=|unknown:///|)
	= console_pack(str name, list[Component] components);
data Component(loc src=|unknown:///|)
	= component(Console cons)
	| component(Controller ctrl)
	| component(Game game);

data Console(loc src=|unknown:///|) = console(Storage storage, Display display);
data Storage(loc src=|unknown:///|) = storage(int size);
data Display(loc src=|unknown:///|)
	= display(real diagonal, DisplayType displayType, Resolution res);
data DisplayType(loc src=|unknown:///|)
	= led()
	| oled();
data Resolution(loc src=|unknown:///|)
	= res_hd()
	| res_fullhd()
	| res_4k()
	| res_5k();

data Controller(loc src=|unknown:///|) = controller(Colour colour);
data Colour(loc src=|unknown:///|)
	= black()
	| white()
	| red()
	| blue()
	| gold()
	| silver()
	| green();

data Game(loc src=|unknown:///|)
	= gameHedwig()
	| gameLink()
	| gameNone();
