package Liste;

/**
 * Created by tommasodinoia on 01/05/17.
 */
class SimpleNode<E> {
    private E element;
    private SimpleNode<E> next;

    public SimpleNode(){
        this(null,null);
    }
    public SimpleNode(E e, SimpleNode<E> n){
        element = e;
        next = n;
    }
    public E getElement() {
        return element;
    }
    public SimpleNode<E> getNext() {
        return next;
    }
    public void setNext(SimpleNode<E> n){
        next = n;
    }
    public void setElement(E e){
        element = e;
    }
}