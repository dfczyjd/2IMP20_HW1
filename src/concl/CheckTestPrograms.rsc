module concl::CheckTestPrograms

import concl::Plugin;
import IO;

void main() {
	ok_tests_loc = |project://ConCL/test_programs/ok/|;
	println("checking wellformed programs:");
	for(int n <- [1 .. 6+1]) {
		concl_file = iprintToString(n) + ".concl";
		print(concl_file + ": ");
		bool ok = checkWellformedness(ok_tests_loc + concl_file);
		if(ok) {
			print("WELLFORMED");
		}
		else {
			print("MALFORMED");
		}
		println();
	}
	
	println();

	bad_tests_loc = |project://ConCL/test_programs/bad/|;
	println("checking malformed programs:");
	for(int n <- [1 .. 17+1]) {
		concl_file = iprintToString(n) + ".concl";
		print(concl_file + ": ");
		bool ok = false;
		try
			ok = checkWellformedness(bad_tests_loc + concl_file);
		catch ParseError :
			print("ParseError ");
		finally {
			if(ok) {
				print("WELLFORMED");
			}
			else {
				print("MALFORMED");
			}
			println();
		}
	}
}
