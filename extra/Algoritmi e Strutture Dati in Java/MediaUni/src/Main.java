import java.util.Scanner;

public class Main {

    public enum LODE{
        LAUREATO_CON_LODE,
        LAUREATO_SENZA_LODE
    }

    public static void main(String[] args) {
        //dichiaro variabili
        String nome, cognome, matricola;
        String corso_laurea;
        int anni_fuori_corso;
        String[] esami = {"Algoritmi e Strutture Dati in Java", "Informatica per L'Ingegneria", "Analisi"};
        int[] cfu_esami = {6, 6, 12};
        int[] voto_esami = {30, 27, 26};
        double alpha = 1.07; //max qualità tesi
        int num_lodi;
        double beta; //bonus lodi
        double gamma; //bonus tempo
        LODE lode = LODE.LAUREATO_CON_LODE;
        double media_pesata = 0.0;
        double voto_finale;
        int voto_finale_arrotondato;

        //costrutto per l'imput da console
        Scanner input = new Scanner(System.in);

        //inserimento dati da console
        System.out.println("inserisci nome: ");
        nome = input.nextLine();
        System.out.println("inserisci cognome: ");
        cognome = input.nextLine();
        System.out.println("inserisci numero di matricola: ");
        matricola = input.nextLine();
        System.out.println("inserisci il tuo corso di studi ");
        corso_laurea = input.nextLine();
        System.out.println("indica il numero di lodi ricevute ");
        num_lodi = input.nextInt();
        System.out.print("di quanti anni fuori corso: ");
        anni_fuori_corso = input.nextInt();

        //logica per calcolare il oto finale di laurea
        //(vale la regola per cui si escludono i 12 CFU con votazione più bassa)

        //calcolo media pesata
        media_pesata = media_pesata + voto_esami[0]*cfu_esami[0];
        System.out.println("aggiunto" + esami[0]);
        media_pesata = media_pesata + voto_esami[1]*cfu_esami[1];
        System.out.println("aggiunto" + esami[1]);
        media_pesata = media_pesata + voto_esami[2]*cfu_esami[2];
        System.out.println("aggiunto" + esami[2]);
        int cfu_tot = cfu_esami[0] + cfu_esami[1] + cfu_esami[2];
        media_pesata = media_pesata / cfu_tot;
        //trasformiamo il voto da 30esimi a 110esimi
        voto_finale = (110*media_pesata)/30;

        //calcolo beta
        if (num_lodi == 0) beta = 0;
        else if (num_lodi == 1) beta = 0.01;
        else beta = 0.02;

        //calcolo gamma
        if (anni_fuori_corso == 0) gamma = 0.02;
        else if (anni_fuori_corso == 1) gamma = 0.01;
        else gamma = 0;

        voto_finale = voto_finale * (alpha + beta + gamma);

        if (voto_finale <= 111.5) lode = LODE.LAUREATO_SENZA_LODE;

        voto_finale_arrotondato = (int) voto_finale;

        if (lode == LODE.LAUREATO_CON_LODE) voto_finale_arrotondato = 110;

        //stampa tutto e scopri quale è il voto finale di laurea!
        System.out.println("\n******************************************");
        System.out.println("PROCLAMAZIONE VOTO DI LAUREA");
        System.out.println(nome + " " + cognome);
        System.out.println("matricola: " + matricola);
        System.out.println("corso di laurea: " + corso_laurea);
        System.out.println("ottiene votazione complessiva di: " + voto_finale_arrotondato + "\n");
        System.out.printf("voto di laurea totale: %.2f\n", voto_finale);
        switch(lode){
            case LAUREATO_CON_LODE:
                System.out.println("laureato con lode");
                break;
            case LAUREATO_SENZA_LODE:
                System.out.println("laureato senza lode");
                break;
            default:
                System.out.println("valore dell'enumerativo non riconosciuto");
        }
    }
}
