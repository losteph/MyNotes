public class Autocarro extends Veicolo{
    private Carico carico;

    public Autocarro(String targa, String automobile, Carico carico) {
        super(targa, automobile);
        this.carico = carico;
    }

    public Carico getCarico() {return this.carico;}
    public void setCarico(Carico carico) {this.carico = carico;}
}
