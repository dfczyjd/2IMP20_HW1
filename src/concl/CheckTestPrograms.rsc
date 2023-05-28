module concl::CheckTestPrograms

import concl::Plugin;
import IO;

void main() {
	ok_tests_loc = |project://ConCL/test_programs/ok/|;
	println("checking wellformed programs:");
	for(int n <- [1 .. 7+1]) {
		concl_file = iprintToString(n) + ".concl";
		print(concl_file + ": ");
		bool ok;
		try
			ok = checkWellformedness(ok_tests_loc + concl_file);
		catch ParseError : {
			ok = false;
			print("ParseError ");
		}
		finally {
			if(ok) {
				println("WELLFORMED");
			}
			else {
				println("MALFORMED");
			}
		}
	}
	
	println();

	bad_tests_loc = |project://ConCL/test_programs/bad/|;
	println("checking malformed programs:");
	for(int n <- [1 .. 16+1]) {
		concl_file = iprintToString(n) + ".concl";
		print(concl_file + ": ");
		bool ok;
		try
			ok = checkWellformedness(bad_tests_loc + concl_file);
		catch ParseError : {
			ok = false;
			print("ParseError ");
		}
		finally {
			if(ok) {
				println("WELLFORMED");
			}
			else {
				println("MALFORMED");
			}
		}
	}
}
