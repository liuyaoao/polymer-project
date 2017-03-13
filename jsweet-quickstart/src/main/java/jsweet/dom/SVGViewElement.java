package jsweet.dom;
/** <p>The <code>SVGViewElement</code> interface provides access to the properties of <code>&lt;view&gt;</code> elements, as well as methods to manipulate them.</p>  */
@jsweet.lang.Extends({SVGExternalResourcesRequired.class,SVGFitToViewBox.class,SVGZoomAndPan.class})
public class SVGViewElement extends SVGElement {
    /** 
Corresponds to attribute <code>viewTarget</code> on the given <code>&lt;view&gt;</code> element. A list of DOMString values which contain the names listed in the <code>viewTarget</code> attribute. Each of the DOMString values can be associated with the corresponding element using the getElementById() method call. */
    public SVGStringList viewTarget;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGViewElement prototype;
    public SVGViewElement(){}
    public SVGAnimatedBoolean externalResourcesRequired;
    public SVGAnimatedPreserveAspectRatio preserveAspectRatio;
    public SVGAnimatedRect viewBox;
    public double zoomAndPan;
    public static double SVG_ZOOMANDPAN_DISABLE;
    public static double SVG_ZOOMANDPAN_MAGNIFY;
    public static double SVG_ZOOMANDPAN_UNKNOWN;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

