public class Vagone {
    private int num_posti;
    private String etichetta;
    private TipoVagone tipo_vagone;

    public Vagone(int num_posti, String etichetta, TipoVagone tipo_vagone){
        this.num_posti = num_posti;
        this.etichetta = etichetta;
        this.tipo_vagone = tipo_vagone;
    }

    public int getNum_posti() {return num_posti;}
    public String getEtichetta() {return etichetta;}
    public TipoVagone getTipo_vagone() {return tipo_vagone;}

    public void setNum_posti(int num_posti) {this.num_posti = num_posti;}
    public void setEtichetta(String etichetta) {this.etichetta = etichetta;}
    public void setTipo_vagone(TipoVagone tipo_vagone) {this.tipo_vagone = tipo_vagone;}

    @Override
    public String toString() {
        return "------------------------------------" +
                "\nNumero di posti: " + this.num_posti +
                "\nEtichetta: " + this.etichetta +
                "\nTipo Vagone: " + this.tipo_vagone +
                "\n------------------------------------";
    }
}
