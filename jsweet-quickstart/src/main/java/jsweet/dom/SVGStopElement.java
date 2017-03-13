package jsweet.dom;
/** <p>The <code>SVGStopElement</code> interface corresponds to the <code>&lt;stop&gt;</code> element.</p>  */
@jsweet.lang.Extends({SVGStylable.class})
public class SVGStopElement extends SVGElement {
    /** 
Corresponds to attribute <code>offset</code> on the given <code>&lt;stop&gt;</code> element. */
    public SVGAnimatedNumber offset;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGStopElement prototype;
    public SVGStopElement(){}
    public Object className;
    public CSSStyleDeclaration style;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

