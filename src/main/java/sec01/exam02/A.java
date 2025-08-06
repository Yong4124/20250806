package sec01.exam02;

public class A {
	
	class B {}
	static class C {}
	
	B field1 = new B();
	C field2 = new C();
	
	static B field3 = new A().new B();
	static C field4 = new C();
	
	void method1() {
		B v1 = new B();
		C v2 = new C();
	}
	
	void method2() {
		B v1 = new A().new B();
		C v2 = new C();
	}

}
