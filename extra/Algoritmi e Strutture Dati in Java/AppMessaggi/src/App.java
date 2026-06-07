import java.util.LinkedList;
import java.util.HashMap;
import java.util.Stack;

public class App {
    private HashMap<TipoContatto, Stack<Messaggio>> visualizzazione;
    private LinkedList<Messaggio> buffer;
    private final int max_capacity = 3;

    public App(){
        visualizzazione = new HashMap<>();
        visualizzazione.put(TipoContatto.AMICI, new Stack<>());
        visualizzazione.put(TipoContatto.CONOSCENTI,new Stack<>());
        visualizzazione.put(TipoContatto.PARENTI, new Stack<>());
        buffer = new LinkedList<>();
    }

    public void ricezione(Messaggio messaggio){
        buffer.addLast(messaggio);
    }

    public void visualizzazione() throws LimiteNotificheException, BufferVuotoException {
        if (buffer.isEmpty()) {
            throw new BufferVuotoException("Buffer Vuoto!");
        }
        while(!(buffer.isEmpty())){
            if (visualizzazione.get(buffer.getFirst().getMittente().getTipo_contatto()).size() >= max_capacity){
                throw new LimiteNotificheException(
                        "Limite Notifiche " + buffer.removeFirst().getMittente().getTipo_contatto() + " raggiunto!");
            }
            else {
                visualizzazione.get(buffer.getFirst().getMittente().getTipo_contatto()).push(buffer.removeFirst());
            }
        }
    }

    public void lettura(){
        for(TipoContatto tipo_contatto : TipoContatto.values()) {
            System.out.println("Sto leggendo i messaggi di: " + tipo_contatto);
            while (!(visualizzazione.get(tipo_contatto).isEmpty()))
                System.out.println(visualizzazione.get(tipo_contatto).pop().toString());
            System.out.println("----------------------------------");
        }
    }

}