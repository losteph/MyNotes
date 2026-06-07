import my_package.Enumerativi.*;

public class Main {
    public static void main(String[] args){
        Automobile aDefault = new Automobile();
        System.out.println(aDefault);

        aDefault.setProprietario("Luca Bianchi");
        aDefault.setTarga("BBBB000");
        aDefault.setCasaAutomobilistica("Mercedes");
        aDefault.setTipoCarburante(CARBURANTE.BENZINA);
        aDefault.setCambio(CAMBIO.MANUALE);
        aDefault.setPosti(5);
        aDefault.setImmatricolazione("settembre_2021");
        System.out.println(aDefault);

        Automobile aCustom = new Automobile("Mario Rossi", "AAAA000", "Fiat", CARBURANTE.DIESEL, CAMBIO.AUTOMATICO, 5, "aprile_2022");
        System.out.println(aCustom);

        if(aDefault.equals(aCustom)){
            System.out.println("le due auto hanno la stessa casa automobilistica e usano lo stesso carburante");
        } else {
            System.out.println("le due auto non hanno la stessa casa automobilistica e non usano lo stesso carburante");
        }
    }
}
