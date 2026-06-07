public class Profilo{
    private Persona persona;
    private String e_mail;
    private Locazione locazione;
    private Device device;

    public Profilo(Persona persona, String e_mail, Locazione locazione, Device device) {
        this.persona = persona;
        this.e_mail = e_mail;
        this.locazione = locazione;
        this.device = device;
    }

    public String getE_mail() {
        return e_mail;
    }
    public void setE_mail(String e_mail) {
        this.e_mail = e_mail;
    }
    public Locazione getLocazione() {
        return locazione;
    }
    public void setLocazione(Locazione locazione) {
        this.locazione = locazione;
    }
    public Device getDevice() {
        return device;
    }
    public void setDevice(Device device) {
        this.device = device;
    }

    @Override
    public String toString() {
        return "e_mail: " + this.e_mail +
                "\nlocazione: " + this.locazione +
                "\ndevice ip: " + this.device.getIp_address() + " device mac: " + this.device.getMac_address();
    }
}
