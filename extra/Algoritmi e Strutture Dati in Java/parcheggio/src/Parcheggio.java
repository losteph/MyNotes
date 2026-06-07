import java.util.Stack;

public class Parcheggio {
    private final int capienza_max = 4;
    private Stack<Veicolo> pila;

    Parcheggio(){
        this.pila = new Stack<>();
    }

    public void inserimento(Automobile automobile) throws ParkingFullException{
        if(this.pila.size() == capienza_max){
            throw new ParkingFullException("Non è più disponibile posto per parcheggiare");
        } else {
            this.pila.push(automobile);
        }
    }

    public void rimozione() throws ParkingEmptyExceptio{
        if(this.pila.size() == 0){
            throw new ParkingEmptyExceptio("Non ci sono ancora macchine nel parcheggio");
        } else {
            this.pila.pop();
        }
    }

    public void lettura(){
        System.out.println(this.pila.peek().toString());
    }

    public void verifica(Autocarro autocarro) throws NotValidException{
        if (autocarro.getCarico().getTipo_carico() == TipoCarico.leggero && !autocarro.getCarico().isFragile()){
                System.out.println("L'autocarro può superare la stazione");
        } else {
            throw new NotValidException("L'autocarro non può superare la stazione");
        }
    }
}
