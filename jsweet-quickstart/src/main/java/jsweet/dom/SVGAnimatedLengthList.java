package jsweet.dom;
/** <p>The <code>SVGAnimatedLengthList</code> interface is used for attributes of type <code>SVGLengthList</code> which can be animated.</p>  */
public class SVGAnimatedLengthList extends jsweet.lang.Object {
    /** 
A read only <code>SVGLengthList</code> representing the current animated value of the given attribute. If the given attribute is not currently being animated, then the <code>SVGLengthList</code> will have the same contents as <code>baseVal</code>. The object referenced by <code>animVal</code> will always be distinct from the one referenced by <code>baseVal</code>, even when the attribute is not animated. */
    public SVGLengthList animVal;
    /** 
The base value of the given attribute before applying any animations. */
    public SVGLengthList baseVal;
    public static SVGAnimatedLengthList prototype;
    public SVGAnimatedLengthList(){}
}

