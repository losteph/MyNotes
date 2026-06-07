package Liste;

public class CircularLinkedList<E> {

    private CircularLinkedNode<E> header;
    private CircularLinkedNode<E> tailer;
    private int size;

    public CircularLinkedList(){
        header = new CircularLinkedNode<E>();
        tailer = new CircularLinkedNode<E>();
        header.setNext(tailer);
        tailer.setPrevious(header);
        size = 0;
    }

    public CircularLinkedNode<E> getHeader(){
        return header;
    }

    public boolean isEmpty(){
        if(size == 0)
            return true;
        return false;
    }

    public void insert(E newElement){
        // Time Complexity is O(1)

        CircularLinkedNode<E> newNode = new CircularLinkedNode<E>(newElement, null, null);

        if (this.size == 0){
            this.header.setElement(newElement);
            this.tailer = this.header;
            this.header.setNext(this.tailer);
            this.header.setPrevious(this.tailer);
        } else{
            this.tailer.setNext(newNode);
            newNode.setPrevious(this.tailer);
            newNode.setNext(this.header);
            this.tailer = newNode;
            this.header.setPrevious(this.tailer);
        }
        this.size ++;

    }

    public void remove(E removalElement){
        CircularLinkedNode<E> currentNode = this.header;

        if (this.size > 0){
            if (currentNode.getElement().equals(removalElement)){
                this.header = this.header.getNext();
                this.tailer.setNext(this.header);
                this.size -= 1;
            } else {
                do {
                    CircularLinkedNode<E> nextNode = currentNode.getNext();
                    if(nextNode.getElement().equals(removalElement)){
                        currentNode.setNext(nextNode.getNext());
                        nextNode.getNext().setPrevious(currentNode);
                        this.size -= 1;
                        break;
                    }
                    currentNode = currentNode.getNext();
                } while (currentNode != this.header);
            }
        }

    }

    public boolean contains(E containElement){
        CircularLinkedNode<E> currentNode = this.header;

        if (this.size > 0){
            do{
                if(currentNode.getElement().equals(containElement)){
                    return true;
                }
                currentNode = currentNode.getNext();
            }while(currentNode != this.header);
        }
        return false;
    }

    public CircularLinkedNode<E> getTailer() {

        return tailer;
    }

    public int getSize(){

        return size;
    }
}