import Liste.*;

public class Libreria {
    SimplyLinkedList<Libro> libri_restituiti;

    public Libreria() {
        libri_restituiti = new SimplyLinkedList<>();
    }

    public SimplyLinkedList<Libro> getLibri_restituiti() {
        return libri_restituiti;
    }

    public void setLibri_restituiti(SimplyLinkedList<Libro> libri_restituiti) {
        this.libri_restituiti = libri_restituiti;
    }

    public void inserimento(Libro libro){
        System.out.println("\nLibro restituito!");
        this.libri_restituiti.addFirst(libro);
    }

    public void rimozione(){
        System.out.println("\nLibro ricollocato!");
        this.libri_restituiti.removeFirst();
    }

    public void lettura() throws NessunLibroInseritoException{
        if (this.libri_restituiti.isEmpty()){
            throw new NessunLibroInseritoException("Non è stato ancora restituito nessun libro!");
        }
        System.out.println("\nUltimo libro restituito: ");
        System.out.println(this.libri_restituiti.getFirst().toString());
    }
}
