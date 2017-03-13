package jsweet.dom;
/** <p>The <code>SVGClipPathElement</code> interface provides access to the properties of <code>&lt;clipPath&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTransformable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class,SVGUnitTypes.class})
public class SVGClipPathElement extends SVGElement {
    /** 
Corresponds to attribute <code>clipPathUnits</code> on the given <code>&lt;clipPath&gt;</code> element. Takes one of the constants defined in <code>SVGUnitTypes</code> */
    public SVGAnimatedEnumeration clipPathUnits;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGClipPathElement prototype;
    public SVGClipPathElement(){}
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
    public static double SVG_UNIT_TYPE_OBJECTBOUNDINGBOX;
    public static double SVG_UNIT_TYPE_UNKNOWN;
    public static double SVG_UNIT_TYPE_USERSPACEONUSE;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

