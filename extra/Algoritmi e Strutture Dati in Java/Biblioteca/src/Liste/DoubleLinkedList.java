package Liste;

/**
 * Created by tommasodinoia on 01/05/17.
 */
public class DoubleLinkedList<E> {
    private DoubleLinkedNode<E> header;
    private DoubleLinkedNode<E> trailer;
    private int size;

    public DoubleLinkedList(){
        header = new DoubleLinkedNode<E>();
        trailer = new DoubleLinkedNode<E>();
        header.setNext(trailer);
        trailer.setPrevious(header);
        size = 0;
    }

    public DoubleLinkedNode getHeader(){
        return header;
    }

    public DoubleLinkedNode<E> getTrailer() {
        return trailer;
    }

    public int getSize(){
        return size;
    }
    public boolean isEmpty(){
        if(size == 0)
            return true;
        return false;
    }
    public E getFirst(){
        if(this.isEmpty())
            return null;
        return header.getNext().getElement();
    }
    public E getLast(){
        if(this.isEmpty())
            return null;
        return trailer.getPrevious().getElement();
    }

    public void addBetween(E newElement, DoubleLinkedNode<E> predecessor, DoubleLinkedNode<E> successor){
        DoubleLinkedNode<E> newNode = new DoubleLinkedNode<E>(newElement,successor,predecessor);
        predecessor.setNext(newNode);
        successor.setPrevious(newNode);
        size++;
    }

    public void addFirst(E e){
        this.addBetween(e,header,header.getNext());
    }

    public void addLast(E e){
        this.addBetween(e,trailer.getPrevious(),trailer);
    }


    public void addBefore(E newElement, E e){
        /*
        Questo if andrebbe migliorato attraverso la gestione delle eccezione di listaVuota
         */
        if(this.isEmpty())
            this.addFirst(newElement);
        else {
            DoubleLinkedNode<E> cursore;

            cursore = header.getNext();

            while (cursore.getElement() != e && cursore.getNext() != null)
                cursore = cursore.getNext();

            this.addBetween(newElement, cursore.getPrevious(), cursore);
        }
    }

    public void addAfter(E newElement, E e){
        /*
        Questo if andrebbe migliorato attraverso la gestione delle eccezione di listaVuota
         */
        if(this.isEmpty())
            this.addFirst(newElement);
        else {
            DoubleLinkedNode<E> cursore;

            cursore = header.getNext();

            while (cursore.getElement() != e && cursore.getNext() != null)
                cursore = cursore.getNext();

            if (cursore.getNext() == null)
                this.addBetween(newElement, header, trailer);
            else
                this.addBetween(newElement, cursore, cursore.getNext());
        }
    }


    public E remove(DoubleLinkedNode<E> node){
        DoubleLinkedNode<E> predecessor = node.getPrevious();
        DoubleLinkedNode<E> successor = node.getNext();
        predecessor.setNext(successor);
        successor.setPrevious(predecessor);
        size--;
        return node.getElement();
    }

    public E removeFirst(){
        if(this.isEmpty())
            return null;
        return this.remove(header.getNext());
    }

    public E removeLast(){
        if(this.isEmpty())
            return null;
        return remove(trailer.getPrevious());
    }

    public int getPosition(E e){
        DoubleLinkedNode<E> cursore;
        int index;

        if(this.isEmpty())
            return 0;
        cursore = header;
        index = 1;
        while(cursore.getNext().getElement()!= e && cursore.getNext() != null) {
            cursore = cursore.getNext();
            index++;
        }
        if(cursore.getNext() == null)
            return 0;
        return index;
    }



    public void printListFromHeader(){
        DoubleLinkedNode<E> cursore = header.getNext();
        for(int i = 0; i < this.getSize(); i++){
            System.out.println(cursore.getElement());
            cursore = cursore.getNext();
        }
    }

    public void printListFromTrailer(){
        DoubleLinkedNode<E> cursore = trailer.getPrevious();
        for(int i = 0; i < this.getSize(); i++){
            System.out.println(cursore.getElement());
            cursore = cursore.getPrevious();
        }
    }



}