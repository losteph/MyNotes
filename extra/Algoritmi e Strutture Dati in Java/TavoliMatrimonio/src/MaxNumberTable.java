public class MaxNumberTable extends Exception{
    public MaxNumberTable(int maxTavolo){
        super("[ECCEZIONE] Impossibile inserire un nuovo invitato poichè il tavolo è da massimo " + maxTavolo + " persone");
    }
}
