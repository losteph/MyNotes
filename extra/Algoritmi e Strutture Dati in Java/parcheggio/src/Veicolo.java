public class Veicolo {
    private String targa;
    private String automobile;

    public Veicolo(String targa, String automobile){
        this.targa = targa;
        this.automobile = automobile;
    }

    public String getTarga() {
        return targa;
    }
    public String getAutomobile() {
        return automobile;
    }

    public void setTarga(String targa) {
        this.targa = targa;
    }
    public void setAutomobile(String automobile) {
        this.automobile = automobile;
    }

}
