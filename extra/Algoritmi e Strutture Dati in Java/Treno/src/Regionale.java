public class Regionale extends Treno{
    private String regione;


    Regionale(int codice_treno, String produttore, String regione) {
        super(codice_treno, produttore);
        this.regione = regione;
    }

    public String getRegione() {
        return regione;
    }

    public void setRegione(String regione) {
        this.regione = regione;
    }
}
