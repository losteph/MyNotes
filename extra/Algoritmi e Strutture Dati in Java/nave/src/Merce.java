public class Merce implements Etichetta{
    private String id;
    private String descrizione;
    private int peso;
    private int prezzo;

    public Merce(String id, String descrizione, int peso, int prezzo){
        this.id = id;
        this.descrizione = descrizione;
        this.peso = peso;
        this.prezzo = prezzo;
    }

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public String getDescrizione() {
        return descrizione;
    }
    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public int getPeso() {
        return peso;
    }
    public void setPeso(int peso) {
        this.peso = peso;
    }

    public int getPrezzo() {
        return prezzo;
    }
    public void setPrezzo(int prezzo) {
        this.prezzo = prezzo;
    }

    @Override
    public void getEtichetta() {
        System.out.println(this.toString());;
    }

    @Override
    public String toString(){
        return "ID: " + this.id +
                "\nDescrizione: " + this.descrizione +
                "\nPeso: " + this.peso +
                "\nPrezzo: " + this.prezzo;
    }
}
