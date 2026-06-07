import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

public class CentroVaccinale {
    private HashMap<FasciaEta, Queue<Paziente>> prenotazioni;

    public CentroVaccinale(){
        prenotazioni = new HashMap<>();
        for (FasciaEta fasciaEta : FasciaEta.values()) {
            prenotazioni.put(fasciaEta, new LinkedList<>());
        }
    }

    public void inserirePrenotazione(Paziente p) throws PazientePrenotatoException{
        FasciaEta fasciaEta = null;
        if(p.getEta() <=18) fasciaEta = fasciaEta.Giovane;
        if(p.getEta() > 18 && p.getEta() <=60) fasciaEta = fasciaEta.Adulto;
        if(p.getEta() >60) fasciaEta = fasciaEta.Anziano;
        for (Paziente paziente : prenotazioni.get(fasciaEta)) {
            if(paziente.equals(p)) throw new PazientePrenotatoException("[Attenzione] Il paziente " + p.getNome() + " " + p.getCognome() + " è già prenotato");
        }
        System.out.println(p.getNome() + " " + p.getCognome() + " si è prenotato");
        prenotazioni.get(fasciaEta).add(p);
    }

    public void eseguiVaccinazione(FasciaEta fasciaEta) throws AnzianiException{
        if(fasciaEta != fasciaEta.Anziano && prenotazioni.get(fasciaEta.Anziano).size() != 0) throw new AnzianiException();
        else {
            System.out.println("Stiamo vaccinando per la fascia di eta': " + fasciaEta + "\nil paziente: ");
            System.out.println(prenotazioni.get(fasciaEta).poll());
        }
    }

    public void stampaPrenotazioni(FasciaEta fasciaEta){
        System.out.println("elenco prenotazioni per la fascia di eta': " + fasciaEta + "\ne' il seguente");
        for (Paziente paziente : prenotazioni.get(fasciaEta)){
            System.out.println(paziente);
        }
    }
}
