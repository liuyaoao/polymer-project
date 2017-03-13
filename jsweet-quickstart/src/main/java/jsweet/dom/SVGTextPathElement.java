package jsweet.dom;
@jsweet.lang.Extends({SVGURIReference.class})
public class SVGTextPathElement extends SVGTextContentElement {
    public SVGAnimatedEnumeration method;
    public SVGAnimatedEnumeration spacing;
    public SVGAnimatedLength startOffset;
    public double TEXTPATH_METHODTYPE_ALIGN;
    public double TEXTPATH_METHODTYPE_STRETCH;
    public double TEXTPATH_METHODTYPE_UNKNOWN;
    public double TEXTPATH_SPACINGTYPE_AUTO;
    public double TEXTPATH_SPACINGTYPE_EXACT;
    public double TEXTPATH_SPACINGTYPE_UNKNOWN;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGTextPathElement prototype;
    public SVGTextPathElement(){}
    public SVGAnimatedString href;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

