public class Main {
    public static void main(String[] args) {
        String[] antipaticiAndrea = {"Luca", "Maria"};
        Invitato andrea = new Invitato("Andrea", FasciaEta.Giovane, antipaticiAndrea);

        String[] antipaticiMaria = {"Francesca"};
        Invitato maria = new Invitato("Maria", FasciaEta.Adulto, antipaticiMaria);

        String[] antipaticiLuca = {"Giovanni"};
        Invitato luca = new Invitato("Luca", FasciaEta.Anziano, antipaticiLuca);

        String[] antipaticiFrancesca = {"Andrea", "Maria"};
        Invitato francesca = new Invitato("Francesca", FasciaEta.Giovane, antipaticiFrancesca);

        String[] antipaticiGiovanni = {"Luca", "Giorgia"};
        Invitato giovanni = new Invitato("Giovanni", FasciaEta.Anziano, antipaticiGiovanni);

        String[] antipaticiGiorgia = {};
        Invitato giorgia = new Invitato("Giorgia", FasciaEta.Adulto, antipaticiGiorgia);

        int[] maxInvitatiTavoli = {3, 3};
        Sala sala = new Sala(maxInvitatiTavoli);

        try {
            sala.inserisciInvitato("TavoloUno", luca);
        } catch (MaxNumberTable | AntipaticiException | FasciaEtaException ex){
            System.out.println(ex.getMessage());
        }

        try {
            sala.inserisciInvitato("TavoloUno", giorgia);
        } catch (MaxNumberTable | AntipaticiException | FasciaEtaException ex){
            System.out.println(ex.getMessage());
        }

        try {
            sala.inserisciInvitato("TavoloUno", francesca);
        } catch (MaxNumberTable | AntipaticiException | FasciaEtaException ex){
            System.out.println(ex.getMessage());
        }

        sala.letturaTavolo("TavoloUno");

        try {
            sala.inserisciInvitato("TavoloDue", andrea);
        } catch (MaxNumberTable | AntipaticiException | FasciaEtaException ex){
            System.out.println(ex.getMessage());
        }

        try {
            sala.inserisciInvitato("TavoloDue", giovanni);
        } catch (MaxNumberTable | AntipaticiException | FasciaEtaException ex){
            System.out.println(ex.getMessage());
        }

        try {
            sala.inserisciInvitato("TavoloDue", maria);
        } catch (MaxNumberTable | AntipaticiException | FasciaEtaException ex){
            System.out.println(ex.getMessage());
        }

        sala.letturaTavolo("TavoloDue");
    }
}
