package jsweet.dom;
/** <p>The <code>SVGPathElement</code> interface corresponds to the <code>&lt;path&gt;</code> element.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTransformable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class,SVGAnimatedPathData.class})
public class SVGPathElement extends SVGElement {
    /** 
Returns a stand-alone, parentless <code>SVGPathSegArcAbs</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em> </code><br></br> The absolute Y coordinate for the end point of this path segment.</li> <li><code>float <em>r1</em></code><br></br> The x-axis radius for the ellipse.</li> <li><code>float <em>r2 </em></code><br></br> The y-axis radius for the ellipse.</li> <li><code>float <em>angle </em></code><br></br> The rotation angle in degrees for the ellipse's x-axis relative to the x-axis of the user coordinate system.</li> <li><code>boolean <em>largeArcFlag </em></code><br></br> The value of the large-arc-flag parameter.</li> <li><code>boolean <em>sweepFlag </em></code><br></br> The value of the large-arc-flag parameter.</li> </ul>  */
    native public SVGPathSegArcAbs createSVGPathSegArcAbs(double x, double y, double r1, double r2, double angle, Boolean largeArcFlag, Boolean sweepFlag);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegArcRel</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The relative X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em> </code><br></br> The relative Y coordinate for the end point of this path segment.</li> <li><code>float <em>r1</em></code><br></br> The x-axis radius for the ellipse.</li> <li><code>float <em>r2 </em></code><br></br> The y-axis radius for the ellipse.</li> <li><code>float <em>angle </em></code><br></br> The rotation angle in degrees for the ellipse's x-axis relative to the x-axis of the user coordinate system.</li> <li><code>boolean <em>largeArcFlag </em></code><br></br> The value of the large-arc-flag parameter.</li> <li><code>boolean <em>sweepFlag </em></code><br></br> The value of the large-arc-flag parameter.</li> </ul>  */
    native public SVGPathSegArcRel createSVGPathSegArcRel(double x, double y, double r1, double r2, double angle, Boolean largeArcFlag, Boolean sweepFlag);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegClosePath</code> object. */
    native public SVGPathSegClosePath createSVGPathSegClosePath();
    /** 
Returns a stand-alone, parentless <code>SVGPathSegCurvetoCubicAbs</code> object.<br></br> <br></br> Parameters: <ul> <li><code>float <em>x</em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em> </code><br></br> The absolute Y coordinate for the end point of this path segment.</li> <li><code>float <em>x1</em></code><br></br> The absolute X coordinate for the first control point.</li> <li><code>float <em>y1</em></code><br></br> The absolute Y coordinate for the first control point.</li> <li><code>float <em>x2</em></code><br></br> The absolute X coordinate for the second control point.</li> <li><code>float <em>y2</em></code><br></br> The absolute Y coordinate for the second control point.</li> </ul>  */
    native public SVGPathSegCurvetoCubicAbs createSVGPathSegCurvetoCubicAbs(double x, double y, double x1, double y1, double x2, double y2);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegCurvetoCubicRel</code> object.<br></br> <br></br> Parameters: <ul> <li><code>float <em>x</em></code><br></br> The relative X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em> </code><br></br> The relative Y coordinate for the end point of this path segment.</li> <li><code>float <em>x1</em></code><br></br> The relative X coordinate for the first control point.</li> <li><code>float <em>y1</em></code><br></br> The relative Y coordinate for the first control point.</li> <li><code>float <em>x2</em></code><br></br> The relative X coordinate for the second control point.</li> <li><code>float <em>y2</em></code><br></br> The relative Y coordinate for the second control point.</li> </ul>  */
    native public SVGPathSegCurvetoCubicRel createSVGPathSegCurvetoCubicRel(double x, double y, double x1, double y1, double x2, double y2);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegCurvetoCubicSmoothAbs</code> object.<br></br> <br></br> Parameters <ul> <li><code>float <em>x </em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> <li><code>float <em>y </em></code><br></br> The absolute Y coordinate for the end point of this path segment.</li> <li><code>float <em>x2 </em></code><br></br> The absolute X coordinate for the second control point.</li> <li><code>float <em>y2 </em></code><br></br> The absolute Y coordinate for the second control point.</li> </ul>  */
    native public SVGPathSegCurvetoCubicSmoothAbs createSVGPathSegCurvetoCubicSmoothAbs(double x, double y, double x2, double y2);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegCurvetoCubicSmoothRel</code> object.<br></br> <br></br> Parameters <ul> <li><code>float <em>x </em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> <li><code>float <em>y </em></code><br></br> The absolute Y coordinate for the end point of this path segment.</li> <li><code>float <em>x2 </em></code><br></br> The absolute X coordinate for the second control point.</li> <li><code>float <em>y2 </em></code><br></br> The absolute Y coordinate for the second control point.</li> </ul>  */
    native public SVGPathSegCurvetoCubicSmoothRel createSVGPathSegCurvetoCubicSmoothRel(double x, double y, double x2, double y2);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegCurvetoQuadraticAbs</code> object.<br></br> <br></br> Parameters: <ul> <li><code>float <em>x</em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em> </code><br></br> The absolute Y coordinate for the end point of this path segment.</li> <li><code>float <em>x1</em></code><br></br> The absolute X coordinate for the first control point.</li> <li><code>float <em>y1</em></code><br></br> The absolute Y coordinate for the first control point.</li> </ul>  */
    native public SVGPathSegCurvetoQuadraticAbs createSVGPathSegCurvetoQuadraticAbs(double x, double y, double x1, double y1);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegCurvetoQuadraticRel</code> object.<br></br> <br></br> Parameters: <ul> <li><code>float <em>x</em></code><br></br> The relative X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em> </code><br></br> The relative Y coordinate for the end point of this path segment.</li> <li><code>float <em>x1</em></code><br></br> The relative X coordinate for the first control point.</li> <li><code>float <em>y1</em></code><br></br> The relative Y coordinate for the first control point.</li> </ul>  */
    native public SVGPathSegCurvetoQuadraticRel createSVGPathSegCurvetoQuadraticRel(double x, double y, double x1, double y1);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegCurvetoQuadraticSmoothAbs</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em></code><br></br> The absolute Y coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegCurvetoQuadraticSmoothAbs createSVGPathSegCurvetoQuadraticSmoothAbs(double x, double y);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegCurvetoQuadraticSmoothRel</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em></code><br></br> The absolute Y coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegCurvetoQuadraticSmoothRel createSVGPathSegCurvetoQuadraticSmoothRel(double x, double y);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegLinetoAbs</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em></code><br></br> The absolute Y coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegLinetoAbs createSVGPathSegLinetoAbs(double x, double y);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegLinetoHorizontalAbs</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegLinetoHorizontalAbs createSVGPathSegLinetoHorizontalAbs(double x);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegLinetoHorizontalRel</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The relative X coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegLinetoHorizontalRel createSVGPathSegLinetoHorizontalRel(double x);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegLinetoRel</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The relative X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em></code><br></br> The relative Y coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegLinetoRel createSVGPathSegLinetoRel(double x, double y);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegLinetoVerticalAbs</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>y</em></code><br></br> The absolute Y coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegLinetoVerticalAbs createSVGPathSegLinetoVerticalAbs(double y);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegLinetoVerticalRel</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>y</em></code><br></br> The relative Y coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegLinetoVerticalRel createSVGPathSegLinetoVerticalRel(double y);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegMovetoAbs</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The absolute X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em></code><br></br> The absolute Y coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegMovetoAbs createSVGPathSegMovetoAbs(double x, double y);
    /** 
Returns a stand-alone, parentless <code>SVGPathSegMovetoRel</code> object.<br></br> <br></br> <strong>Parameters:</strong> <ul> <li><code>float <em>x</em></code><br></br> The relative X coordinate for the end point of this path segment.</li> <li><code>float <em>y</em></code><br></br> The relative Y coordinate for the end point of this path segment.</li> </ul>  */
    native public SVGPathSegMovetoRel createSVGPathSegMovetoRel(double x, double y);
    /** 
Returns the index into <code>pathSegList</code> which is <code>distance</code> units along the path, utilizing the user agent's distance-along-a-path algorithm. */
    native public double getPathSegAtLength(double distance);
    /** 
Returns the (x,y) coordinate in user space which is distance units along the path, utilizing the browser's distance-along-a-path algorithm. */
    native public SVGPoint getPointAtLength(double distance);
    /** 
Returns the computed value for the total length of the path using the browser's distance-along-a-path algorithm, as a distance in the current user coordinate system. */
    native public double getTotalLength();
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGPathElement prototype;
    public SVGPathElement(){}
    public Object className;
    public CSSStyleDeclaration style;
    public SVGAnimatedTransformList transform;
    public SVGStringList requiredExtensions;
    public SVGStringList requiredFeatures;
    public SVGStringList systemLanguage;
    native public Boolean hasExtension(String extension);
    public String xmllang;
    public String xmlspace;
    public SVGAnimatedBoolean externalResourcesRequired;
    public SVGPathSegList pathSegList;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

