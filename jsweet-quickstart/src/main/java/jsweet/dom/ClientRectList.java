package jsweet.dom;
public class ClientRectList extends jsweet.lang.Object implements Iterable<ClientRect> {
    public double length;
    native public ClientRect item(double index);
    native public ClientRect $get(double index);
    public static ClientRectList prototype;
    public ClientRectList(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<ClientRect> iterator();
}

