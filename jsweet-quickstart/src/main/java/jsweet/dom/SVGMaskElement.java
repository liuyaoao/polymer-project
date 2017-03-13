package jsweet.dom;
/** <p>The <code>SVGMaskElement</code> interface provides access to the properties of <code>&lt;mask&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class,SVGUnitTypes.class})
public class SVGMaskElement extends SVGElement {
    /** 
Corresponds to attribute <code>height</code> on the given <code>&lt;mask&gt;</code> element. */
    public SVGAnimatedLength height;
    /** 
Corresponds to attribute <code>maskContentUnits</code> on the given <code>&lt;mask&gt;</code> element. Takes one of the constants defined in <code>SVGUnitTypes</code> */
    public SVGAnimatedEnumeration maskContentUnits;
    /** 
Corresponds to attribute <code>maskUnits</code> on the given <code>&lt;mask&gt;</code> element. Takes one of the constants defined in <code>SVGUnitTypes</code> */
    public SVGAnimatedEnumeration maskUnits;
    /** 
Corresponds to attribute <code>width</code> on the given <code>&lt;mask&gt;</code> element. */
    public SVGAnimatedLength width;
    /** 
Corresponds to attribute <code>x</code> on the given <code>&lt;mask&gt;</code> element. */
    public SVGAnimatedLength x;
    /** 
Corresponds to attribute <code>y</code> on the given <code>&lt;mask&gt;</code> element. */
    public SVGAnimatedLength y;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGMaskElement prototype;
    public SVGMaskElement(){}
    public Object className;
    public CSSStyleDeclaration style;
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

