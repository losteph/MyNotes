import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

public class Gioco {
    HashMap<Locazione, Queue<Profilo>> mappa;


    public Gioco(){
        this.mappa = new HashMap<>();
        this.mappa.put(Locazione.Asia, new LinkedList<>());
        this.mappa.put(Locazione.Europa, new LinkedList<>());
        this.mappa.put(Locazione.USA, new LinkedList<>());
    }

    public void richiesta(Profilo profilo) throws AlredyExistingException {
        if (equals(this.mappa.get(profilo.getDevice().getIp_address()))) {throw new AlredyExistingException();} else {
            this.mappa.get(profilo.getLocazione()).add(profilo);
            System.out.println("profilo messo in attesa...");
        }
    }


    public void accesso(Locazione locazione){
        System.out.println("Accesso al server... ");
        this.mappa.remove(locazione);}

    public void lista_attesa(){
        this.mappa.forEach((locazione, profiloLinkedList) -> profiloLinkedList.forEach((profilo) -> System.out.println(locazione + " : " + profilo)));

    }
}
