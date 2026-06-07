public class Main {
    public static void main(String[] args) {
        Alta_Velocita treno1 = new Alta_Velocita(1,"boh", 2);
        Regionale treno2 = new Regionale(2, "pop", "Puglia");

        Editor editor = new Editor(treno1, treno2);

        Vagone vagone1 = new Vagone(5,"s",TipoVagone.suite);
        Vagone vagone2 = new Vagone(7,"a",TipoVagone.prima_classe);
        Vagone vagone3 = new Vagone(10,"b",TipoVagone.seconda_classe);
        Vagone vagone4 = new Vagone(13,"c",TipoVagone.terza_classe);

        try {
            editor.rimozione_A();
        } catch (TrainEmptyException e) {
            System.out.println(e.getMessage());;
        }
        try {
            editor.rimozione_R();
        } catch (TrainEmptyException e) {
            System.out.println(e.getMessage());;
        }

        try {
            editor.inserimento_A(vagone1);
        } catch (TrainFullException e) {
            System.out.println(e.getMessage());;
        }
        try {
            editor.inserimento_A(vagone2);
        } catch (TrainFullException e) {
            System.out.println(e.getMessage());;
        }
        try {
            editor.inserimento_A(vagone3);
        } catch (TrainFullException e) {
            System.out.println(e.getMessage());;
        }

        try {
            editor.rimozione_A();
        } catch (TrainEmptyException e) {
            System.out.println(e.getMessage());;
        }

        editor.inserimento_R(vagone4);
        editor.inserimento_R(vagone3);

        editor.lettura_A();
        editor.lettura_R();

    }
}
