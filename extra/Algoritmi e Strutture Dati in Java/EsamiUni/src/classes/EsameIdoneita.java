package classes;
import interfaces.EsameInterface;

public class EsameIdoneita implements EsameInterface<Studente> {
    private Studente[] elencoStudenti;
    private String nomeEsame;

    // costruttore di default
    public EsameIdoneita(){}

    // costruttore custom
    public EsameIdoneita(int numeroStudenti, String nomeEsame){
        this.elencoStudenti = new Studente[numeroStudenti];
        this.nomeEsame = nomeEsame;
    }

    // metodo per aggiungere gli studenti (override)
    @Override
    public void aggiungiStudenti(Studente[] s){
        for (int i = 0; i < this.elencoStudenti.length; i++) {
            this.elencoStudenti[i] = s[i];
        }
    }

    // metodo per calcolare le statistiche
    @Override
    public void calcolaStatistiche(){
        int numeroStudentiPassati = 0;

        for (int i = 0; i < this.elencoStudenti.length; i++){
            if (this.elencoStudenti[i].getVotazione() >= 18) numeroStudentiPassati += 1;
        }

        System.out.println("Esame di: " + this.nomeEsame);
        System.out.println("Numero di studenti che hanno superato l'esame: " + numeroStudentiPassati + "/" +
                this.elencoStudenti.length + "\n");

    }
}
