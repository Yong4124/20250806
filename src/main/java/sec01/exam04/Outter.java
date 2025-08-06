package sec01.exam04;

public class Outter {
	public void method1(int arg) {
		int var = 1;
		
//		arg = arg + 200;
//		var = 2;
		class Inner {
			public void method() {
				int result = arg + var;
			}
		}
	
	}
}
