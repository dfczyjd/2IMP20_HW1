module concl::Parser

import ParseTree;
import concl::Syntax;

import IO; // TODO: remove after testing

/*
 * Define the parser for the ConCL language. The name of the function must be parserConCL.
 * This function receives as a parameter the path of the file to parse represented as a loc, and returns a parse tree that represents the parsed program.
 */
 
Pack parserConCL(loc file) = parse(#Pack, file);

test bool main()
{
	println(parserConCL(|file:///D:/LatinName/test.concl|));
	return true;
}

//Tree parse(pack);
