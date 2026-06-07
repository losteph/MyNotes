public class Pass {
    private int cod_pass;
    public int turno_esibizione;
    private String orario;

    //costruttore
    Pass(int cod_pass, int turno_esibizione, String orario){
        this.cod_pass = cod_pass;
        this.turno_esibizione = turno_esibizione;
        this.orario = orario;
    }

    //getter
    public String getOrario() {return orario;}
    public int getTurno_esibizione() {return turno_esibizione;}
    public int getCod_pass() {return cod_pass;}

    //Setter
    public void setCod_pass(int cod_pass) {this.cod_pass = cod_pass;}
    public void setTurno_esibizione(int turno_esibizione) {this.turno_esibizione = turno_esibizione;}
    public void setOrario(String orario) {this.orario = orario;}
}
