import exceptions.*;

public class Magazzino {
    private int numeroPiani;
    private int numeroMerciPiano;
    private float[] pesoMaxPerPiano;
    private Merce[][] ascensore;

    //costruttore di default
    public Magazzino(){}

    public Magazzino(int numeroPiani, int numeroMerciPiano, float[] pesoMaxPerPiano){
        this.numeroPiani = numeroPiani;
        this.numeroMerciPiano = numeroMerciPiano;
        this.pesoMaxPerPiano = pesoMaxPerPiano;
        this.ascensore = new Merce[numeroPiani][numeroMerciPiano];

        //inizializzare l'ascensore a merci dal peso 0.0 (usando il costruttore di defaul di Merce)
        for(int i = 0; i < numeroPiani; i++){
            for(int j = 0; j < numeroMerciPiano; j++){
                ascensore[i][j] = new Merce();
            }
        }
    }
    //getter e setter
    public int getNumeroPiani(){return this.numeroPiani; }
    public int getNumeroMerciPiano(){return numeroMerciPiano; }
    public float[] getPesoMaxPerPiano(){return pesoMaxPerPiano; }
    public Merce[][] getAscensore(){return ascensore; }

    public void setNumeroPiani(int numeroPiani){this.numeroPiani = numeroPiani; }
    public void setNumeroMerciPiano(int numeroMerciPiano){this.numeroMerciPiano = numeroMerciPiano; }
    public void setPesoMaxPerPiano(float[] pesoMaxPerPiano){this.pesoMaxPerPiano = pesoMaxPerPiano; }
    public void setAscensore(Merce[][] ascensore){this.ascensore = ascensore; }


    public void caricaMercePiano(Merce m, int piano) throws pianoErratoException, slotNonLiberiException, maxPesoException{
        if(m.getPianoCarico() != piano){
            throw new pianoErratoException(piano);
        }

        boolean slotLiberi = false;
        float pesoTotale = 0;
        for(int j=0; j<this.numeroMerciPiano; j++){
            pesoTotale += this.ascensore[piano - 1][j].getPeso();
            if(this.ascensore[piano - 1][j].getPeso() == 0.0){
                slotLiberi = true;
                if(pesoTotale + m.getPeso() <= this.pesoMaxPerPiano[piano - 1]){
                    this.ascensore[piano-1][j] = m;
                    System.out.println("\nE' stata caricata la seguente merce: ");
                    System.out.print(m);
                    break; //esco dal ciclo for, ho caricato la merce e non ho bisogo di restare
                } else {
                    throw new maxPesoException(this.pesoMaxPerPiano[piano-1], pesoTotale + m.getPeso(), piano);
                }
            }
        }
        if(!slotLiberi){
            throw new slotNonLiberiException(piano);
        }
    }
}