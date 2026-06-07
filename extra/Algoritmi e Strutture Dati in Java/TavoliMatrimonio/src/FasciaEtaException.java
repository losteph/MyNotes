public class FasciaEtaException extends Exception{
    public FasciaEtaException(){
        super("[ECCEZIONE] Impossibile inserire un invitato Giovane in un tavolo con già presenti o un Adulto o un Anziano");
    }
}