public class Merce {
    private String idMerce;
    private int pianoCarico;
    private float peso;

    //costuttore di default
    public Merce() { this.peso = 0; }

    //costruttore custom
    public Merce(String idMerce, int pianoCarico, float peso){
        this.idMerce = idMerce;
        this.pianoCarico = pianoCarico;
        this.peso = peso;
    }

    //getter e setter
    public String getIdMerce(){ return this.idMerce; }
    public int getPianoCarico(){ return this.pianoCarico; }
    public float getPeso(){ return peso; }

    public void setIdMerce(String idMerce){ this.idMerce = idMerce; }
    public void setPianoCarico(int pianoCarico){ this.pianoCarico = pianoCarico; }
    public void setPeso(float peso){ this.peso = peso; }

    //override toString():
    @Override
    public String toString(){
        return "**************\nID: " + this.idMerce + "\nPiano Carico: " + this.pianoCarico + "\nPeso: " + this.peso + "\n************* \n";
    }
}
