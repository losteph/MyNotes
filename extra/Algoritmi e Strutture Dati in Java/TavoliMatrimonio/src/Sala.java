import java.util.HashMap;

public class Sala {
    HashMap<String, Tavolo> tavoliSala;

    public Sala(int[] maxInvitatiTavolo){
        this.tavoliSala = new HashMap<>();
        this.tavoliSala.put("TavoloUno", new Tavolo("TavoloUno", maxInvitatiTavolo[0]));
        this.tavoliSala.put("TavoloDue", new Tavolo("TavoloDue", maxInvitatiTavolo[1]));
    }

    public HashMap<String, Tavolo> getTavoliSala() {
        return this.tavoliSala;
    }

    public void setTavoliSala(HashMap<String, Tavolo> tavoliSala) {
        this.tavoliSala = tavoliSala;
    }

    public void inserisciInvitato(String numeroTavolo, Invitato invitato) throws MaxNumberTable, AntipaticiException, FasciaEtaException{
        if (this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().isEmpty()){
            this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().add(invitato);
        }
        else {
            if (this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().size()  >= this.tavoliSala.get(numeroTavolo).getMaxInvitatiTavolo()) {
                throw new MaxNumberTable(this.tavoliSala.get(numeroTavolo).getMaxInvitatiTavolo());
            }

            for (int i = 0; i < this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().size(); i++) {
                for (int j = 0; j < invitato.getElencoAntipatici().length; j++) {
                    if (this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().get(i).getNome().equals(invitato.getElencoAntipatici()[j])) {
                        throw new AntipaticiException(invitato.getNome(), invitato.getElencoAntipatici()[j]);
                    }
                }
            }

            boolean almenoUnGiovane = false;

            if (invitato.getFasciaEta() == FasciaEta.Giovane) {
                for (int i = 0; i < this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().size(); i++) {
                    if (this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().get(i).getFasciaEta() == FasciaEta.Giovane) {
                        almenoUnGiovane = true;
                        break;
                    }
                }
                if (!almenoUnGiovane){
                    throw new FasciaEtaException();
                }
            }

            this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().add(invitato);
        }

    }

    public void letturaTavolo(String numeroTavolo){
        System.out.println("TAVOLO " + numeroTavolo);
        for (int i = 0; i < this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().size(); i++){
            System.out.println(this.tavoliSala.get(numeroTavolo).getElencoInvitatiTavolo().get(i).getNome());
        }
    }
}
