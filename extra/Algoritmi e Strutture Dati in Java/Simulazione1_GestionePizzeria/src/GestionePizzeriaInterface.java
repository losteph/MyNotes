public interface GestionePizzeriaInterface {
    void aggiungi_ordine(Ordine ordine);
    void rimuovi_ordine(TipoOrdine tipo_ordine);
    void leggi_ordine(TipoOrdine tipo_ordine);
}
