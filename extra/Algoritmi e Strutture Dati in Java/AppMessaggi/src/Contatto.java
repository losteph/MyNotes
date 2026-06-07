public class Contatto extends Persona{
    private String email;
    private TipoContatto tipo_contatto;
    private String password;

    public Contatto(){}

    public Contatto(String email, TipoContatto tipo_contatto, String password){
        this.email = email;
        this.tipo_contatto = tipo_contatto;
        this.password = password;
    }

    public String getEmail() {return email;}
    public TipoContatto getTipo_contatto() {return tipo_contatto;}
    public String getPassword() {return password;}

    public void setEmail(String email) {this.email = email;}
    public void setTipo_contatto(TipoContatto tipo_contatto) {this.tipo_contatto = tipo_contatto;}
    public void setPassword(String password) {this.password = password;}



    @Override
    public String toString() {
        return "Email: " + this.email +
                "\nTipo Contatto: " + this.tipo_contatto;
    }
}
