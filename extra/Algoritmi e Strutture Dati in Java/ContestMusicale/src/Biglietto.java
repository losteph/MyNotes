public class Biglietto extends Persona{
    private int cod_biglietto;
    private TipoPosto posto;
    private double prezzo;

    Biglietto(String nome, String cognome, int cod_biglietto, TipoPosto posto, double prezzo){
        super(nome, cognome);
        this.cod_biglietto = cod_biglietto;
        this.posto = posto;
        this.prezzo = prezzo;
    }

    public int getCod_biglietto() {return cod_biglietto;}
    public TipoPosto getPosto() {return posto;}
    public double getPrezzo() {return prezzo;}

    public void setCod_biglietto(int cod_biglietto) {this.cod_biglietto = cod_biglietto;}
    public void setPosto(TipoPosto posto) {this.posto = posto;}
    public void setPrezzo(double prezzo) {this.prezzo = prezzo;}

    @Override
    public String toString(){
        return  "-----------------------------" +
                "\nNome: " + this.getNome() +
                "\nCognome: " + this.getCognome() +
                "\nPosto: " + this.posto +
                "\n---------------------------";
    }
}
