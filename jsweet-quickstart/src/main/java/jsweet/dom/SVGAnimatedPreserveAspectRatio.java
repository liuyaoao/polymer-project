package jsweet.dom;
/** <p>The <code>SVGAnimatedPreserveAspectRatio</code> interface is used for attributes of type <code>SVGPreserveAspectRatio</code> which can be animated.</p>  */
public class SVGAnimatedPreserveAspectRatio extends jsweet.lang.Object {
    /** 
A read only <code>SVGPreserveAspectRatio</code> representing the current animated value of the given attribute. If the given attribute is not currently being animated, then the <code>SVGPreserveAspectRatio</code> will have the same contents as <code>baseVal</code>. The object referenced by <code>animVal</code> is always distinct from the one referenced by <code>baseVal</code>, even when the attribute is not animated. */
    public SVGPreserveAspectRatio animVal;
    /** 
The base value of the given attribute before applying any animations. */
    public SVGPreserveAspectRatio baseVal;
    public static SVGAnimatedPreserveAspectRatio prototype;
    public SVGAnimatedPreserveAspectRatio(){}
}

