import java.util.Scanner;

public abstract class Main {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        System.out.println("Inserire base Rettangolo: ");
        double baseRettangolo = input.nextDouble();
        input.nextLine();
        System.out.println("Inserire altezza Rettangolo: ");
        double altezzaRettangolo = input.nextDouble();
        input.nextLine();
        System.out.println("Inserire base Triangolo: ");
        double baseTriangolo = input.nextDouble();
        input.nextLine();
        System.out.println("Inserire altezza Triangolo: ");
        double altezzaTriangolo = input.nextDouble();
        input.nextLine();

        Rettangolo rettangolo = new Rettangolo(baseRettangolo, altezzaRettangolo);
        TriangoloRettangolo triangoloRettangolo = new TriangoloRettangolo(baseTriangolo, altezzaTriangolo);


        try {
            System.out.println(triangoloRettangolo.area());
        } catch (InvalidShapeException e) {
            System.out.println(e.getMessage());
        }
        try {
            System.out.println(triangoloRettangolo.perimetro());
        } catch (InvalidShapeException e) {
            System.out.println(e.getMessage());
        }
        try {
            System.out.println(rettangolo.area());
        } catch (InvalidShapeException e) {
            System.out.println(e.getMessage());
        }
        try {
            System.out.println(rettangolo.perimetro());
        } catch (InvalidShapeException e) {
            System.out.println(e.getMessage());
        }
    }

}

