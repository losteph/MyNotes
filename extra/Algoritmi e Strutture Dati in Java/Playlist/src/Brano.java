public class Brano {

    public String titolo;
    public int anno;
    public String autore;
    TipoGenere genere;

    public Brano(){}

    //costruttore
    public Brano(String titolo, int anno, String autore, TipoGenere genere){
        this.titolo = titolo;
        this.anno = anno;
        this.autore = autore;
        this.genere = genere;
    }

    //getter
    public String getTitolo(){return this.titolo;}
    public int getAnno(){return this.anno;}
    public String getAutore(){return this.autore;}
    public TipoGenere getGenere(){return this.genere;}

    //setter
    public void setTitolo(String titolo){this.titolo = titolo;}
    public void setAnno(int anno){this.anno = anno;}
    public void setAutore(String autore){this.autore = autore;}
    public void setGenere(TipoGenere genere){this.genere = genere;}

    @Override
    public String toString(){
        return "\nTitolo: " + this.titolo +
                "\nAnno: " + this.anno +
                "\nAutore: " + this.autore +
                "\nGenere: " + this.genere;
    }
}
