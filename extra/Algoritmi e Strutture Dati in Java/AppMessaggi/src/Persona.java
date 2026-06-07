public class Persona {
    private String nome;
    private String cognome;
    private String cod_fiscale;

    public Persona(){}

    //costruttore
    public Persona(String nome, String cognome, String cod_fiscale){
        this.nome = nome;
        this.cognome = cognome;
        this.cod_fiscale = cod_fiscale;
    }

    //getter
    public String getNome() {return nome;}
    public String getCognome() {return cognome;}
    public String getCod_fiscale() {return cod_fiscale;}

    //setter
    public void setNome(String nome) {this.nome = nome;}
    public void setCognome(String cognome) {this.cognome = cognome;}
    public void setCod_fiscale(String cod_fiscale) {this.cod_fiscale = cod_fiscale;}


    @Override
    public String toString() {
        return "Nome: " + this.nome +
                "\nCognome: " + this.cognome;
    }
}
