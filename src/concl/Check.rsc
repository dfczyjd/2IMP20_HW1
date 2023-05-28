module concl::Check

import concl::AST;

/*
 * -Implement a well-formedness checker for the ConCL language. For this you must use the AST. 
 * - Hint: Map regular CST arguments (e.g., *, +, ?) to lists 
 * - Hint: Map lexical nodes to Rascal primitive types (bool, int, str)
 * - Hint: Use switch to do case distinction with concrete patterns
 */

 /*
 * Create a function called checkHardwareConfiguration(...), which is responsible for calling all the required functions that check the program's well-formedness as described in the PDF (Section 3.2.) 
 * This function takes as a parameter the program's AST and returns true if the program is well-formed or false otherwise.
 */

 public bool checkHardwareConfiguration(ConsolePack ast) {
 	return
 		checkConsoleComponent(ast) &&
 		checkGameComponent(ast) &&
 		checkControllerCount(ast) &&
 		checkDuplicateControllers(ast) &&
 		checkControllerGameCombo(ast) &&
 		checkDisplayType(ast) &&
 		checkDuplicateComponents(ast) &&
 		checkStorageSize(ast);
 }
 
/*
* Define a function per each verification defined in the PDF (Section 3.2.)
*/

private bool checkConsoleComponent(ConsolePack ast) {
	/*
	* Check if the console pack contains a console component
	*/
	return /console(Storage _, Display _) := ast;
}

 private bool checkControllerCount(ConsolePack ast) {
	/*
	* Check if the console pack contains at least 1 and at most 4 controllers
	*/
 	int controller_count = 0;
 	for(component(Controller _) <- ast.components) {
		controller_count += 1;
 	}
 	return (controller_count >= 1 && controller_count <= 4);
 }
 
 private bool checkDuplicateControllers(ConsolePack ast) {
	/*
	* Check if the console pack contains duplicate controllers
	*/
 	controllers = [];
 	for(component(Controller c) <- ast.components) {
 		if(c in controllers) {
 			return false;
 		} 
 		controllers = controllers + c;
 	}
 	return true;
 }
 
 private bool checkGameComponent(ConsolePack ast) {
	/*
	* Check if the console pack contains a game component (can still be "gameNone()")
	*/
 	game_component_count = 0;	
	for(component(Game _) <- ast.components) {
		game_component_count += 1;
	}
	return game_component_count <= 1;
 }
 
 private bool checkControllerGameCombo(ConsolePack ast) {
	/*
	* Check if the following Controller + game combos are satisfied
	* If it contains the Hedwig game, a blue controller must be included and no green controller is included 
	* If it contains the Link game, a green controller must be included
	*/
 	controllers = [];
 	for(component(Controller c) <- ast.components) {
 		controllers = controllers + c;
 	}

	for(component(Game g) <- ast.components) {
		if(g := gameLink()) {
			if(controller(green()) notin controllers) {
				return false;
			}
		}
		else if(g:= gameHedwig()) {
			if( ( controller(blue()) notin controllers) || (controller(green()) in controllers) ) {
				return false;
			}
		}
	}

	return true;
 }
 
 private bool checkDisplayType(ConsolePack ast) {
	// already taken care of in the concrete syntax definition
	return true;
 }
 
 private bool checkDuplicateComponents(ConsolePack ast) {
	// already taken care of in the concrete syntax definition
	return true;
 }
 
 private bool checkStorageSize(ConsolePack ast) {
	/*
	* Check if the console pack has a storage size between 32 and 1024 GB.
	*/
 	for(/storage(int s) <- ast.components) {
 		if(s < 32 || s > 1024) {
 			return false;
 		} 
 	}
 	return true;
 }
