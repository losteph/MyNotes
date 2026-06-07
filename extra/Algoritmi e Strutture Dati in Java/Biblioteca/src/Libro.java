public class Libro {
    String titolo;
    String autore;
    GenereLibro genere;

    public Libro() {}

    public Libro(String titolo, String autore, GenereLibro genere){
        this.titolo = titolo;
        this.autore = autore;
        this.genere = genere;
    }

    public String getTitolo(){
        return this.titolo;
    }
    public String getAutore(){
        return this.autore;
    }
    public GenereLibro genere(){
        return this.genere;
    }

    public void setTitolo(String titolo){
        this.titolo = titolo;
    }
    public void setAutore(String autore){
        this.autore = autore;
    }
    public void setGenere(GenereLibro genere){
        this.genere = genere;
    }

    @Override
    public String toString(){
        return "\nTitolo Libro: " + this.titolo +
                "\nAutore: " + this.autore +
                "\nGenere: " + this.genere;
    }
}
