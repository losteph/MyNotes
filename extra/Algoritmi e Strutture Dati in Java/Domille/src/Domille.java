import java.util.Random;
import java.util.Scanner;

public class Domille {
    public static void main(String[] args) {

        Scanner input = new Scanner(System.in);

        System.out.println("Fai una domanda al saggio Domille: ");


        input.next();
        input.close();


            Random rand = new Random();
            int r = rand.nextInt(8);


            if (r == 0) {
                System.out.println("Si");
            } else if (r == 1) {
                System.out.println("No");
            } else if (r == 2) {
                System.out.println("La sta Trolli");
            } else if (r == 3) {
                System.out.println("Abbe me");
            } else if (r == 4) {
                System.out.println("Enniente");
            } else if (r == 5) {
                System.out.println("Sta scammi");
            } else if (r == 6) {
                System.out.println("Chiedi dopo, ora sto facendo una COSA");
            }
    }
}
