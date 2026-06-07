public class Invitato {
    private String nome;
    private FasciaEta fasciaEta;
    private String[] elencoAntipatici;

    public Invitato(String nome, FasciaEta fasciaEta, String[] elencoAntipatici){
        this.nome = nome;
        this.fasciaEta = fasciaEta;
        this.elencoAntipatici = elencoAntipatici;
    }

    public String getNome() {
        return nome;
    }

    public FasciaEta getFasciaEta() {
        return fasciaEta;
    }

    public String[] getElencoAntipatici() {
        return elencoAntipatici;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setFasciaEta(FasciaEta fasciaEta) {
        this.fasciaEta = fasciaEta;
    }

    public void setElencoAntipatici(String[] elencoAntipatici) {
        this.elencoAntipatici = elencoAntipatici;
    }
}
