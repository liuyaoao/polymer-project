package jsweet.dom;
/** <p>The <code>SVGAnimatedBoolean</code> interface is used for attributes of type boolean which can be animated.</p>  */
public class SVGAnimatedBoolean extends jsweet.lang.Object {
    /** 
If the given attribute or property is being animated, contains the current animated value of the attribute or property. If the given attribute or property is not currently being animated, contains the same value as <code>baseVal</code>. */
    public Boolean animVal;
    /** 
The base value of the given attribute before applying any animations. */
    public Boolean baseVal;
    public static SVGAnimatedBoolean prototype;
    public SVGAnimatedBoolean(){}
}

