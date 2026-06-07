public class Ticket {
    private int cod_ticket;
    private double prezzo;
    private String orario;

    public Ticket(int cod_ticket, double prezzo, String orario){
        this.cod_ticket = cod_ticket;
        this.prezzo = prezzo;
        this.orario = orario;
    }

    public int getCod_ticket() {return cod_ticket;}
    public double getPrezzo() {return prezzo;}
    public String getOrario() {return orario;}

    public void setCod_ticket(int cod_ticket) {this.cod_ticket = cod_ticket;}
    public void setPrezzo(double prezzo) {this.prezzo = prezzo;}
    public void setOrario(String orario) {this.orario = orario;}
}
