import Eccezioni.LetturaCommentiVuotiException;
import Eccezioni.StringaVuotaException;

public class Main {
    public static void main(String[] args){
        // creo bacheca
        Bacheca bacheca = new Bacheca();

        // creo 2 utenti
        Utente francesca = new Utente("Francesca", "Bianca", "f.bianca");
        Utente marco = new Utente("Marco", "Rossi", "m.rossi");

        // marco e francesca pubblicano un post
        Post post_marco = new Post("0000", marco, "Guardate che bella cover che ho registrato!", "cover.mp4");
        Post post_francesca = new Post("1111", francesca, "Finalmente una bella giornata di sole!", "sole.jpg");

        // inserisci i 2 post
        bacheca.inserisci_post(post_marco);
        bacheca.inserisci_post(post_francesca);

        // marco commenta post di francesca
        try{
            bacheca.inserisci_commento("1111", new Commento(marco, "Bellissima foto!"));
        } catch(StringaVuotaException ex){
            System.out.print(ex.getMessage());
        }

        // francesca legge i commenti al post di marco
        try{
            bacheca.leggi_commenti_post("0000");
        } catch(LetturaCommentiVuotiException ex){
            System.out.print(ex.getMessage());
        }

    }
}