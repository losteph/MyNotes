import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

public class Pizzeria {
    HashMap<TipoOrdine, Queue<Ordine>> pizzeria;

    public Pizzeria(){
        this.pizzeria = new HashMap<>();
        for(TipoOrdine tipoOrdine : TipoOrdine.values()){
            this.pizzeria.put(tipoOrdine, new LinkedList<>());
        }
    }

    public HashMap<TipoOrdine, Queue<Ordine>> getPizzeria() {
        return pizzeria;
    }
    public void setPizzeria(HashMap<TipoOrdine, Queue<Ordine>> pizzeria) {
        this.pizzeria = pizzeria;
    }


    public void inserimento(Ordine ordine){
        this.pizzeria.get(ordine.getTipoOrdine()).add(ordine);
    }

    public void rimozione(TipoOrdine tipoOrdine){
        this.pizzeria.get(tipoOrdine).remove();
    }

    public void lettura(TipoOrdine tipoOrdine){
        System.out.println("Il prossimo ordine di tipo " + tipoOrdine + " e':");
        System.out.println(this.pizzeria.get(tipoOrdine).peek());
        System.out.println("");
    }
}
