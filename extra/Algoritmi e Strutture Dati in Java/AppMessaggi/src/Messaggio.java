public class Messaggio {
    private Contatto mittente;
    private String orario;
    private String testo;

    public Messaggio(){}

    public Messaggio(Contatto mittente, String orario, String testo){
        this.mittente = mittente;
        this.orario = orario;
        this.testo = testo;
    }

    public Contatto getMittente() {
        return mittente;
    }
    public String getOrario() {
        return orario;
    }
    public String getTesto() {
        return testo;
    }

    public void setMittente(Contatto mittente) {
        this.mittente = mittente;
    }
    public void setOrario(String orario) {
        this.orario = orario;
    }
    public void setTesto(String testo) {
        this.testo = testo;
    }

    @Override
    public String toString() {
        return "Mittente: " + this.mittente.getEmail() +
                "\nOrario: " + this.orario +
                "\nTesto: " + this.testo;
    }
}
