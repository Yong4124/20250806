package nested;

public class A {
	class B {}
	static class C {}
	void method() {
		class D {
			int field1;
			static int field2;
		}
		D d1 = new D();
		d1.field1 = 700;
		D.field2 = 100;
		
	}
	public static void main(String[] ar) {
//		A a1 = new A();
//		B b1 = a1.new B();
		B b1 = new A().new B();
		
		A.C c1 = new A.C();
	}
}
