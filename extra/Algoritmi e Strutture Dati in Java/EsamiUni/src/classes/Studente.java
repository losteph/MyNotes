package classes;

public class Studente {
    private String nome;
    private String cognome;
    private String email;
    private int votazione;

    // costruttore di default
    public Studente(){
        this.nome = "nome";
        this.cognome = "cognome";
        this.email = "email";
        this.votazione = 0;
    }

    // costruttore custom
    public Studente(String nome, String cognome, String email, int votazione){
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.votazione = votazione;
    }

    // getter
    public String getNome(){
        return this.nome;
    }
    public String getCognome(){
        return this.cognome;
    }
    public String getEmail(){
        return this.email;
    }
    public int getVotazione(){
        return this.votazione;
    }

    // setter
    public void setNome(String nome) {
        this.nome = nome;
    }
    public void setCognome(String cognome) {
        this.cognome = cognome;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setVotazione(int votazione) {
        this.votazione = votazione;
    }
}
