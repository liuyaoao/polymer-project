package jsweet.dom;
/** <p>The <code>SVGAnimatedAngle</code> interface is used for attributes of basic type &lt;angle&gt; which can be animated.</p>  */
public class SVGAnimatedAngle extends jsweet.lang.Object {
    /** 
A read only <code>SVGAngle</code> representing the current animated value of the given attribute. If the given attribute is not currently being animated, then the <code>SVGAngle</code> will have the same contents as <code>baseVal</code>. The object referenced by <code>animVal</code> will always be distinct from the one referenced by <code>baseVal</code>, even when the attribute is not animated. */
    public SVGAngle animVal;
    /** 
The base value of the given attribute before applying any animations. */
    public SVGAngle baseVal;
    public static SVGAnimatedAngle prototype;
    public SVGAnimatedAngle(){}
}

