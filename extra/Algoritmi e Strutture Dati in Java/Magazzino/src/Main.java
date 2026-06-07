import exceptions.*;

public class Main{
    public static void main(String[] args){
        Merce m1 = new Merce("0000", 1, (float) 23.6);
        Merce m2 = new Merce("0001", 1, (float) 13.5);
        Merce m3 = new Merce("0002", 3, (float) 12.6);
        Merce m4 = new Merce("0003", 3, (float) 10.3);

        float[] maxPesoPerPiano = {(float) 30.2,(float) 18.5, (float) 13.3};
        Magazzino m = new Magazzino(3, 4, maxPesoPerPiano);

        try{
            m.caricaMercePiano(m1, 1);
        } catch (pianoErratoException | slotNonLiberiException | maxPesoException e){
            System.out.println(e.getMessage());
        }
        try{
            m.caricaMercePiano(m2, 1);
        } catch (pianoErratoException | slotNonLiberiException | maxPesoException e){
            System.out.println(e.getMessage());
        }
        try{
            m.caricaMercePiano(m3, 2);
        } catch (pianoErratoException | slotNonLiberiException | maxPesoException e){
            System.out.println(e.getMessage());
        }
        try{
            m.caricaMercePiano(m4, 3);
        } catch (pianoErratoException | slotNonLiberiException | maxPesoException e){
            System.out.println(e.getMessage());
        }

    }
}