public class Main {
    public static void main(String[] args) {
        Supermercato supermercato = new Supermercato();
        Prenotazione prenotazione1 = new Prenotazione(TipoPrenotazione.MACELLERIA, 1, "9");
        Prenotazione prenotazione2 = new Prenotazione(TipoPrenotazione.FRUTTA, 2, "10");
        Prenotazione prenotazione3 = new Prenotazione(TipoPrenotazione.SALUMI, 3, "11");
        Prenotazione prenotazione4 = new Prenotazione(TipoPrenotazione.MACELLERIA, 4, "12");

        supermercato.inserimento(prenotazione1);
        supermercato.inserimento(prenotazione2);
        supermercato.inserimento(prenotazione3);

        supermercato.lettura(TipoPrenotazione.SALUMI);
        supermercato.rimozione(TipoPrenotazione.SALUMI);

        supermercato.inserimento(prenotazione4);
    }
}
