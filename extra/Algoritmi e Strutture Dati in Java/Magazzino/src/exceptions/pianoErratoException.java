package exceptions;

public class pianoErratoException extends Exception{
    public pianoErratoException(int piano){
        super("(ECCEZIONE) Non puoi caricare merce al piano " + piano);
    }
}
