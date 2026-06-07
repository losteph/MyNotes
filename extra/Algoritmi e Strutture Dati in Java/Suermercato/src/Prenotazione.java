public class Prenotazione {
    private TipoPrenotazione tipoPrenotazione;
    private int numeroPrenotazione;
    private String oraDiArrivo;

    //costruttore
    public Prenotazione(TipoPrenotazione tipoPrenotazione, int numeroPrenotazione, String oraDiArrivo){
        this.tipoPrenotazione = tipoPrenotazione;
        this.numeroPrenotazione = numeroPrenotazione;
        this.oraDiArrivo = oraDiArrivo;
    }

    //getter
    public TipoPrenotazione getTipoPrenotazione() {
        return tipoPrenotazione;
    }
    public int getNumeroPrenotazione() {
        return numeroPrenotazione;
    }
    public String getOraDiArrivo() {
        return oraDiArrivo;
    }

    //setter
    public void setTipoPrenotazione(TipoPrenotazione tipoPrenotazione) {
        this.tipoPrenotazione = tipoPrenotazione;
    }
    public void setNumeroPrenotazione(int numeroPrenotazione) {
        this.numeroPrenotazione = numeroPrenotazione;
    }
    public void setOraDiArrivo(String oraDiArrivo) {
        this.oraDiArrivo = oraDiArrivo;
    }

    @Override
    public String toString(){
        return "Prenotazione numero: " + this.numeroPrenotazione +
                "\nOra di Arrivo: " + this.oraDiArrivo +
                "\nTipo Prenotazione: " + this.tipoPrenotazione;
    }
}
