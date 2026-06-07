import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

public class Supermercato {
    HashMap<TipoPrenotazione, Queue<Prenotazione>> lista;

    public Supermercato(){
        this.lista = new HashMap<>();
        this.lista.put(TipoPrenotazione.FRUTTA, new LinkedList<>());
        this.lista.put(TipoPrenotazione.MACELLERIA, new LinkedList<>());
        this.lista.put(TipoPrenotazione.SALUMI, new LinkedList<>());
    }

    public void inserimento(Prenotazione prenotazione){
        this.lista.get(prenotazione.getTipoPrenotazione()).add(prenotazione);
    }

    public void rimozione(TipoPrenotazione tipoPrenotazione){
        this.lista.get(tipoPrenotazione).remove();
    }

    public void lettura(TipoPrenotazione tipoPrenotazione){
        System.out.println(lista.get(tipoPrenotazione).toString());
    }

}
