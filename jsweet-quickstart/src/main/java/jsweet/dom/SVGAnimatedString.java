package jsweet.dom;
/** <p>The <code>SVGAnimatedString</code> interface is used for attributes of type <code>DOMString</code> which can be animated.</p>  */
public class SVGAnimatedString extends jsweet.lang.Object {
    /** 
If the given attribute or property is being animated, contains the current animated value of the attribute or property. If the given attribute or property is not currently being animated, contains the same value as <code>baseVal</code>. */
    public String animVal;
    /** 
The base value of the given attribute before applying any animations. */
    public String baseVal;
    public static SVGAnimatedString prototype;
    public SVGAnimatedString(){}
}

