import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class FarmacoTest {
    // test de si el codigo corresponde
    @Test
    void Codigo(){
        Farmaco farmaco = new Farmaco("Novemina", 1);
        assertEquals(farmaco.Codigo, 1);
    }
    // test de si el nombre corresponde
    @Test
    void Nombre(){
        Farmaco farmaco = new Farmaco("Novemina", 1);
        assertEquals(farmaco.Nombre, "Novemina");
    }

}