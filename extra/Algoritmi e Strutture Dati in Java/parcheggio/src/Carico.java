public class Carico {
    private TipoCarico tipo_carico;
    private double peso;
    private boolean fragile;

    public Carico(TipoCarico tipo_carico, double peso, boolean fragile){
        this.tipo_carico = tipo_carico;
        this.peso = peso;
        this.fragile = fragile;
    }

    public TipoCarico getTipo_carico(){return this.tipo_carico;}
    public double getPeso(){return this.peso;}
    public boolean isFragile(){return this.fragile;}

    public void setTipo_carico(TipoCarico tipo_carico){this.tipo_carico = tipo_carico;}
    public void setPeso(double peso){this.peso = peso;}
    public void setFragile(boolean fragile){this.fragile = fragile;}
}
