package exceptions;

public class slotNonLiberiException extends Exception{
    public slotNonLiberiException(int piano){
        super("(ECCEZIONE) Non ci sono più slot liberi per il piano " + piano);
    }
}
