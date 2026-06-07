public class Main {
    public static void main(String [] args) {

        Brano brano1 = new Brano("Let It Be", 1970, "The Beatles", TipoGenere.Rock);
        Brano brano2 = new Brano("God Only Knows", 1966, "The Beach Boys", TipoGenere.Pop);
        Brano brano3 = new Brano("Bohemian Rhapsody", 1975, "Queen", TipoGenere.Rock);

        Playlist pl = new Playlist();

        // inserisco i primi 3 brani
        try{
            pl.inserisci(brano1);
        } catch (BranoEsistenteException e){
            System.out.println(e.getMessage());
        }

        try{
            pl.inserisci(brano2);
        } catch (BranoEsistenteException e){
            System.out.println(e.getMessage());
        }

        try{
            pl.inserisci(brano3);
        } catch (BranoEsistenteException e){
            System.out.println(e.getMessage());
        }

        // riproduco (avanti, avanti, avanti, avanti, indietro)
        try {
            pl.riproduci(0);
        } catch (PlaylistVuotaException e) {
            System.out.println(e.getMessage());
        }

        try {
            pl.riproduci(1);
        } catch (PlaylistVuotaException e) {
            System.out.println(e.getMessage());
        }

        try {
            pl.riproduci(1);
        } catch (PlaylistVuotaException e) {
            System.out.println(e.getMessage());
        }

        try {
            pl.riproduci(1);
        } catch (PlaylistVuotaException e) {
            System.out.println(e.getMessage());
        }

        try {
            pl.riproduci(-1);
        } catch (PlaylistVuotaException e) {
            System.out.println(e.getMessage());
        }

        // rimuovo i brani
        try{
            pl.rimuovi(brano2);
        } catch (BranoNonEsistenteException e) {
            System.out.println(e.getMessage());
        }

        try{
            pl.rimuovi(brano1);
        } catch (BranoNonEsistenteException e) {
            System.out.println(e.getMessage());
        }

        try{
            pl.rimuovi(brano3);
        } catch (BranoNonEsistenteException e) {
            System.out.println(e.getMessage());
        }

        // riproduco
        try {
            pl.riproduci(0);
        } catch (PlaylistVuotaException e) {
            System.out.println(e.getMessage());
        }

        // inserisco il primo brano
        try {
            pl.inserisci(brano1);
        } catch (BranoEsistenteException e) {
            System.out.println(e.getMessage());
        }

        // riproduco
        try {
            pl.riproduci(0);
        } catch (PlaylistVuotaException e) {
            System.out.println(e.getMessage());
        }

        try {
            pl.riproduci(-1);
        } catch (PlaylistVuotaException e) {
            System.out.println(e.getMessage());
        }
    }
}