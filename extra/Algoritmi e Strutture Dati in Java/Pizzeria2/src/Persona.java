public class Persona {
    private String nome, cognome, CF;

    public Persona(String nome, String cognome, String CF){
        this.nome = nome;
        this.cognome = cognome;
        this.CF = CF;
    }

    public String getNome() {
        return nome;
    }

    public String getCognome() {
        return cognome;
    }

    public String getCF() {
        return CF;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public void setCF(String CF) {
        this.CF = CF;
    }

}
