import java.util.LinkedList;

public class Treno {
    private int codice_treno;
    private LinkedList<Vagone> lista_vagone;
    private String produttore;

    Treno(int codice_treno, String produttore){
        this.codice_treno = codice_treno;
        this.lista_vagone = new LinkedList<>();
        this.produttore = produttore;
    }

    public int getCodice_treno() {
        return codice_treno;
    }
    public LinkedList<Vagone> getLista_vagone() {
        return lista_vagone;
    }
    public String getProduttore() {
        return produttore;
    }

    public void setCodice_treno(int codice_treno) {
        this.codice_treno = codice_treno;
    }
    public void setLista_vagone(LinkedList<Vagone> lista_vagone) {
        this.lista_vagone = lista_vagone;
    }
    public void setProduttore(String produttore) {
        this.produttore = produttore;
    }
}
