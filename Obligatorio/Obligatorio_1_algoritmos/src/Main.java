import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class Main {

    public static void main(String[] args){
        Listas Viable = new Listas();
        LinkedList<Farmaco> farmacos = new LinkedList<Farmaco>();
        LinkedList<Integer> farmacosNumeros = new LinkedList<Integer>();
        LinkedList<Suero> sueros = new LinkedList<Suero>();
        LinkedList<Integer> listaBlanca = new LinkedList<Integer>();
        LinkedList<List<Integer>> listaNegra = new LinkedList<List<Integer>>();

        String[] ListaBlanca = ManejadorDeArchivos.leerArchivo(
            "C:\\Users\\natik\\Desktop\\3er semestre\\algoritmos\\Obligatorio\\listablanca.txt");
        String[] ListaNegra = ManejadorDeArchivos.leerArchivo(
            "C:\\Users\\natik\\Desktop\\3er semestre\\algoritmos\\Obligatorio\\listanegra.txt");
        String[] Sueros = ManejadorDeArchivos.leerArchivo(
            "C:\\Users\\natik\\Desktop\\3er semestre\\algoritmos\\Obligatorio\\Sueros.txt");
        String[] Farmacos = ManejadorDeArchivos.leerArchivo(
            "C:\\Users\\natik\\Desktop\\3er semestre\\algoritmos\\Obligatorio\\farmacos.txt");

        for(int i = 0; i< Sueros.length;i++)// separa los datos de los sueros y los crea como objeto
        {
            String[] parts = Sueros[i].split(",");
            Suero suero = new Suero(parts[0].trim(), Integer.getInteger(parts[1].trim()));
            sueros.add(suero);

        }
        for(int i = 0; i< Farmacos.length;i++)// separa los datos de los farmacos y los crea como objeto
        {
            String[] parts = Farmacos[i].split(",");
            Farmaco farmaco = new Farmaco(parts[1].trim(), Integer.getInteger(parts[0].trim()));
            farmacos.add(farmaco);
            farmacosNumeros.add(Integer.getInteger(parts[0].trim()));//los guarda como numeros

        }
        for(int i = 0; i< ListaBlanca.length;i++)// crea la lista blanca con los ints
        {
            String Codigo = ListaBlanca[i];
            listaBlanca.add(Integer.getInteger(Codigo));
        }
        for(int i = 0; i< ListaNegra.length;i++)// crea la lista negralos ints
        {
            String[] parts =ListaNegra[i].split(",");
            LinkedList<Integer> MiniLista = new LinkedList<Integer>();
            MiniLista.add(Integer.getInteger(parts[0]));
            MiniLista.add(Integer.getInteger(parts[1]));
            listaNegra.add(MiniLista);

        }


        Integer CodigoSuero= 5;
        for(Suero i: sueros ){//imprime el suero pedido
            if((i.Codigo).equals(CodigoSuero)){
                System.out.print((i.Codigo).toString()+ i.Nombre);
            }
        }

        for(Farmaco i: farmacos ){ //imprime todos los farmacos
            System.out.print((i.Codigo).toString()+ i.Nombre);
        }

        if (Viable.EsViable(CodigoSuero, farmacosNumeros)){// imprime si es viable o no
            System.out.print("Es viable");
        }
        else{
            System.out.print("No es viable");
        }
    }
}