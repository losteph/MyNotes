public class Prenotazione {
    private int numero_prenotazione;
    private String ora_di_arrivo;
    TipoPrenotazione tipoPrenotazione;

    Prenotazione(int numero_prenotazione, String ora_di_arrivo, TipoPrenotazione tipoPrenotazione){
        this.numero_prenotazione = numero_prenotazione;
        this.ora_di_arrivo = ora_di_arrivo;
        this.tipoPrenotazione = tipoPrenotazione;
    }

    public int getNumero_prenotazione() {return numero_prenotazione;}
    public String getOra_di_arrivo() {return ora_di_arrivo;}
    public TipoPrenotazione getTipoPrenotazione() {return tipoPrenotazione;}

    public void setNumero_prenotazione(int numero_prenotazione) {this.numero_prenotazione = numero_prenotazione;}
    public void setOra_di_arrivo(String ora_di_arrivo) {this.ora_di_arrivo = ora_di_arrivo;}
    public void setTipoPrenotazione(TipoPrenotazione tipoPrenotazione) {this.tipoPrenotazione = tipoPrenotazione;}

    @Override
    public String toString(){
        return "Numero Prenotazione: " + this.numero_prenotazione +
                "\nOra di Arrivo: " + this.ora_di_arrivo +
                "\nTipo Consulenza: " + this.tipoPrenotazione;
    }
}
