package jsweet.dom;
/**    */
public class TouchList extends jsweet.lang.Object implements Iterable<Touch> {
    /** 
 The number of <code>Touch</code> objects in the <code>TouchList</code>.  */
    public double length;
    /** 
 Returns the <code>Touch</code> object at the specified index in the list.  */
    native public Touch item(double index);
    native public Touch $get(double index);
    public static TouchList prototype;
    public TouchList(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<Touch> iterator();
}

