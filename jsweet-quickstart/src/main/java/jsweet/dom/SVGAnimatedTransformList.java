package jsweet.dom;
/** <p>The <code>SVGAnimatedTransformList</code> interface is used for attributes which take a list of numbers and which can be animated.</p>  */
public class SVGAnimatedTransformList extends jsweet.lang.Object {
    /** 
A read only <code>SVGTransformList</code> representing the current animated value of the given attribute. If the given attribute is not currently being animated, then the <code>SVGTransformList</code> will have the same contents as <code>baseVal</code>. The object referenced by <code>animVal</code> will always be distinct from the one referenced by <code>baseVal</code>, even when the attribute is not animated. */
    public SVGTransformList animVal;
    /** 
The base value of the given attribute before applying any animations. */
    public SVGTransformList baseVal;
    public static SVGAnimatedTransformList prototype;
    public SVGAnimatedTransformList(){}
}

