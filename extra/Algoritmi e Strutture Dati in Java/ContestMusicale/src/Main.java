public class Main {
    public static void main(String[] args) {

        Controllore controllore = new Controllore();


        Pass pass1 = new Pass(0025,1,"20:30");
        Musicista musicista1 = new Musicista(pass1);

        Pass pass2 = new Pass(0026,2,"23:00");
        Musicista musicista2 = new Musicista(pass2);
        Musicista musicista3 = new Musicista(pass2);


        Biglietto biglietto1 = new Biglietto("riccardo", "roscica", 1,TipoPosto.PRATO, 5.60);
        Spettatore spettatore1 = new Spettatore(biglietto1,false);

        Biglietto biglietto2 = new Biglietto("mattia", "cipriani", 2,TipoPosto.PRATO, 5.60);
        Spettatore spettatore2 = new Spettatore(biglietto2,false);

        Biglietto biglietto3 = new Biglietto("paolo", "almiento", 3,TipoPosto.VIP, 11.20);
        Spettatore spettatore3 = new Spettatore(biglietto3,false);

        Biglietto biglietto4 = new Biglietto("giacomo", "tufano", 4,TipoPosto.VIP, 11.20);
        Spettatore spettatore4 = new Spettatore(biglietto4,false);

        Biglietto biglietto5 = new Biglietto("carlo", "scalone", 5,TipoPosto.VIP, 11.20);
        Spettatore spettatore5 = new Spettatore(biglietto5,false);


        controllore.inserimento(spettatore1);
        controllore.inserimento(spettatore3);
        controllore.inserimento(spettatore4);
        controllore.inserimento(spettatore2);
        controllore.rimozione(TipoPosto.VIP);
        controllore.inserimento(spettatore5);
        controllore.lettura();

        try{
            controllore.verifica(musicista1);
        } catch (NotValidException e){
            System.out.println(e.getMessage());
        }
        try{
            controllore.verifica(musicista2);
        } catch (NotValidException e){
            System.out.println(e.getMessage());
        }
        try{
            controllore.verifica(musicista3);
        } catch (NotValidException e){
            System.out.println(e.getMessage());
        }

    }
}
