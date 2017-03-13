package jsweet.dom;
/** <p>The <code>SVGScriptElement</code> interface corresponds to the SVG <code>&lt;script&gt;</code> element.</p>  */
@jsweet.lang.Extends({SVGExternalResourcesRequired.class,SVGURIReference.class})
public class SVGScriptElement extends SVGElement {
    /** 
Corresponds to attribute <code>type</code> on the given element. A <code>DOMException</code> is raised with code <code>NO_MODIFICATION_ALLOWED_ERR</code> on an attempt to change the value of a read only attribut. */
    public String type;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGScriptElement prototype;
    public SVGScriptElement(){}
    public SVGAnimatedBoolean externalResourcesRequired;
    public SVGAnimatedString href;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

