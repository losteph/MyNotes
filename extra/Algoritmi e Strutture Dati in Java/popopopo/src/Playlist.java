import Eccezioni.*;
import Liste.*;
import Enumerativi.*;

public class Playlist {
    private DoublyLinkedListCustom<Brano> playlist;
    private Node<Brano> branoCorrente;

    //costruttore
    public Playlist(){this.playlist = new DoublyLinkedListCustom<>();}

    //getter
    public DoublyLinkedListCustom<Brano> listaBrani(){return this.playlist;}
    public Node<Brano> getBranoCorrente(){return this.branoCorrente;}

    //setter
    public void setListaBrani(DoublyLinkedListCustom<Brano> ListaBrani) {this.playlist = ListaBrani;}
    public void setBranoCorrente(Node<Brano> branoCorrente){this.branoCorrente = branoCorrente;}

    //inserire nuovo brano alla fine della playlist
    public void inserisci(Brano brano) throws BranoEsistenteException{
        Node<Brano> currentBrano = this.playlist.first();
        for (int i = 0; i<this.playlist.size(); i++){
            if(currentBrano.getElement().equals(brano)){
                throw new BranoEsistenteException("***[ATTENZIONE] brano già inserito nella playlisti ***");
            }
            currentBrano = currentBrano.getNext();
        }
        System.out.println("*******************");
        System.out.println("Brano inserito!");
        this.playlist.addLast(brano);
        if (this.playlist.size() == 1){
            this.branoCorrente = this.playlist.first();
        }
    }

    //rimuovi brano
    public void rimuovi() throws BranoNonRimuovibileException {
        if (this.branoCorrente.equals(this.playlist.last())){
            throw new BranoNonRimuovibileException("***[Attenzione] impossibile rimuovere il brano (attualmente in riproduzione!)***");
        }
        System.out.println("******************");
        System.out.println("Brano rimosso!");
        this.playlist.removeLast();
    }

    //riproduci brano corrente
    private void riproduci() throws PlaylistVuotaException{
        if(this.playlist.isEmpty()){
            throw new PlaylistVuotaException("***[Attenzione] playlist vuota!***");
        }
        System.out.println("****************");
        System.out.println("Stai riproducendo il brando: ");
        System.out.println(this.branoCorrente.getElement());
    }

    //passa al prossimo brano
    public void prossimoBrano(Direzione direzione) {
        if (direzione == Direzione.AVANTI) {
            this.branoCorrente = this.branoCorrente.getNext();
        } else if (direzione == Direzione.INDIETRO) {
            this.branoCorrente = this.branoCorrente.getPrev();
        }

        try {
            this.riproduci();
        } catch (PlaylistVuotaException e) {
            System.out.println(e.getMessage());
        }
    }
}