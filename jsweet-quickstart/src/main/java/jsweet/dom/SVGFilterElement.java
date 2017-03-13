package jsweet.dom;
/** <p>The <code>SVGFilterElement</code> interface provides access to the properties of <code>&lt;filter&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGUnitTypes.class,SVGStylable.class,SVGLangSpace.class,SVGURIReference.class,SVGExternalResourcesRequired.class})
public class SVGFilterElement extends SVGElement {
    /** 
Sets the values for attribute <code>filterRes</code>. */
    public SVGAnimatedInteger filterResX;
    /** 
Sets the values for attribute <code>filterRes</code>. */
    public SVGAnimatedInteger filterResY;
    /** 
Corresponds to attribute <code>filterUnits</code> on the given <code>&lt;filter&gt;</code> element. Takes one of the constants defined in <code>SVGUnitTypes</code>. */
    public SVGAnimatedEnumeration filterUnits;
    /** 
Corresponds to attribute <code>height</code> on the given <code>&lt;filter&gt;</code> element. */
    public SVGAnimatedLength height;
    /** 
Corresponds to attribute <code>primitiveUnits</code> on the given <code>&lt;filter&gt;</code> element. Takes one of the constants defined in <code>SVGUnitTypes</code>. */
    public SVGAnimatedEnumeration primitiveUnits;
    /** 
Corresponds to attribute <code>width</code> on the given <code>&lt;filter&gt;</code> element. */
    public SVGAnimatedLength width;
    /** 
Corresponds to attribute <code>x</code> on the given <code>&lt;filter&gt;</code> element. */
    public SVGAnimatedLength x;
    /** 
Corresponds to attribute <code>y</code> on the given <code>&lt;filter&gt;</code> element. */
    public SVGAnimatedLength y;
    /** 
Sets the values for attribute <code>filterRes</code>. */
    native public void setFilterRes(double filterResX, double filterResY);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGFilterElement prototype;
    public SVGFilterElement(){}
    public static double SVG_UNIT_TYPE_OBJECTBOUNDINGBOX;
    public static double SVG_UNIT_TYPE_UNKNOWN;
    public static double SVG_UNIT_TYPE_USERSPACEONUSE;
    public Object className;
    public CSSStyleDeclaration style;
    public String xmllang;
    public String xmlspace;
    public SVGAnimatedString href;
    public SVGAnimatedBoolean externalResourcesRequired;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

