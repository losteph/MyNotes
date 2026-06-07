import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

public class UfficioPostale {
    HashMap<TipoPrenotazione, Queue<Prenotazione>> mappaPrenotazione;

    UfficioPostale(){
        mappaPrenotazione = new HashMap<>();
        this.mappaPrenotazione.put(TipoPrenotazione.BOLLETTINI, new LinkedList<>());
        this.mappaPrenotazione.put(TipoPrenotazione.SPEDIZIONI, new LinkedList<>());
        this.mappaPrenotazione.put(TipoPrenotazione.CONSULENZA, new LinkedList<>());
    }

    public void inserimento(Prenotazione prenotazione){
        this.mappaPrenotazione.get(prenotazione.getTipoPrenotazione()).add(prenotazione);
        System.out.println("Prenotazione inserita con successo!");
    }

    public void rimozione(TipoPrenotazione tipoPrenotazione){
        this.mappaPrenotazione.get(tipoPrenotazione).remove();
        System.out.println("rimozione avvenuta con successo");
    }

    public void lettura(TipoPrenotazione tipoPrenotazione){
        System.out.println(this.mappaPrenotazione.get(tipoPrenotazione).peek());
    }
}
