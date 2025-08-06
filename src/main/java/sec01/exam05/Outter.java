package sec01.exam05;

public class Outter {
	String field = "Outter-field";
	void method() {
		System.out.println("Outter-method");
	}
	
	class Nested {
		String field = "Nested-field";
		void method() {
			System.out.println("Nested-method");
		}
		void print() {
			System.out.println(Outter.this.field);
			this.method();
		}
	}
	public static void main(String[] ar) {
		Outter.Nested nested = new Outter().new Nested();
		nested.print();
	}

}
