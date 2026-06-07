public class Main {
    public static void main(String[] args){
        Libro libro1 = new Libro("Guerra e Pace", "Lev Tolstoj", GenereLibro.LETTERATURA);
        Libro libro2 = new Libro("Il mastino dei Baskerville", "Arthur Conan Doyle", GenereLibro.GIALLO);
        Libro libro3 = new Libro("It", "Stephen King", GenereLibro.HORROR);

        GestoreBiblioteca gestoreBiblioteca = new GestoreBiblioteca("Mario", "Rossi", "00xxAA");

        try{
            gestoreBiblioteca.libreria.lettura();
        } catch (NessunLibroInseritoException e){
            System.out.println(e.getMessage());
        }

        gestoreBiblioteca.libreria.inserimento(libro1);
        gestoreBiblioteca.libreria.inserimento(libro2);

        gestoreBiblioteca.ricolloca_libro();

        gestoreBiblioteca.libreria.inserimento(libro3);

        try{
            gestoreBiblioteca.libreria.lettura();
        } catch (NessunLibroInseritoException e){
            System.out.println(e.getMessage());
        }
    }
}