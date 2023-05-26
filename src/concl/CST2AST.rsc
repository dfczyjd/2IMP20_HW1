module concl::CST2AST

import concl::AST;
import concl::Syntax;
import List;

import IO;	// TODO: remove after testing
import concl::Parser;

/*
 * Implement a mapping from concrete syntax trees (CSTs) to abstract syntax trees (ASTs)
 * Hint: Use switch to do case distinction with concrete patterns
 * Map regular CST arguments (e.g., *, +, ?) to lists
 * Map lexical nodes to Rascal primitive types (bool, int, str)
 */

Colour mapColour((Colour)`<Black _>`) = black();
Colour mapColour((Colour)`<White _>`) = white();
Colour mapColour((Colour)`<Red _>`) = red();
Colour mapColour((Colour)`<Blue _>`) = blue();
Colour mapColour((Colour)`<Gold _>`) = gold();
Colour mapColour((Colour)`<Silver _>`) = silver();
Colour mapColour((Colour)`<Green _>`) = green();

//Display mapDisplay();

//Storage mapStorage((Storage)`storage: {<Natural 

Component mapComponent((Component)`game { name: <GameHedwig _> }`)= component(gameHedwig());
Component mapComponent((Component)`game { name: <GameLink _> }`) = component(gameLink());

Component mapComponent((Component)`controller { colour: <Colour colour> }`)
	= component(controller(mapColour(colour)));

Component mapComponent((Component)`<Console cons>`) = component(console(storage(5), display(0.0, led(), res_hd())));

ConsolePack cst2ast((Pack)`console_pack <Name name> { <Components comps> }`)
{
	list[Component] components = [];
	visit (comps)
	{
		case (Component)`<Component comp>`:
			components += [mapComponent(comp)];
	}
	return console_pack("<name>", components);
}

test bool main()
{
	Pack pack = parserConCL(|file:///D:/LatinName/test.concl|);
	println(cst2ast(pack));
	return true;
}
