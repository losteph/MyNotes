public class Paziente {
    private String nome;
    private String cognome;
    private int eta;

    //costruttore
    Paziente(String nome, String cognome, int eta){
        this.nome = nome;
        this.cognome = cognome;
        this.eta = eta;
    }

    //getter
    public String getNome() {return nome;}
    public String getCognome() {return cognome;}
    public int getEta() {return eta;}

    //setter
    public void setNome(String nome) {this.nome = nome;}
    public void setCognome(String cognome) {this.cognome = cognome;}
    public void setEta(int eta) {this.eta = eta;}

    @Override
    public String toString() {
        return "Nome: " + this.nome +
                "\nCognome: " + this.cognome +
                "\nEta': " + this.eta;
    }
}
