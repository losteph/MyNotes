public interface GestorePizzeriaInterface {
    void aggiungi_ordine(Ordine ordine);
    void rimuovi_ordine(TipoOrdine tipoOrdine);
    void leggi_ordine(TipoOrdine tipoOrdine);
}
