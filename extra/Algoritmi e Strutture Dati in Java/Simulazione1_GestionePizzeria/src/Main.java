public class Main {
    public static void main(String [] args){
        // creo gestore pizzeria

        GestionePizzeria federica = new GestionePizzeria("Federica", "Bianca", "aa77nn", 2000, 12);

        // creo 4 ordini
        Ordine ordine1 = new Ordine("0000", 6.99f, TipoPizza.Capricciosa, TipoOrdine.Asporto);
        Ordine ordine2 = new Ordine("0001", 7.99f, TipoPizza.Vegetariana, TipoOrdine.Asporto);
        Ordine ordine3 = new Ordine("0002", 7.99f, TipoPizza.Vegetariana, TipoOrdine.Domicilio);
        Ordine ordine4 = new Ordine("0003", 5.99f, TipoPizza.Margherita, TipoOrdine.Asporto);

        // gestore pizzeria aggiunge gli ordini
        federica.aggiungi_ordine(ordine1);
        federica.aggiungi_ordine(ordine2);
        federica.aggiungi_ordine(ordine3);
        federica.aggiungi_ordine(ordine4);

        // gestore legge prossimo ordine per Asporto e per Domicilio
        federica.leggi_ordine(TipoOrdine.Asporto);
        federica.leggi_ordine(TipoOrdine.Domicilio);

        // gestore completa (rimuove) il prossimo ordine per Asporto e per Domicilio
        federica.rimuovi_ordine(TipoOrdine.Asporto);
        federica.rimuovi_ordine(TipoOrdine.Domicilio);

    }
}
