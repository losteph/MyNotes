import java.util.Scanner;

public class Main {

    //costrutto per l'input
    public static Scanner input = new Scanner(System.in);

    public enum LODE {
        LAUREATO_CON_LODE,
        LAUREATO_SENZA_LODE
    }

    public static void main(String[] args) {

        //dischiaro le variabili
        String nome, cognome, corsoLaurea, matricola;
        int anniFuoriCorso;
        String[] esami = new String[0];
        int[] cfu_esami = new int[3];
        int[] voto_esami = new int[3];
        double alpha = 1.0; // minima qualità tesi (massima 1.07)
        double beta; //bonus lodi
        double gamma; //bonus tempo
        int numLodi;
        LODE lode = LODE.LAUREATO_CON_LODE;
        double media_ponderata;
        double media_aritmetica;
        double voto_finale;
        int voto_finale_arrotondato;

        System.out.println();
        do{
            System.out.println("inserisci nome: ");
            nome = input.nextLine();
        }while(nome.equals(""));
        do {
            System.out.println("inserisci cognome: ");
            cognome = input.nextLine();
        }while(cognome.isEmpty());
        do{
            System.out.println("inserisci numero matricola: ");
            matricola = input.nextLine();
            if (matricola.length() != 6) {
                System.out.println("attenzione la lunghezza deve essere uuale a 6");
            }
        }while(matricola.length() != 6);

    }

}
