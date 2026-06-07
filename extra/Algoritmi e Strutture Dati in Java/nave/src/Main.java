public class Main {
    public static void main(String[] args) {
        Merce merce = new Merce("001" ,"auto", 300,500);

        merceNazionale merceNazionale = new merceNazionale(merce);
        merce.getEtichetta();
        System.out.println("");
        merceNazionale.getEtichetta();
    }
}
