package jsweet.dom;
/** <div> <p><strong><span><i> </i></span> Obsolete</strong><br></br>This feature is obsolete. Although it may still work in some browsers, its use is discouraged since it could be removed at any time. Try to avoid using it.</p> </div> <p>A type returned by some APIs which contains a list of DOMString (strings).</p>  */
public class DOMStringList extends jsweet.lang.Object implements Iterable<java.lang.String> {
    /** 
 Returns the length of the list,  */
    public double length;
    /** 
 Returns <code>Boolean</code> indicating if the given string is in the list  */
    native public Boolean contains(String str);
    /** 
 Returns a <code>DOMString</code>.  */
    native public String item(double index);
    native public java.lang.String $get(double index);
    public static DOMStringList prototype;
    public DOMStringList(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<java.lang.String> iterator();
}

