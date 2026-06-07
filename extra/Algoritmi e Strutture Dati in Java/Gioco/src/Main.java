public class Main {
    public static void main(String[] args) {
        Persona persona1 = new Persona("gigi","akak","123");
        Persona persona2 = new Persona("luca","verdi","342");
        Persona persona3 = new Persona("mario","rossi","543");
        Persona persona4 = new Persona("roberto","bianchi","521");
        Persona persona5 = new Persona("ajeje","breazof","ja12");

        Device device1 = new Device("1","1");
        Device device2 = new Device("2","2");
        Device device3 = new Device("3","3");
        Device device4 = new Device("4","4");

        Profilo profilo1 = new Profilo(persona1,"persona1@mail",Locazione.Asia,device1);
        Profilo profilo2 = new Profilo(persona2,"persona2@mail",Locazione.Asia,device2);
        Profilo profilo3 = new Profilo(persona3,"persona3@mail",Locazione.USA,device3);
        Profilo profilo4 = new Profilo(persona4,"persona4@mail",Locazione.Europa,device4);
        Profilo profilo5 = new Profilo(persona5,"persona5@mail",Locazione.Europa,device4);

        Gioco gioco = new Gioco();


        try {
            gioco.richiesta(profilo4);
        } catch (AlredyExistingException e) {
            System.out.println(e.getMessage());
        }
        try {
            gioco.richiesta(profilo1);
        } catch (AlredyExistingException e) {
            System.out.println(e.getMessage());
        }
        try {
            gioco.richiesta(profilo2);
        } catch (AlredyExistingException e) {
            System.out.println(e.getMessage());
        }
        try {
            gioco.richiesta(profilo3);
        } catch (AlredyExistingException e) {
            System.out.println(e.getMessage());
        }

        try {
            gioco.richiesta(profilo5);
        } catch (AlredyExistingException e) {
            System.out.println(e.getMessage());
        }
        //gioco.richiesta(profilo5); //eccezione

        gioco.accesso(Locazione.Europa);
        gioco.accesso(Locazione.Asia);
        gioco.accesso(Locazione.Europa);

        gioco.lista_attesa();

    }
}
