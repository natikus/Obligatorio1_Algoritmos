import java.util.LinkedList;
import java.util.List;

public class Listas {

    public LinkedList<List<Integer>> ListaNegra;
    public LinkedList<Integer> ListaBlanca;

    public boolean EnListaNegra (Integer suero, Integer farmaco){
        for (List<Integer> i : ListaNegra) {
            if (i.get(1).equals(farmaco)){
                if (i.get(0).equals(suero)) {
                    return true; //si estan los dos juntos, retorna true
                }
            }
        }
        return false;// en caso de que no lo esten, retorna false
    }

    public boolean EnListaNegraFarmaco ( Integer farmaco){
        for (List<Integer> i : ListaNegra) {
            if (i.get(1).equals(farmaco)){

                return true; //si estan los dos juntos, retorna true
            }
        }
        return false;// en caso de que no lo esten, retorna false
    }

    public boolean EnListaBlanca (Integer farmaco){
        for (Integer i: ListaBlanca){
            if (i.equals(farmaco)){
                return true;
            }
        }
        return false;
    }

    public boolean EsViable (Integer suero, LinkedList<Integer> listaDeFarmacos){
        for (Integer i: ListaBlanca){//i toma el valor de los farmacos
            if (!EnListaBlanca(i)){// si el farmaco no esta en la lista blanca
                if (EnListaNegra(suero,i)) {//y a la vez no esta la combinacion en la lista negra
                    return false;// devuelve false
                }
                else if (!EnListaNegraFarmaco(i)) {// en caso de que el farmaco no este por si solo en
                    //ninguna de las listas, tambien retorna false
                    return false;

                }
            }
        }
        return true;
    }
}
