import net.datastructures.LinkedStack;

public class Post {
    private String id_post;
    private Utente creatore_post;
    private String testo_post;
    private String file_allegato;
    private LinkedStack<Commento> commenti;

    public Post(){}

    public Post(String id_post, Utente creatore_post, String testo_post, String file_allegato){
        this.id_post = id_post;
        this.creatore_post = creatore_post;
        this.testo_post = testo_post;
        this.file_allegato = file_allegato;
        this.commenti = new LinkedStack<>();
    }

    public String getId_post() {
        return id_post;
    }
    public Utente getCreatore_post() {
        return creatore_post;
    }
    public String getTesto_post() {
        return testo_post;
    }
    public String getFile_allegato() {
        return file_allegato;
    }
    public LinkedStack<Commento> getCommenti() {
        return commenti;
    }

    public void setId_post(String id_post) {
        this.id_post = id_post;
    }
    public void setCreatore_post(Utente creatore_post) {
        this.creatore_post = creatore_post;
    }
    public void setTesto_post(String testo_post) {
        this.testo_post = testo_post;
    }
    public void setFile_allegato(String file_allegato) {
        this.file_allegato = file_allegato;
    }
    public void setCommenti(LinkedStack<Commento> commenti) {
        this.commenti = commenti;
    }
}
