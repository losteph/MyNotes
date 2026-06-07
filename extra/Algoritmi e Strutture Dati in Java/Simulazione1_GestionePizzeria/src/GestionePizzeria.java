public class GestionePizzeria extends Persona implements GestionePizzeriaInterface{
    private Pizzeria pizzeria;
    private float stipendio;
    private int ore_lavorative;

    public GestionePizzeria(String nome, String cognome, String CF, float stipendio, int ore_lavorative){
        super(nome, cognome, CF);
        this.stipendio = stipendio;
        this.ore_lavorative = ore_lavorative;
        this.pizzeria = new Pizzeria();
    }

    public Pizzeria getPizzeria() {return pizzeria;}
    public void setPizzeria(Pizzeria pizzeria) {this.pizzeria = pizzeria; }

    @Override
    public void aggiungi_ordine(Ordine ordine) {
        this.pizzeria.aggiungi_ordine(ordine);
    }

    @Override
    public void rimuovi_ordine(TipoOrdine tipo_ordine) {
        this.pizzeria.rimuovi_ordine(tipo_ordine);
    }

    @Override
    public void leggi_ordine(TipoOrdine tipo_ordine) {
        this.pizzeria.leggi_ordine(tipo_ordine);
    }
}
