import classes.*;

public class Main {
    public static void main(String[] args){
        Studente francesca = new Studente("Francesca", "Bianca", "f.bianca", 25);
        Studente mario = new Studente("Mario", "Rossi", "m.rossi", 17);
        Studente giovanna = new Studente("Giovanna", "Verdi", "g.verdi", 31);
        Studente marco = new Studente("Marco", "Bianchi", "m.bianchi", 28);

        EsameVoto analisiMatematica = new EsameVoto(2, "Analisi Matematica");
        EsameIdoneita inglese = new EsameIdoneita(1, "Inglese");

        int[] votiOpzionali = {3};
        EsameParteOpzionale fisica = new EsameParteOpzionale(1, "Fisica", votiOpzionali);

        Studente[] studentiAnalisi = {giovanna, marco};
        Studente[] studentiInglese = {francesca};
        Studente[] studentiFisica = {mario};
        analisiMatematica.aggiungiStudenti(studentiAnalisi);
        inglese.aggiungiStudenti(studentiInglese);
        fisica.aggiungiStudenti(studentiFisica);

        analisiMatematica.calcolaStatistiche();
        inglese.calcolaStatistiche();
        fisica.calcolaStatistiche();
    }
}
