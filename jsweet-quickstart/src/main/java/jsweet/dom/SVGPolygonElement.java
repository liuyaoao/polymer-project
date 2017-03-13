package jsweet.dom;
/** <p>The <code>SVGPolygonElement</code> interface provides access to the properties of <code>&lt;polygon&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTransformable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class,SVGAnimatedPoints.class})
public class SVGPolygonElement extends SVGElement {
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGPolygonElement prototype;
    public SVGPolygonElement(){}
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
    public SVGPointList animatedPoints;
    public SVGPointList points;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

