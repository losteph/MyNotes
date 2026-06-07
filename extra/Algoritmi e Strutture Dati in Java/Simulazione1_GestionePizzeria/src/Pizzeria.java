import java.util.HashMap;
import java.util.LinkedList;

public class Pizzeria {
    private HashMap<TipoOrdine, LinkedList<Ordine>> OrdiniPizzeria;

    public Pizzeria(){
        this.OrdiniPizzeria = new HashMap<>();
        this.OrdiniPizzeria.put(TipoOrdine.Asporto, new LinkedList<>());
        this.OrdiniPizzeria.put(TipoOrdine.Domicilio, new LinkedList<>());
    }

    public HashMap<TipoOrdine, LinkedList<Ordine>> getOrdiniPizzeria() {return OrdiniPizzeria;}

    public void setOrdiniPizzeria(HashMap<TipoOrdine, LinkedList<Ordine>> ordiniPizzeria) {
        OrdiniPizzeria = ordiniPizzeria;
    }

    public void aggiungi_ordine(Ordine ordine) {this.OrdiniPizzeria.get(ordine.getTipoOrdine()).addLast(ordine);}
    public void rimuovi_ordine(TipoOrdine tipo_ordine){
        this.OrdiniPizzeria.get(tipo_ordine).removeFirst();
    }

    public void leggi_ordine(TipoOrdine tipo_ordine){
        System.out.println("il prossimo ordine per " + tipo_ordine + " è:");
        System.out.print(this.OrdiniPizzeria.get(tipo_ordine).getFirst());
        System.out.print("\n\n");
    }
}
