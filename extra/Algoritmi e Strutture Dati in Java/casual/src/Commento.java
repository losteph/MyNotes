public class Commento {
    private Utente creatore_commento;
    private String testo_commento;

    public Commento(){}

    public Commento(Utente creatore_commento, String testo_commento){
        this.creatore_commento = creatore_commento;
        this.testo_commento = testo_commento;
    }

    public Utente getCreatore_commento() {
        return creatore_commento;
    }
    public String getTesto_commento() {
        return testo_commento;
    }

    public void setCreatore_commento(Utente creatore_commento) {
        this.creatore_commento = creatore_commento;
    }
    public void setTesto_commento(String testo_commento) {
        this.testo_commento = testo_commento;
    }

    @Override
    public String toString(){
        return "- Creatore Commento: " + this.creatore_commento.getNome() + " " + this.creatore_commento.getCognome() +
                "\n- Testo Commento: " + this.testo_commento;
    }
}
