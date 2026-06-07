public class Main {
    public static void main(String[] args) {
        Carico carico1 = new Carico(TipoCarico.leggero, 30,true);
        Carico carico2 = new Carico(TipoCarico.leggero, 25, false);
        Carico carico3 = new Carico(TipoCarico.pesante, 100, true);
        Autocarro autocarro1 = new Autocarro("abc", "ducati", carico1);
        Autocarro autocarro2 = new Autocarro("gg", "doblo", carico2);
        Autocarro autocarro3 = new Autocarro("aaa", "mercedes",carico3);
        Ticket ticket1 = new Ticket(1,2.5,"12");
        Ticket ticket2 = new Ticket(2,2.5,"13");
        Ticket ticket3 = new Ticket(3,2.5,"14");
        Ticket ticket4 = new Ticket(4,2.5,"15");
        Ticket ticket5 = new Ticket(5,2.5,"16");
        Automobile automobile1 = new Automobile("a", "bmw", "blue", ticket1);
        Automobile automobile2 = new Automobile("b", "bmw", "red", ticket2);
        Automobile automobile3 = new Automobile("c", "bmw", "yellow", ticket3);
        Automobile automobile4 = new Automobile("d", "bmw", "green", ticket4);
        Automobile automobile5 = new Automobile("e", "bmw", "orange", ticket5);

        Parcheggio parcheggio = new Parcheggio();

        try {
            parcheggio.rimozione();
        } catch (ParkingEmptyExceptio e) {
            System.out.println(e.getMessage());
        }
        try {
            parcheggio.inserimento(automobile1);
        } catch (ParkingFullException e) {
            System.out.println(e.getMessage());
        }
        try {
            parcheggio.inserimento(automobile2);
        } catch (ParkingFullException e) {
            System.out.println(e.getMessage());
        }
        try {
            parcheggio.inserimento(automobile3);
        } catch (ParkingFullException e) {
            System.out.println(e.getMessage());
        }
        try {
            parcheggio.inserimento(automobile4);
        } catch (ParkingFullException e) {
            System.out.println(e.getMessage());
        }
        try {
            parcheggio.inserimento(automobile5);
        } catch (ParkingFullException e) {
            System.out.println(e.getMessage());
        }
        try {
            parcheggio.rimozione();
        } catch (ParkingEmptyExceptio e){
            System.out.println(e.getMessage());
        }

        parcheggio.lettura();

        try {
            parcheggio.inserimento(automobile5);
        } catch (ParkingFullException e) {
            System.out.println(e.getMessage());
        }

        try {
            parcheggio.verifica(autocarro1);
        } catch (NotValidException e) {
            System.out.println(e.getMessage());
        }
        try {
            parcheggio.verifica(autocarro2);
        } catch (NotValidException e) {
            System.out.println(e.getMessage());
        }
        try {
            parcheggio.verifica(autocarro3);
        } catch (NotValidException e) {
            System.out.println(e.getMessage());
        }
    }
}
