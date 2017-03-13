package jsweet.dom;
/**  <p>The <code>StyleSheetList</code> interface represents a list of <code>StyleSheet</code>.</p> <p>It is an array-like object but can't be iterated over using <code>Array</code> methods. However It can be iterated over in a standard <code>for</code> loop over its indices, or converted to an <code>Array</code>.</p>  */
public class StyleSheetList extends jsweet.lang.Object implements Iterable<StyleSheet> {
    public double length;
    native public StyleSheet item(double index);
    native public StyleSheet $get(double index);
    public static StyleSheetList prototype;
    public StyleSheetList(){}
    native public StyleSheet item();
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<StyleSheet> iterator();
}

