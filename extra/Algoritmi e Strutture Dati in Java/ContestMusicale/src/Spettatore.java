public class Spettatore {
    private Biglietto biglietto;
    private boolean obliterato;

    Spettatore(Biglietto biglietto, boolean obliterato){
        this.biglietto = biglietto;
        this.obliterato = obliterato;
    }

    public Biglietto getBiglietto() {return biglietto;}
    public boolean isObliterato() {return obliterato;}

    public void setBiglietto(Biglietto biglietto) {this.biglietto = biglietto;}
    public void setObliterato(boolean obliterato) {this.obliterato = obliterato;}
}
