package jsweet.dom;
/** <p>The <code>SVGAnimatedRect</code> interface is used for attributes of basic <code>SVGRect</code> which can be animated.</p>  */
public class SVGAnimatedRect extends jsweet.lang.Object {
    /** 
A read only <code>SVGRect</code> representing the current animated value of the given attribute. If the given attribute is not currently being animated, then the <code>SVGRect</code> will have the same contents as <code>baseVal</code>. The object referenced by <code>animVal</code> will always be distinct from the one referenced by <code>baseVal</code>, even when the attribute is not animated. */
    public SVGRect animVal;
    /** 
The base value of the given attribute before applying any animations. */
    public SVGRect baseVal;
    public static SVGAnimatedRect prototype;
    public SVGAnimatedRect(){}
}

