package jsweet.dom;
/** <div> <p><strong>Obsolete</strong><br></br>This feature is obsolete. Although it may still work in some browsers, its use is discouraged since it could be removed at any time. Try to avoid using it.</p> </div> <p>The <strong><code>HTMLBaseFontElement</code></strong> interface provides special properties (beyond the regular <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating <code>&lt;basefont&gt;</code> elements.</p> <p>The <code>&lt;basefont&gt;</code> element has been deprecated in HTML4 and removed in HTML5. This latest specification requires that this element implements <code>HTMLUnknownElement</code> rather than <code>HTMLBaseFontElement</code>.</p>  */
@jsweet.lang.Extends({DOML2DeprecatedColorProperty.class})
public class HTMLBaseFontElement extends HTMLElement {
    /**
      * Sets or retrieves the current typeface family.
      */
    public String face;
    /**
      * Sets or retrieves the font size of the object.
      */
    public double size;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static HTMLBaseFontElement prototype;
    public HTMLBaseFontElement(){}
    /** 
 Is a <code>DOMString</code> representing the text color using either a named color or a color specified in the hexadecimal <code>#RRGGBB</code> format.  */
    public String color;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

