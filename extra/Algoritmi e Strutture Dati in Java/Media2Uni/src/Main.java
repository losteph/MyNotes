import java.util.Scanner;

public class Main {

    public enum LODE {
        LAUREATO_CON_LODE,
        LAUREATO_SENZA_LODE
    }

    //costrutto per l'imput da console
    public static Scanner input = new Scanner(System.in);

    public static void main(String[] args) {
        //dichiaro variabili
        String nome, cognome, matricola;
        String corso_laurea;
        int anni_fuori_corso;
        String[] esami = new String[3];
        int[] cfu_esami = new int[3];
        int[] voto_esami = new int[3];
        double alpha = 1.07; //max qualità tesi (sccegliere 1 per la minima qualità)
        int num_lodi;
        double beta; //bonus lodi
        double gamma; //bonus tempo
        LODE lode = LODE.LAUREATO_CON_LODE;
        double media_ponderata;
        double media_aritmetica;
        //double media_pesata = 0.0;
        double voto_finale;
        int voto_finale_arrotondato;

        num_lodi = inserisciEsami(esami, cfu_esami, voto_esami);


        //inserimento dati da console
        System.out.println();
        do {
            System.out.print("inserisci nome: ");
            nome = input.nextLine();
        } while (nome.equals(""));
        do {
            System.out.print("inserisci cognome: ");
            cognome = input.nextLine();
        } while (cognome.equals(""));
        do {
            System.out.println("inserisci numero di matricola: ");
            matricola = input.nextLine();
            if (matricola.length() != 6) {
                System.out.println("attenzione la lunghezza deve essere uuale a 6");
            }
        } while (matricola.length() != 6);
        do {
            System.out.println("inserisci il tuo corso di studi ");
            corso_laurea = input.nextLine();
            if(corso_laurea.equals(""));{
                System.out.println("stringa vuota");
            }
        }while(corso_laurea.equals(""));
        do {
            System.out.print("di quanti anni fuori corso: ");
            anni_fuori_corso = input.nextInt();
            if(anni_fuori_corso < 0) {
                System.out.println("attenzione numero fuori corso minore di 0");
            }
        }while(anni_fuori_corso < 0);
        //logica per calcolare il oto finale di laurea
        //(vale la regola per cui si escludono i 12 CFU con votazione più bassa)


        //calcolo beta
        if (num_lodi == 0) beta = 0;
        else if (num_lodi == 1) beta = 0.01;
        else beta = 0.02;

        //calcolo gamma
        if (anni_fuori_corso == 0) gamma = 0.02;
        else if (anni_fuori_corso == 1) gamma = 0.01;
        else gamma = 0;

        //richiamiamo i calcoli della media aritmetica e di quella ponderata
        media_aritmetica = calcolaVotoLaurea(alpha, beta, gamma, voto_esami);
        media_ponderata = calcoloVotoLaurea(alpha,beta, gamma, voto_esami, cfu_esami);
        System.out.println("il voto finale, usando la media aritmetica è: " + media_aritmetica);
        System.out.println("il voto finale, usando la media ponderata è: " + media_ponderata);

        voto_finale = media_ponderata;

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
        switch (lode) {
            case LAUREATO_CON_LODE: System.out.println("laureato con lode");
            case LAUREATO_SENZA_LODE: System.out.println("laureato senza lode");
            default: System.out.println("valore dell'enumerativo non riconosciuto");
        }
    }

    public static int inserisciEsami(String[] esami, int[] cfu, int[] voto) {
        int numero_lodi = 0;
        //ciclo per leggere gli esami
        for (int i = 0; i < esami.length; i++) {
            System.out.println("***************************");
            do {
                System.out.print("inserisci nome esame: ");
                esami[i] = input.nextLine();
                if (esami[i].equals("")) {
                    System.out.println("stringa vuota!");
                }
            } while (esami[i].equals(""));
            do {
                System.out.print("quanti CFU ha l'esame?  ");
                cfu[i] = input.nextInt();
                if (cfu[i] != 3 && cfu[i] != 6 && cfu[i] != 9 && cfu[i] != 12) {
                    System.out.println("i CFU per un esame possono essere soltanto 3,6,9,12");
                }
            } while (cfu[i] != 3 && cfu[i] != 6 && cfu[i] != 9 && cfu[i] != 12);
            do {
                System.out.print("inserisci votazione conseguita: ");
                voto[i] = input.nextInt();
                if (voto[i] < 18 || voto[i] > 31) {
                    System.out.println("il voto di conseguimento di un esame è compreso tra 18 e 30, o 31 per la lode");
                }
            } while (voto[i] < 18 || voto[i] > 31);
            if (voto[i] == 31) {
                numero_lodi++;
                voto[i] = 30;
            }
            System.out.println("****************************");
            input.nextLine();
        }
        return numero_lodi;
    }

    public static double calcolaVotoLaurea(double alpha, double beta, double gamma, int[] voti) {
        //calcoliamo la media aritmetica
        double media_aritmetica = 0.0;
        double voto_finale;
        for (int j : voti){
           media_aritmetica += j;
        }
        media_aritmetica /= voti.length;

        //voto da 30esimi a 110esimi
        voto_finale = (110*media_aritmetica)/30;

        //il voto finale quindi è
        voto_finale = voto_finale * (alpha + beta + gamma);
        return voto_finale;
    }

    public static double calcoloVotoLaurea(double alpha, double beta, double gamma, int[] voti, int[] cfu){
        //media ponderata
        double media_ponderata = 0.0;
        double voto_finale;
        int cfu_tot = 0;
        for (int i=0; i<voti.length; i++){
            media_ponderata += (voti[i]*cfu[i]);
            cfu_tot += cfu[i];
        }
        media_ponderata /= cfu_tot;

        //voto 30esimi in 110esimi
        voto_finale = (110* media_ponderata) / 30;

        //voto finale di laurea
        voto_finale = voto_finale * (alpha+beta+gamma);
        return voto_finale;
    }
}