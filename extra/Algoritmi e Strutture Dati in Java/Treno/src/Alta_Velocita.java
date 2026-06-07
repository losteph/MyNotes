public class Alta_Velocita extends Treno{
    private int capienza_max_vagoni;

    Alta_Velocita(int codice_treno, String produttore, int capienza_max_vagoni) {
        super(codice_treno, produttore);
        this.capienza_max_vagoni = capienza_max_vagoni;
    }

    public int getCapienza_max_vagoni() {
        return capienza_max_vagoni;
    }

    public void setCapienza_max_vagoni(int capienza_max_vagoni) {
        this.capienza_max_vagoni = capienza_max_vagoni;
    }
}
