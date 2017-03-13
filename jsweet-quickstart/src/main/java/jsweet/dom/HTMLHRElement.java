package jsweet.dom;
/** <p>The <strong><code>HTMLHRElement</code></strong> interface provides special properties (beyond those of the <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating <code>&lt;hr&gt;</code> elements.</p>  */
@jsweet.lang.Extends({DOML2DeprecatedColorProperty.class,DOML2DeprecatedSizeProperty.class})
public class HTMLHRElement extends HTMLElement {
    /**
      * Sets or retrieves how the object is aligned with adjacent text.
      */
    public String align;
    /**
      * Sets or retrieves whether the horizontal rule is drawn with 3-D shading.
      */
    public Boolean noShade;
    /**
      * Sets or retrieves the width of the object.
      */
    public double width;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static HTMLHRElement prototype;
    public HTMLHRElement(){}
    /** 
The name of the color of the rule. */
    public String color;
    /** 
The height of the rule. */
    public double size;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

