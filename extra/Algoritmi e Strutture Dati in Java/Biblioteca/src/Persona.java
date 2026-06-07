public class Persona {
    String nome;
    String cognome;
    String CF;

    public Persona() {}

    public Persona(String nome, String cognome, String CF){
        this.nome = nome;
        this.cognome = cognome;
        this.CF = CF;
    }

    public String getNome(){
        return this.nome;
    }
    public String getCognome(){
        return this.cognome;
    }
    public String getCF(){
        return this.CF;
    }

    public void setNome(String nome){
        this.nome = nome;
    }
    public void setCognome(String cognome){
        this.cognome = cognome;
    }
    public void setCF(String CF){
        this.CF = CF;
    }
}