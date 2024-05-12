import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class SueroTest {

    // test de si el codigo corresponde
    @Test
    void Codigo(){
        Suero suero = new Suero("Acuoso", 1);
        assertEquals(suero.Codigo, 1);
    }
    // test de si el nombre corresponde
    @Test
    void Nombre(){
        Suero suero = new Suero("Acuoso", 1);
        assertEquals(suero.Nombre, "Acuoso");
    }

}