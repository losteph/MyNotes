public class AntipaticiException extends Exception{
    public AntipaticiException(String A, String B){
        super("[ECCEZIONE] Impossibile inserire " + A + " allo stesso tavolo con B");
    }
}
