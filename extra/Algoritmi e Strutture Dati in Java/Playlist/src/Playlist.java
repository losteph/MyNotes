import Liste.*;

public class Playlist {
    CircularLinkedList<Brano> listaBrani;
    public CircularLinkedNode<Brano> ultimo_brano_riprodotto;

    //costruttore
    public Playlist() {
        this.listaBrani = new CircularLinkedList<>();
        this.ultimo_brano_riprodotto = this.listaBrani.getHeader();
    }

    //getter
    public CircularLinkedList<Brano> listaBrani() {
        return this.listaBrani;
    }
    //setter
    public void setListaBrani(CircularLinkedList<Brano> listaBrani) {
        this.listaBrani = listaBrani;
    }

    //inserisci nuovo brano alla fine della playlist
    public void inserisci(Brano brano) throws BranoEsistenteException {
        if (this.listaBrani.contains(brano)) {
            throw new BranoEsistenteException("*********************************\nECCEZIONE: Brano già inserito nella Playlist!");
        }
        System.out.println("*********************************");
        System.out.println("Brano inserito!");
        this.listaBrani.insert(brano);
    }

    //rimuovi brano
    public void rimuovi(Brano brano) throws BranoNonEsistenteException {
        if (!this.listaBrani.contains(brano)) {
            throw new BranoNonEsistenteException("*********************************\nECCEZIONE: Brano non esistente nella Playlist!");
        }
        System.out.println("*********************************");
        System.out.println("Brano rimosso!");
        this.listaBrani.remove(brano);
        this.ultimo_brano_riprodotto = this.listaBrani.getHeader();
    }

    //riproduci prossimo brano
    public void riproduci(int succ_prec) throws PlaylistVuotaException {
        if (this.listaBrani.isEmpty()) {
            throw new PlaylistVuotaException("*********************************\nECCEZIONE: Playlist vuota!");
        }
        System.out.println("*********************************\n");
        String riproduzione = "Stai riproducendo il brano:";
        System.out.println(riproduzione);
        if (succ_prec == 0){
            System.out.println(this.ultimo_brano_riprodotto.getElement());
        }
        else if (succ_prec == 1){
            this.ultimo_brano_riprodotto = this.ultimo_brano_riprodotto.getNext();
            System.out.println(this.ultimo_brano_riprodotto.getElement());
        }
        else {
            this.ultimo_brano_riprodotto = this.ultimo_brano_riprodotto.getPrevious();
            System.out.println(this.ultimo_brano_riprodotto.getElement());
        }
    }
}