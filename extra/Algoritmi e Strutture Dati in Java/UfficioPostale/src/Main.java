public class Main {
    public static void main(String[] args) {
        UfficioPostale ufficioPostale = new UfficioPostale();

        Prenotazione prenotazione1 = new Prenotazione(1, "9", TipoPrenotazione.BOLLETTINI);
        Prenotazione prenotazione2 = new Prenotazione(2, "10", TipoPrenotazione.SPEDIZIONI);
        Prenotazione prenotazione3 = new Prenotazione(3, "11", TipoPrenotazione.BOLLETTINI);
        Prenotazione prenotazione4 = new Prenotazione(4, "12", TipoPrenotazione.CONSULENZA);

        ufficioPostale.inserimento(prenotazione1);
        ufficioPostale.inserimento(prenotazione2);
        ufficioPostale.inserimento(prenotazione3);

        ufficioPostale.lettura(TipoPrenotazione.BOLLETTINI);
        ufficioPostale.rimozione(TipoPrenotazione.BOLLETTINI);

        ufficioPostale.inserimento(prenotazione4);
    }
}
