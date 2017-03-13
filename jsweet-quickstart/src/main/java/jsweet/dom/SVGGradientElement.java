package jsweet.dom;
/** <p>The <code>SVGGradient</code> interface is a base interface used by <code>SVGLinearGradientElement</code> and <code>SVGRadialGradientElement</code>.</p>  */
@jsweet.lang.Extends({SVGStylable.class,SVGExternalResourcesRequired.class,SVGURIReference.class,SVGUnitTypes.class})
public class SVGGradientElement extends SVGElement {
    /** 
Corresponds to attribute <code>gradientTransform</code> on the given element. */
    public SVGAnimatedTransformList gradientTransform;
    /** 
Corresponds to attribute <code>gradientUnits</code> on the given element. Takes one of the constants defined in <code>SVGUnitTypes</code>. */
    public SVGAnimatedEnumeration gradientUnits;
    /** 
Corresponds to attribute <code>spreadMethod</code> on the given element. One of the Spread Method Types defined on this interface. */
    public SVGAnimatedEnumeration spreadMethod;
    /** 
Corresponds to value <em>pad</em>. */
    public double SVG_SPREADMETHOD_PAD;
    /** 
Corresponds to value <em>reflect</em>. */
    public double SVG_SPREADMETHOD_REFLECT;
    /** 
Corresponds to value <em>repeat</em>. */
    public double SVG_SPREADMETHOD_REPEAT;
    /** 
The type is not one of predefined types. It is invalid to attempt to define a new value of this type or to attempt to switch an existing value to this type. */
    public double SVG_SPREADMETHOD_UNKNOWN;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGGradientElement prototype;
    public SVGGradientElement(){}
    public Object className;
    public CSSStyleDeclaration style;
    public SVGAnimatedBoolean externalResourcesRequired;
    public SVGAnimatedString href;
    public static double SVG_UNIT_TYPE_OBJECTBOUNDINGBOX;
    public static double SVG_UNIT_TYPE_UNKNOWN;
    public static double SVG_UNIT_TYPE_USERSPACEONUSE;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

