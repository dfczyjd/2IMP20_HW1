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

AST_Game parse_game((Component)`game { name: <GameHedwig _> }`) = gameHedwig();
AST_Game parse_game((Component)`game { name: <GameLink _> }`) = gameLink();

/*list[Component] get_components((ComponentTailItem*)``)
{
	println("Empty");
	return [];
}

list[Component] get_components((ComponentTailItem*)`, <Component head> <ComponentTail tail>`)
{
	println("Just head");
	println(head);
	return [head];
}*/

list[Component] get_components(ComponentTail items)
{
	//println(length(items));
	/*switch (items)
	{
		case (ComponentTail)`<ComponentTail _>, <Component _>`: println("Yes");
		default: println("No");
	}
	list[Component] res = [];
	for (/Component cmp <- items.args)
		res = res + [cmp];
	return res;*/
	list[Component] res = [];
	visit (items)
	{
		case (Component)`<Component comp>`: res = res + [comp];
	}
	return res;
}

/*list[Component] get_components(Component* comps)
{
	println(comps);
	switch (comps)
	{
		case (Component*)``:
		{
			println("Empty");
			return [];
		}
		case (Component*)`<Component head>`:
		{
			println("Just head");
			return [head];
		}
		case (Component*)`<Component head> <Component* tail>`:
		{
			println("Head and tail");
			return [head] + get_components(tail);
		}
	}
	return [];
}*/

AST_ConsolePack cst2ast((Pack)`console_pack <Name _> { <Component head> <ComponentTail tail> }`)
{
	list[Component] comps = [head] + get_components(tail);
	println(size(comps));
	return console_pack(gameHedwig());
}

test bool main()
{
	Pack pack = parserConCL(|file:///D:/LatinName/test.concl|);
	println(cst2ast(pack));
	return true;
}
