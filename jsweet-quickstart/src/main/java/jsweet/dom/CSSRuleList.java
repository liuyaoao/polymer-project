package jsweet.dom;
/**  <p>A <code>CSSRuleList</code> is an array-like object containing an ordered collection of <code>CSSRule</code> objects.</p>  */
public class CSSRuleList extends jsweet.lang.Object implements Iterable<CSSRule> {
    public double length;
    native public CSSRule item(double index);
    native public CSSRule $get(double index);
    public static CSSRuleList prototype;
    public CSSRuleList(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<CSSRule> iterator();
}

