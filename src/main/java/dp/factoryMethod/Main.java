package dp.factoryMethod;

public class Main {
	
	public static void main(String[] args) {
		Factory factory = new IDCardFactory();
		Product card1 = factory.create("홍길동");
		Product card2 = factory.create("김하나");
		card1.use();
		card2.use();
	}

}
