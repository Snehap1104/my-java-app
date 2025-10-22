public class App {
    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("  Hello, Jenkins + Docker!");
        System.out.println("  Java Application Successfully Built!");
        System.out.println("========================================");
        
        // Keep the container running for demonstration
        try {
            System.out.println("Application is running... Press Ctrl+C to stop.");
            Thread.sleep(Long.MAX_VALUE);
        } catch (InterruptedException e) {
            System.out.println("Application stopped.");
        }
    }
}
