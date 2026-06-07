public class Main {
    public static void main(String[] args) {

        Contatto amico2 = new Contatto("giacomo@email.it", TipoContatto.AMICI, "1234" );
        Contatto amico1 = new Contatto("riccardo@email.it", TipoContatto.AMICI, "4321");
        Contatto conoscente1 = new Contatto("luigi@email.com", TipoContatto.CONOSCENTI, "321");
        Contatto parente1 = new Contatto("andrea@email", TipoContatto.PARENTI, "123");

        App app = new App();

        Messaggio messaggio1 = new Messaggio(amico1, "12:00", "Asdrubale");
        Messaggio messaggio2 = new Messaggio(amico1, "12:25", "Ho letto la tua mail");
        Messaggio messaggio3 = new Messaggio(amico1,"12:30","Tutto bene?");

        Messaggio messaggio4 = new Messaggio(amico2, "13:00", "Memma Ricca");
        Messaggio messaggio5 = new Messaggio(amico2, "13:01","Sta memo");
        Messaggio messaggio6 = new Messaggio(amico2, "13:05","So nu meme");

        Messaggio messaggio7 = new Messaggio(parente1, "15:00", "buongiorno");

        Messaggio messaggio8 = new Messaggio(conoscente1, "13:00", "kk");

        app.ricezione(messaggio1);
        app.ricezione(messaggio4);

        try{
            app.visualizzazione();
        } catch (BufferVuotoException | LimiteNotificheException e){
            System.out.println(e.getMessage());
        }
        try{
            app.visualizzazione();
        } catch (BufferVuotoException | LimiteNotificheException e){
            System.out.println(e.getMessage());
        }

        app.lettura();

        app.ricezione(messaggio2);
        app.ricezione(messaggio3);
        app.ricezione(messaggio5);

        try{
            app.visualizzazione();
        } catch(BufferVuotoException | LimiteNotificheException e){
            System.out.println(e.getMessage());
        }

        app.ricezione(messaggio6);

        try{
            app.visualizzazione();
        } catch(BufferVuotoException | LimiteNotificheException e){
            System.out.println(e.getMessage());
        }

        app.ricezione(messaggio7);
        app.ricezione(messaggio8);

        try{
            app.visualizzazione();
        } catch(BufferVuotoException | LimiteNotificheException e){
            System.out.println(e.getMessage());
        }

        app.lettura();

    }
}
