import java.util.ArrayList;

public class Tavolo {
    private String numeroTavolo;
    private int maxInvitatiTavolo;
    private ArrayList<Invitato> elencoInvitatiTavolo;

    public Tavolo(String numeroTavolo, int maxInvitatiTavolo){
        this.numeroTavolo = numeroTavolo;
        this.maxInvitatiTavolo = maxInvitatiTavolo;
        this.elencoInvitatiTavolo = new ArrayList<>(maxInvitatiTavolo);
    }

    public String getNumeroTavolo(){return this.numeroTavolo;}
    public int getMaxInvitatiTavolo(){return this.maxInvitatiTavolo;}
    public ArrayList<Invitato> getElencoInvitatiTavolo(){return this.elencoInvitatiTavolo;}

    public void setNumeroTavolo(String numeroTavolo){this.numeroTavolo = numeroTavolo;}
    public void setMaxInvitatiTavolo(int maxInvitatiTavolo){this.maxInvitatiTavolo = maxInvitatiTavolo;}
    public void setElencoInvitatiTavolo(ArrayList<Invitato> elencoInvitatiTavolo){this.elencoInvitatiTavolo = elencoInvitatiTavolo;}
}
