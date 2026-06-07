package exceptions;

public class maxPesoException extends Exception{
    public maxPesoException(float maxPeso, float pesoCalcolato, int piano){
        super("(ECCEZIONE) Non puoi  caricare una nuova merce al piano " + piano + "" +
                "poichè il peso massimo consentito è " + maxPeso + ", ed il peso attuale è di " + pesoCalcolato);
    }
}
