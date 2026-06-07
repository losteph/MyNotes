package Liste;

/**
 * Created by tommasodinoia on 02/05/17.
 *
 * File Main per giocare con i metodi delle liste
 *
 *
 */
public class Main {
    public static void main(String[] args){

        SimplyLinkedList<Integer> lista = new SimplyLinkedList<Integer>();
        lista.removeFirst();
        lista.removeLast();
        lista.addFirst(5);

        Integer elemento = 4;
        SimpleNode<Integer> pointer = lista.getHead();
        while (pointer.getElement().compareTo(elemento) != 1 )
            pointer = pointer.getNext();

        lista.addBefore(elemento,pointer.getElement());
        lista.addLast(elemento);

        lista.removeFirst();
        lista.removeLast();


        lista.printList();



        DoubleLinkedList<Integer> dLista = new DoubleLinkedList<Integer>();
        dLista.removeFirst();
        dLista.removeLast();

        dLista.addFirst(1);
        dLista.addLast(4);

        dLista.printListFromTrailer();
        dLista.printListFromHeader();

        Integer elemento2 = 5;

        DoubleLinkedNode<Integer> pointer2 = dLista.getHeader();
        do{
            pointer2 = pointer2.getNext();
        } while (pointer2!=dLista.getTrailer() && pointer2.getElement().compareTo(elemento2) != 1);
        //!!! OSSERVAZIONE !!! La condizione del while precedente può generare eccezione se si inverte l'ordine degli operatori del &&

        if(pointer2==dLista.getTrailer())
            dLista.addLast(elemento2);
        else
            dLista.addAfter(elemento2,pointer.getElement());

        dLista.printListFromTrailer();
        dLista.printListFromHeader();

    }
}