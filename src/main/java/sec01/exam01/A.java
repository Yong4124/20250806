package sec01.exam01;

public class A {
	A() {
		System.out.println("A 생성자");
	}
	class B{
		B() {
			System.out.println("B 생성자");
		}
		int field1;
		static int field2;
		void method1() {}
		static void method2() {
			System.out.println("method2");
		}
		
	}
	public static void  main(String[] ar) {
		A a = new A();
		A.B b = a.new B();
		b.method1();
		A.B.method2();
	}
}
