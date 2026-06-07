import Eccezioni.*;
import Enumerativi.*;

public class Main {
    public static void main(String[] args) {

        Brano brano1 = new Brano("Let it be", 1970, "The Beatles", TipoGenere.ROCK);
        Brano brano2 = new Brano("Smooth Operator", 1984, "Shade", TipoGenere.JAZZ);
        Brano brano3 = new Brano("Bohemian Rhapsody", 1975, "Queen", TipoGenere.ROCK);

        Playlist ste = new Playlist();

        try{
            ste.inserisci(brano1);
        } catch(BranoEsistenteException e){
            System.out.println(e.getMessage());
        }
        try{
            ste.inserisci(brano2);
        } catch(BranoEsistenteException e){
            System.out.println(e.getMessage());
        }
        try{
            ste.inserisci(brano1);
        } catch(BranoEsistenteException e){
            System.out.println(e.getMessage());
        }
        try{
            ste.inserisci(brano3);            System.out.println(e.getMessage());

        } catch(BranoEsistenteException e){
        }

        ste.prossimoBrano(Direzione.FERMO);
        ste.prossimoBrano(Direzione.AVANTI);
        ste.prossimoBrano(Direzione.INDIETRO);
        ste.prossimoBrano(Direzione.AVANTI);
        ste.prossimoBrano(Direzione.AVANTI);
        ste.prossimoBrano(Direzione.FERMO);

        try{
            ste.rimuovi();
        }catch(BranoNonRimuovibileException e){
            System.out.println(e.getMessage());
        }
    }
}