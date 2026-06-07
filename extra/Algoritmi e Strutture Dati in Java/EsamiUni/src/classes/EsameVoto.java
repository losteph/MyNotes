package classes;
import interfaces.EsameInterface;

public class EsameVoto implements EsameInterface<Studente> {
    private Studente[] elencoStudenti;
    private String nomeEsame;

    // costruttore di default
    public EsameVoto(){}

    // costruttore custom
    public EsameVoto(int numeroStudenti, String nomeEsame){
        this.elencoStudenti = new Studente[numeroStudenti];
        this.nomeEsame = nomeEsame;
    }

    // getter (essendo gli attributi private, serve per accedere al loro valore anche nelle classi figlie)
    // alternativamente, possiamo usare protected
    public Studente[] getElencoStudenti(){
        return this.elencoStudenti;
    }
    public String getNomeEsame(){
        return this.nomeEsame;
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
        float mediaAritmetica = 0;
        double deviazioneStandard = 0;

        for (int i = 0; i < this.elencoStudenti.length; i++){
            if (this.elencoStudenti[i].getVotazione() == 31) mediaAritmetica += 30;
            else mediaAritmetica += this.elencoStudenti[i].getVotazione();
        }

        mediaAritmetica /= this.elencoStudenti.length;

        for (int i = 0; i < this.elencoStudenti.length; i++){
            if (this.elencoStudenti[i].getVotazione() == 31) deviazioneStandard += Math.pow(30 - mediaAritmetica, 2);
            else deviazioneStandard += Math.pow(this.elencoStudenti[i].getVotazione() - mediaAritmetica, 2);
        }

        deviazioneStandard /= this.elencoStudenti.length;
        deviazioneStandard = Math.sqrt(deviazioneStandard);

        System.out.println("Esame di: " + this.nomeEsame);
        System.out.println("La media aritmetica è: " + mediaAritmetica);
        System.out.println("La deviazione standard è: " + deviazioneStandard + "\n");
    }
}
