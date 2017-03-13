package jsweet.dom;
/** <p>The <code>SVGAnimatedLength</code> interface is used for attributes of basic type &lt;length&gt; which can be animated.</p>  */
public class SVGAnimatedLength extends jsweet.lang.Object {
    /** 
If the given attribute or property is being animated, contains the current animated value of the attribute or property. If the given attribute or property is not currently being animated, contains the same value as <code>baseVal</code>. */
    public SVGLength animVal;
    /** 
The base value of the given attribute before applying any animations. */
    public SVGLength baseVal;
    public static SVGAnimatedLength prototype;
    public SVGAnimatedLength(){}
}

