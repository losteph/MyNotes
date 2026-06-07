public class merceInternazionale implements Etichetta{
    private Merce merce;

    public merceInternazionale(Merce merce){
        this.merce = merce;
        merce.setPrezzo(merce.getPrezzo()*25/100 + merce.getPrezzo());
    }

    public Merce getMerce() {
        return merce;
    }

    public void setMerce(Merce merce) {
        this.merce = merce;
        merce.setPrezzo(merce.getPrezzo()*25/100 + merce.getPrezzo());
    }

    @Override
    public void getEtichetta() {
        System.out.println(this.toString());
    }

    @Override
    public String toString(){
        return "ID: " + this.merce.getId() +
                "\nDescrizione: " + this.merce.getDescrizione() + " (traduzione):" + this.merce.getDescrizione() +
                "\nPeso: " + this.merce.getPeso() +
                "\nPrezzo: " + this.merce.getPrezzo();
    }
}
