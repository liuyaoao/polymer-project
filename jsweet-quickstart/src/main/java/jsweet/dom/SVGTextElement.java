package jsweet.dom;
/** <p>The <code>SVGTextElement</code> interface corresponds to the <code>&lt;text&gt;</code> elements.</p>  */
@jsweet.lang.Extends({SVGTransformable.class})
public class SVGTextElement extends SVGTextPositioningElement {
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGTextElement prototype;
    public SVGTextElement(){}
    public SVGAnimatedTransformList transform;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

