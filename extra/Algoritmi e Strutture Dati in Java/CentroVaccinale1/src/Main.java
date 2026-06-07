public class Main {
    public static void main(String[] args) throws AnzianiException {

        Paziente marco = new Paziente("Marco", "Rossi", 25);
        Paziente francesca = new Paziente("Francesca", "Bianca", 79);
        Paziente daniele = new Paziente("Daniele", "Verdi", 16);
        Paziente riccardo = new Paziente("Riccardo", "Rossi", 84);
        Paziente giorgia = new Paziente("Giorgia", "Bruni", 50);

        CentroVaccinale centroVaccinale = new CentroVaccinale();

        try{
            centroVaccinale.inserirePrenotazione(riccardo);
        }catch (PazientePrenotatoException e){
            System.out.println(e.getMessage());
        }
        try{
            centroVaccinale.inserirePrenotazione(giorgia);
        }catch (PazientePrenotatoException e){
            System.out.println(e.getMessage());
        }
        try{
            centroVaccinale.inserirePrenotazione(marco);
        }catch (PazientePrenotatoException e){
            System.out.println(e.getMessage());
        }
        try{
            centroVaccinale.inserirePrenotazione(daniele);
        }catch (PazientePrenotatoException e){
            System.out.println(e.getMessage());
        }
        try{
            centroVaccinale.inserirePrenotazione(francesca);
        }catch (PazientePrenotatoException e){
            System.out.println(e.getMessage());
        }


        centroVaccinale.eseguiVaccinazione(FasciaEta.Anziano);

        try {
            centroVaccinale.eseguiVaccinazione(FasciaEta.Adulto);
        } catch (AnzianiException e) {
            System.out.println(e.getMessage());
        }
        try {
            centroVaccinale.eseguiVaccinazione(FasciaEta.Giovane);
        } catch (AnzianiException e) {
            System.out.println(e.getMessage());
        }

        centroVaccinale.stampaPrenotazioni(FasciaEta.Anziano);


        centroVaccinale.eseguiVaccinazione(FasciaEta.Anziano);

        try {
            centroVaccinale.eseguiVaccinazione(FasciaEta.Adulto);
        } catch (AnzianiException e) {
            System.out.println(e.getMessage());
        }
        try {
            centroVaccinale.eseguiVaccinazione(FasciaEta.Giovane);
        } catch (AnzianiException e) {
            System.out.println(e.getMessage());
        }


    }
}
