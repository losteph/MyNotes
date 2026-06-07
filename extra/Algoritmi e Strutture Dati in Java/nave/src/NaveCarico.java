import java.util.Stack;

public class NaveCarico {
    private final int capienzaMassima = 3;
    Stack<Merce> stack = new Stack<>();

    public NaveCarico(){

    }

    public void aggiungiMerce(Merce merce){
        this.stack.add(merce);
    }

    public void rimuoviMerce(Merce merce){
        this.stack.remove(merce);
    }
}
