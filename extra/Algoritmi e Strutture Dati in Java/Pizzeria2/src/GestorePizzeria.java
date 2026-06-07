public class GestorePizzeria extends Persona implements GestorePizzeriaInterface{
    private int stipendio, oreLavorative;
    private Pizzeria pizzeria;

    public GestorePizzeria(String nome, String cognome, String CF, int stipendio, int oreLavorative) {
        super(nome, cognome, CF);
        this.stipendio = stipendio;
        this.oreLavorative = oreLavorative;
        this.pizzeria = new Pizzeria();
    }
    public void setStipendio(int stipendio) {
        this.stipendio = stipendio;
    }

    public int getOreLavorative() {
        return oreLavorative;
    }
    public void setOreLavorative(int oreLavorative) {
        this.oreLavorative = oreLavorative;
    }


    @Override
    public void aggiungi_ordine(Ordine ordine) {
        pizzeria.inserimento(ordine);
    }

    @Override
    public void rimuovi_ordine(TipoOrdine tipoOrdine) {
        pizzeria.rimozione(tipoOrdine);
    }

    @Override
    public void leggi_ordine(TipoOrdine tipoOrdine) {
        pizzeria.lettura(tipoOrdine);
    }
}
