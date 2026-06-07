public class GestoreBiblioteca extends Persona implements GestoreBibliotecaInterface {
    Libreria libreria;

    public GestoreBiblioteca() {}

    public GestoreBiblioteca(String nome, String cognome, String CF){
        super(nome, cognome, CF);
        this.libreria = new Libreria();
    }
    public void ricolloca_libro(){
        this.libreria.rimozione();
    }
}