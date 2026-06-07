public class Ordine {
    private String codOrdine;
    private double prezzo;
    private String tipoPizza;
    private TipoOrdine tipoOrdine;

    public Ordine(String codOrdine, double prezzo, String tipoPizza, TipoOrdine tipoOrdine){
        this.codOrdine = codOrdine;
        this.prezzo = prezzo;
        this.tipoPizza = tipoPizza;
        this.tipoOrdine = tipoOrdine;
    }

    public String getCodOrdine() {
        return codOrdine;
    }
    public void setCodOrdine(String codOrdine) {
        this.codOrdine = codOrdine;
    }

    public double getPrezzo() {
        return prezzo;
    }
    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }

    public String getTipoPizza() {
        return tipoPizza;
    }
    public void setTipoPizza(String tipoPizza) {
        this.tipoPizza = tipoPizza;
    }

    public TipoOrdine getTipoOrdine() {
        return tipoOrdine;
    }
    public void setTipoOrdine(TipoOrdine tipoOrdine) {
        this.tipoOrdine = tipoOrdine;
    }

    @Override
    public String toString() {
        return "Codice Ordine: " + this.codOrdine +
                "\nPrezzo: " + this.prezzo +
                "\nTipo Pizza: " + this.tipoPizza +
                "\nTipoOrdine: " + this.tipoOrdine;
    }
}
