package jsweet.dom;
/** <p>The <code>SVGAnimatedPoints</code> interface supports elements which have a <code>points</code> attribute which holds a list of coordinate values and which support the ability to animate that attribute.</p> <p>Additionally, the <code>points</code> attribute on the original element accessed via the XML DOM (e.g., using the <code>getAttribute()</code> method call) will reflect any changes made to the <code>SVGAnimatedPoints.points</code> attribut.</p>  */
@jsweet.lang.Interface
public abstract class SVGAnimatedPoints extends jsweet.lang.Object {
    /** 
Provides access to the current animated contents of the <code>points</code> attribute. If the given attribute or property is being animated, contains the current animated value of the attribute or property. If the given attribute or property is not currently being animated, contains the same value as <code>points</code>. */
    public SVGPointList animatedPoints;
    /** 
Provides access to the base (i.e., static) contents of the <code>points</code> attribute. */
    public SVGPointList points;
}

