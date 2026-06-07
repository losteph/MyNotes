import Eccezioni.LetturaCommentiVuotiException;
import Eccezioni.StringaVuotaException;

import java.util.HashMap;

public class Bacheca {
    private HashMap<String, Post> bacheca;

    public Bacheca(){this.bacheca = new HashMap<>();}

    public HashMap<String, Post> getBacheca(){return bacheca;}
    public void setBacheca(HashMap<String, Post> bacheca){this.bacheca = bacheca;}

    public void inserisci_post(Post post){this.bacheca.putIfAbsent(post.getId_post(), post);}

    public void inserisci_commento(String id_post, Commento commento) throws StringaVuotaException{
        if (commento.getTesto_commento().equals("")){
            throw new StringaVuotaException("ATTENZIONE! Il commento da inserire è vuoto!");
        }
        this.bacheca.get(id_post).getCommenti().push(commento);
    }

    public void leggi_commenti_post(String id_post) throws LetturaCommentiVuotiException {
        if (this.bacheca.get(id_post).getCommenti().isEmpty()){
            throw new LetturaCommentiVuotiException("ATTENZIONE! Il post non presenta ancora commenti da leggere");
        }
        System.out.println("\nLettura Post " + id_post + ":");
        for(int i = 0; i < this.bacheca.get(id_post).getCommenti().size(); i++){
            System.out.print(this.bacheca.get(id_post).getCommenti().pop());
        }
    }
}
