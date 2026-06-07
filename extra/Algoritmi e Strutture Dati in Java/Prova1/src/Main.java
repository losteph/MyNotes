import java.util.Scanner;

public class Main {
    public static void main(String[] args){
        String nome, cognome;
        Scanner input = new Scanner(System.in);
        System.out.println("inserisci nome:");
        nome = input.nextLine();
        System.out.println("inserisci cognome:");
        cognome = input.nextLine();
        System.out.println("Benvenuto " + nome + " " + cognome);
    }
}
