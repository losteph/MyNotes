public class Ordine {
    private String cod_ordine;
    private float prezzo;
    private TipoPizza tipoPizza;
    private TipoOrdine tipoOrdine;

    public Ordine(){}

    public Ordine(String cod_ordine, float prezzo, TipoPizza tipoPizza, TipoOrdine tipoOrdine){
        this.cod_ordine = cod_ordine;
        this.prezzo = prezzo;
        this.tipoPizza = tipoPizza;
        this.tipoOrdine = tipoOrdine;
    }

    public String getCod_ordine() {
        return cod_ordine;
    }
    public float getPrezzo() {
        return prezzo;
    }
    public TipoPizza getTipoPizza() {
        return tipoPizza;
    }
    public TipoOrdine getTipoOrdine() {
        return tipoOrdine;
    }

    public void setCod_ordine(String cod_ordine) {
        this.cod_ordine = cod_ordine;
    }
    public void setPrezzo(float prezzo) {
        this.prezzo = prezzo;
    }
    public void setTipoPizza(TipoPizza tipoPizza) {
        this.tipoPizza = tipoPizza;
    }
    public void setTipoOrdine(TipoOrdine tipoOrdine) {
        this.tipoOrdine = tipoOrdine;
    }

    @Override
    public String toString(){
        return "- Codice Ordine: " + this.cod_ordine +
                "\n- Prezzo: " + this.prezzo +
                "\n- Tipo Pizza: " + this.tipoPizza +
                "\n- Tipo Ordine: " + this.tipoOrdine;
    }

}
