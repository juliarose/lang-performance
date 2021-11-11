import java.util.Random;
import java.util.Arrays;

class Java {
    public static void main(String[] args) {
        long start = System.currentTimeMillis();
        int min = 1;
        int n = 1000000;
        int[] numbers = new int[n];
        
        for (int i = 0; i < n; i++) {
            numbers[i] = (int) ((Math.random() * (n - min)) + min);
        }
        
        Arrays.sort(numbers);
        
        String[] thousandsNumbers = new String[n];
        
        for (int i = 0; i < n; i++) {
            String str = String.format("%,d", numbers[i]);
            thousandsNumbers[i] = str;
        }
        
        long finish = System.currentTimeMillis();
        long timeElapsed = finish - start;
        System.out.println(timeElapsed + ".0ms");
    }
}
