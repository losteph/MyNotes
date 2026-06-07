import java.util.ListIterator;

public class Editor {
    private Alta_Velocita treno_a;
    private Regionale treno_r;

    Editor(Alta_Velocita treno_a, Regionale treno_r){
        this.treno_a = treno_a;
        this.treno_r = treno_r;
    }

    public void inserimento_A(Vagone vagone) throws TrainFullException{
        if (this.treno_a.getLista_vagone().size() >= treno_a.getCapienza_max_vagoni()){
            throw new TrainFullException("NUMERO MASSIMO DI VAGONI RAGGIUNTI");
        } else {
            this.treno_a.getLista_vagone().addFirst(vagone);
        }
    }

    public void inserimento_R(Vagone vagone){
        this.treno_r.getLista_vagone().addFirst(vagone);
    }

    public void rimozione_A() throws TrainEmptyException{
        if(this.treno_a.getLista_vagone().isEmpty()){
            throw new TrainEmptyException("IL TRENO E' VUOTO");
        } else {
            this.treno_a.getLista_vagone().removeFirst();
        }
    }

    public void rimozione_R() throws TrainEmptyException{
        if(this.treno_r.getLista_vagone().isEmpty()){
            throw new TrainEmptyException("IL TRENO E' VUOTO");
        } else {
            this.treno_r.getLista_vagone().removeFirst();
        }
    }

    public void lettura_A(){
        ListIterator<Vagone> iterator = treno_a.getLista_vagone().listIterator(treno_a.getLista_vagone().size());
        while(iterator.hasPrevious()) {
            System.out.println(iterator.previous().toString());
        }
    }

    public void lettura_R(){
        ListIterator<Vagone> iterator = treno_r.getLista_vagone().listIterator(treno_r.getLista_vagone().size());
        while(iterator.hasPrevious()) {
            System.out.println(iterator.previous().toString());
        }
    }
}
