import my_package.Enumerativi.*;

public class Automobile {
    private String proprietario;
    private String targa;
    private String casaAutomobilistica;
    private CARBURANTE tipoCarburante;
    private CAMBIO Cambio;
    private int Posti;
    private String immatricolazione;

    //costruttore di default
    public Automobile(){
        this.proprietario = "";
        this.casaAutomobilistica = "";
        this.targa = "0000000";
        this.immatricolazione = "";
        this.tipoCarburante = CARBURANTE.DIESEL;
        this.Cambio = CAMBIO.MANUALE;
        this.Posti = 5;
    }

    //costruttore definito dall'utente
    public Automobile(String proprietario, String targa, String casaAutomobilistica, CARBURANTE tipoCarburante, CAMBIO Cambio, int Posti, String immatricolazione){
        this.proprietario = proprietario;
        if (targa.length() == 7) this.targa = targa;
        this.casaAutomobilistica = casaAutomobilistica;
        this.tipoCarburante = tipoCarburante;
        this.Cambio = Cambio;
        this.Posti = Posti;
        this.immatricolazione = immatricolazione;
    }

    //getter
    public String getProprietario(){return this.proprietario;}
    public String getTarga(){return this.targa;}
    public String getCasaAutomobilistica(){return this.casaAutomobilistica;}
    public CARBURANTE getTipoCarburante(){return this.tipoCarburante;}
    public  CAMBIO getCambio(){return this.Cambio;}
    public int getPosti(){return this.Posti;}
    public String getImmatricolazione(){return this.immatricolazione;}

    //setter
    public void setProprietario(String proprietario){
        this.proprietario = proprietario;
    }
    public void setTarga(String targa) {
        this.targa = targa;
    }
    public void setCasaAutomobilistica(String casaAutomobilistica) {
        this.casaAutomobilistica = casaAutomobilistica;
    }
    public void setTipoCarburante(CARBURANTE tipoCarburante) {
        this.tipoCarburante = tipoCarburante;
    }
    public void setCambio(CAMBIO cambio) {
        Cambio = cambio;
    }
    public void setPosti(int posti) {
        Posti = posti;
    }
    public void setImmatricolazione(String immatricolazione) {
        this.immatricolazione = immatricolazione;
    }

//override toString
    @Override
    public String toString(){
        return "Nome Proprietario: " + this.proprietario +
                "\nTarga: " + this.targa +
                "\nCasa Automobilistica: " + this.casaAutomobilistica +
                "\nTipo Carburante: " + this.tipoCarburante +
                "\nTipo Cambio: " + this.Cambio +
                "\nPosti: " + this.Posti +
                "\nImmatricolazione: " + this.immatricolazione + "\n";
    }


    //override equals
    @Override
    public boolean equals(Object o){
        //se l'oggetto è lo stesso allora la condizione è vera sicuramente
        if (o == this) {
            return true;
        }
        //se l'oggetto non è di tipo Automobile allora la condizione è falsa sicuramente
        if(!(o instanceof Automobile)) {
            return false;
        }
        //cast esplicito dell'oggetto ad Automobile, per confrontare gli attributi richiesti
        Automobile a = (Automobile) o;
        return this.casaAutomobilistica.equals(a.getCasaAutomobilistica()) && this.tipoCarburante == a.getTipoCarburante();


        }
    }
