package jsweet.dom;
/** <p>The <code>SVGPatternElement</code> interface corresponds to the <code>&lt;pattern&gt;</code> element.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGTests.class,SVGLangSpace.class,SVGExternalResourcesRequired.class,SVGFitToViewBox.class,SVGURIReference.class,SVGUnitTypes.class})
public class SVGPatternElement extends SVGElement {
    /** 
Corresponds to attribute <code>height</code> on the given <code>&lt;pattern&gt;</code> element. */
    public SVGAnimatedLength height;
    /** 
Corresponds to attribute <code>patternContentUnits</code> on the given <code>&lt;pattern&gt;</code> element. Takes one of the constants defined in <code>SVGUnitTypes</code>. */
    public SVGAnimatedEnumeration patternContentUnits;
    /** 
Corresponds to attribute <code>patternTransform</code> on the given <code>&lt;pattern&gt;</code> element. */
    public SVGAnimatedTransformList patternTransform;
    /** 
Corresponds to attribute <code>patternUnits</code> on the given <code>&lt;pattern&gt;</code> element. Takes one of the constants defined in <code>SVGUnitTypes</code>. */
    public SVGAnimatedEnumeration patternUnits;
    /** 
Corresponds to attribute <code>width</code> on the given <code>&lt;pattern&gt;</code> element. */
    public SVGAnimatedLength width;
    /** 
Corresponds to attribute <code>x</code> on the given <code>&lt;pattern&gt;</code> element. */
    public SVGAnimatedLength x;
    /** 
Corresponds to attribute <code>y</code> on the given <code>&lt;pattern&gt;</code> element. */
    public SVGAnimatedLength y;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGPatternElement prototype;
    public SVGPatternElement(){}
    public Object className;
    public CSSStyleDeclaration style;
    public SVGStringList requiredExtensions;
    public SVGStringList requiredFeatures;
    public SVGStringList systemLanguage;
    native public Boolean hasExtension(String extension);
    public String xmllang;
    public String xmlspace;
    public SVGAnimatedBoolean externalResourcesRequired;
    public SVGAnimatedPreserveAspectRatio preserveAspectRatio;
    public SVGAnimatedRect viewBox;
    public SVGAnimatedString href;
    public static double SVG_UNIT_TYPE_OBJECTBOUNDINGBOX;
    public static double SVG_UNIT_TYPE_UNKNOWN;
    public static double SVG_UNIT_TYPE_USERSPACEONUSE;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

