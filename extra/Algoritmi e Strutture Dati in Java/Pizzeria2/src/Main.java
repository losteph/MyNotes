public class Main {
    public static void main(String[] args) {
        Pizzeria pizzeria = new Pizzeria();
        GestorePizzeria gestorePizzeria = new GestorePizzeria("Federica","Bianca","aa77nn",2000,12);

        Ordine ordine1 = new Ordine("0000",6.99,"Capricciosa",TipoOrdine.Asporto);
        Ordine ordine2 = new Ordine("0001",7.99,"Vegetariana",TipoOrdine.Asporto);
        Ordine ordine3 = new Ordine("0002",7.99,"Vegetariana",TipoOrdine.Domicilio);
        Ordine ordine4 = new Ordine("0003",5.99,"Margherita",TipoOrdine.Asporto);

        gestorePizzeria.aggiungi_ordine(ordine1);
        gestorePizzeria.aggiungi_ordine(ordine2);
        gestorePizzeria.aggiungi_ordine(ordine3);
        gestorePizzeria.aggiungi_ordine(ordine4);

        gestorePizzeria.leggi_ordine(TipoOrdine.Asporto);
        gestorePizzeria.leggi_ordine(TipoOrdine.Domicilio);

        gestorePizzeria.rimuovi_ordine(TipoOrdine.Asporto);
        gestorePizzeria.rimuovi_ordine(TipoOrdine.Domicilio);
    }
}
