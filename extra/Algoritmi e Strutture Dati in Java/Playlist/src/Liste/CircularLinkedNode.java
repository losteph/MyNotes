package Liste;

public class CircularLinkedNode<E> {
    private E element;
    private CircularLinkedNode<E> next;
    private CircularLinkedNode<E> previous;

    public CircularLinkedNode(){

        this(null,null,null);
    }

    public CircularLinkedNode(E e, CircularLinkedNode<E> n, CircularLinkedNode<E> p){
        element = e;
        next = n;
        previous = p;
    }

    public E getElement() {

        return element;
    }

    public void setElement(E e){

        element = e;
    }

    public CircularLinkedNode<E> getNext() {

        return next;
    }

    public void setNext(CircularLinkedNode<E> n){

        next = n;
    }

    public CircularLinkedNode<E> getPrevious() {
        return previous;
    }
    public void setPrevious(CircularLinkedNode<E> n){
        previous = n;
    }
}