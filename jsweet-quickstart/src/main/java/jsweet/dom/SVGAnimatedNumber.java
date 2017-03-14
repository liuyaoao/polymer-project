package jsweet.dom;
/** <p>The <code>SVGAnimatedNumber</code> interface is used for attributes of basic type &lt;Number&gt; which can be animated.</p>  */
public class SVGAnimatedNumber extends jsweet.lang.Object {
    /** 
If the given attribute or property is being animated, contains the current animated value of the attribute or property. If the given attribute or property is not currently being animated, contains the same value as <code>baseVal</code>. */
    public double animVal;
    /** 
The base value of the given attribute before applying any animations. */
    public double baseVal;
    public static SVGAnimatedNumber prototype;
    public SVGAnimatedNumber(){}
}
