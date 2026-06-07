public class Automobile extends Veicolo{
    private String colore;
    private Ticket ticket;

    public Automobile(String targa, String automobile, String colore, Ticket ticket) {
        super(targa, automobile);
        this.colore = colore;
        this.ticket = ticket;
    }

    public String getColore() {return colore;}
    public Ticket getTicket() {return ticket;}

    public void setColore(String colore) {this.colore = colore;}
    public void setTicket(Ticket ticket) {this.ticket = ticket;}

    @Override
    public String toString(){
        return "Targa: " + this.getTarga() +
                "\nAutomobile: " + this.getAutomobile() +
                "\nColore: " + this.colore +
                "\nTicket: " + this.ticket.getCod_ticket();
    }
}