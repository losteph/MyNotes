public class merceNazionale implements Etichetta{
    private Merce merce;

    public merceNazionale(Merce merce) {
        this.merce = merce;
        merce.setPrezzo(merce.getPrezzo()*20/100 + merce.getPrezzo());
    }

    public void setMerce(Merce merce) {
        this.merce = merce;
        merce.setPrezzo(merce.getPrezzo()*20/100 + merce.getPrezzo());
    }
    public Merce getMerce() {
        return merce;
    }

    @Override
    public void getEtichetta() {
        System.out.println(this.toString());
    }

    @Override
    public String toString(){
        return "ID: " + this.merce.getId() +
                "\nDescrizione: " + this.merce.getDescrizione() +
                "\nPeso: " + this.merce.getPeso() +
                "\nPrezzo: " + this.merce.getPrezzo();
    }
}
