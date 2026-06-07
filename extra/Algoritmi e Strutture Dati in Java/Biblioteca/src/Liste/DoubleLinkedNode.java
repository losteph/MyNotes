package Liste;

/**
 * Created by tommasodinoia on 01/05/17.
 */
public class DoubleLinkedNode<E> {
    private E element;
    private DoubleLinkedNode<E> next;
    private DoubleLinkedNode<E> previous;
    public DoubleLinkedNode(){
        this(null,null,null);
    }
    public DoubleLinkedNode(E e, DoubleLinkedNode<E> n, DoubleLinkedNode<E> p){
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

    public DoubleLinkedNode<E> getNext() {
        return next;
    }
    public void setNext(DoubleLinkedNode<E> n){
        next = n;
    }

    public DoubleLinkedNode<E> getPrevious() {
        return previous;
    }
    public void setPrevious(DoubleLinkedNode<E> n){
        previous = n;
    }

}