module concl::CST2AST

import concl::AST;
import concl::Syntax;
import List;
import String;

import IO;	// TODO: remove after testing
import concl::Parser;

/*
 * Implement a mapping from concrete syntax trees (CSTs) to abstract syntax trees (ASTs)
 * Hint: Use switch to do case distinction with concrete patterns
 * Map regular CST arguments (e.g., *, +, ?) to lists
 * Map lexical nodes to Rascal primitive types (bool, int, str)
 */

// Maps a controller's colour
Colour mapColour((Colour)`<Black _>`) = black();
Colour mapColour((Colour)`<White _>`) = white();
Colour mapColour((Colour)`<Red _>`) = red();
Colour mapColour((Colour)`<Blue _>`) = blue();
Colour mapColour((Colour)`<Gold _>`) = gold();
Colour mapColour((Colour)`<Silver _>`) = silver();
Colour mapColour((Colour)`<Green _>`) = green();

// Maps Storage component
Storage mapStorage((Storage)`storage: <Natural size> GB`) = storage(toInt("<size>"));

// Maps display diagonal
real mapDiagonal((Diagonal)`diagonal: <Real size> inch`) = toReal("<size>");

// Maps the display type
DisplayType mapDisplayType((DisplayType)`type: <TypeLED _>`) = led();
DisplayType mapDisplayType((DisplayType)`type: <TypeOLED _>`) = led();

// Maps the display resolution
Resolution mapResolution((Resolution)`resolution: <ResHD _>`) = res_hd();
Resolution mapResolution((Resolution)`resolution: <ResFullHD _>`) = res_fullhd();
Resolution mapResolution((Resolution)`resolution: <Res4K _>`) = res_4k();
Resolution mapResolution((Resolution)`resolution: <Res5K _>`) = res_5k();

// Maps Display component
Display mapDisplay((Display)`display { <Diagonal diag>, <DisplayType dispType>, <Resolution res> }`)
	= display(mapDiagonal(diag), mapDisplayType(dispType), mapResolution(res));
Display mapDisplay((Display)`display { <Diagonal diag>, <Resolution res>, <DisplayType dispType> }`)
	= display(mapDiagonal(diag), mapDisplayType(dispType), mapResolution(res));
Display mapDisplay((Display)`display { <DisplayType dispType>, <Diagonal diag>, <Resolution res> }`)
	= display(mapDiagonal(diag), mapDisplayType(dispType), mapResolution(res));
Display mapDisplay((Display)`display { <DisplayType dispType>, <Resolution res>, <Diagonal diag> }`)
	= display(mapDiagonal(diag), mapDisplayType(dispType), mapResolution(res));
Display mapDisplay((Display)`display { <Resolution res>, <Diagonal diag>, <DisplayType dispType> }`)
	= display(mapDiagonal(diag), mapDisplayType(dispType), mapResolution(res));
Display mapDisplay((Display)`display { <Resolution res>, <DisplayType dispType>, <Diagonal diag> }`)
	= display(mapDiagonal(diag), mapDisplayType(dispType), mapResolution(res));


// Maps a console pack component to a respective type wrapped into a Component
Component mapComponent((Component)`game { }`) = component(gameNone());
Component mapComponent((Component)`game { name: <GameHedwig _> }`) = component(gameHedwig());
Component mapComponent((Component)`game { name: <GameLink _> }`) = component(gameLink());

Component mapComponent((Component)`controller { colour: <Colour colour> }`)
	= component(controller(mapColour(colour)));

Component mapComponent((Component)`console { <Storage stor>, <Display disp> }`)
	= component(console(mapStorage(stor), mapDisplay(disp)));
Component mapComponent((Component)`console { <Display disp>, <Storage stor> }`)
	= component(console(mapStorage(stor), mapDisplay(disp)));

// Main mapping function, maps the console pack
ConsolePack cst2ast((Pack)`console_pack <Name name> { <Components comps> }`)
{
	list[Component] components = [];
	visit (comps)
	{
		case (Component)`<Component comp>`:
			components += mapComponent(comp);
	}
	return console_pack("<name>", components);
}

test bool main()
{
	Pack pack = parserConCL(|file:///D:/LatinName/test.concl|);
	println(cst2ast(pack));
	return true;
}
