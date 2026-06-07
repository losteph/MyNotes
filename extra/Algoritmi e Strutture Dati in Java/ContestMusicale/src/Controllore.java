import java.util.*;

public class Controllore {
    HashMap<TipoPosto, Queue<Spettatore>> lista;

    Controllore(){
    this.lista = new HashMap<>();
    this.lista.put(TipoPosto.PRATO, new LinkedList<>());
    this.lista.put(TipoPosto.VIP, new LinkedList<>());
    }

    public void inserimento(Spettatore spettatore){
        this.lista.get(spettatore.getBiglietto().getPosto()).add(spettatore);
        System.out.println("spettatore aggiunto all lista di attesa del contest!");
    }

    public void rimozione(TipoPosto tipoPosto){
        this.lista.get(tipoPosto).remove().setObliterato(true);
    }

    public void lettura(){
            for (TipoPosto tipoPosto : TipoPosto.values()) {
                    for(Spettatore spettatore : lista.get(tipoPosto)){
                        System.out.println(spettatore.getBiglietto().toString());
                    }
                }
            }

    public void verifica(Musicista musicista) throws NotValidException{
        if (musicista.getPass().getTurno_esibizione() == 1){
            System.out.println("Il pass è valido");
        } else {
            throw new NotValidException("il pass non è valido");
        }
    }
}