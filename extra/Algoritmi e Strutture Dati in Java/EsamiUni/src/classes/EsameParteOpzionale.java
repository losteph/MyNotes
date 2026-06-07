package classes;

public class EsameParteOpzionale extends EsameVoto{
    private int[] votoOpzionale;

    // costruttore di default
    public EsameParteOpzionale(){}

    // costruttore custom
    public EsameParteOpzionale(int numeroStudenti, String nomeEsame, int[] votoOpzionale){
        super(numeroStudenti, nomeEsame);

        this.votoOpzionale = new int[numeroStudenti];
        for (int i = 0; i < numeroStudenti; i++){
            this.votoOpzionale[i] = votoOpzionale[i];
        }
    }

    // metodo per calcolare le statistiche
    @Override
    public void calcolaStatistiche(){
        float mediaAritmetica = 0;
        double deviazioneStandard = 0;

        for (int i = 0; i < this.getElencoStudenti().length; i++){
            this.getElencoStudenti()[i].setVotazione(this.getElencoStudenti()[i].getVotazione() + this.votoOpzionale[i]);
            if (this.getElencoStudenti()[i].getVotazione() >= 31) mediaAritmetica += 30;
            else mediaAritmetica += this.getElencoStudenti()[i].getVotazione();
        }

        mediaAritmetica /= this.getElencoStudenti().length;

        for (int i = 0; i < this.getElencoStudenti().length; i++){
            // non effettuiamo di nuovo la modifica sul voto, perchè è stata già fatta prima
            if (this.getElencoStudenti()[i].getVotazione() >= 31) deviazioneStandard += Math.pow(30 - mediaAritmetica, 2);
            else deviazioneStandard += Math.pow(this.getElencoStudenti()[i].getVotazione() - mediaAritmetica, 2);
        }

        deviazioneStandard /= this.getElencoStudenti().length;
        deviazioneStandard = Math.sqrt(deviazioneStandard);

        System.out.println("Esame di: " + this.getNomeEsame());
        System.out.println("La media aritmetica è: " + mediaAritmetica);
        System.out.println("La deviazione standard è: " + deviazioneStandard + "\n");

    }

}
