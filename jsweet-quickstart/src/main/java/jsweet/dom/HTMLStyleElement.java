package jsweet.dom;
/** <p>The <strong><code>HTMLStyleElement</code></strong> interface represents a <code>&lt;style&gt;</code> element. It inherits properties and methods from its parent, <code>HTMLElement</code>, and from <code>LinkStyle</code>.</p> <p>This interface doesn't allow to manipulate the CSS it contains (in most case). To manipulate CSS, see Using dynamic styling information for an overview of the objects used to manipulate specified CSS properties using the DOM.</p>  */
@jsweet.lang.Extends({LinkStyle.class})
public class HTMLStyleElement extends HTMLElement {
    /**
      * Sets or retrieves the media type.
      */
    public String media;
    /**
      * Retrieves the CSS language in which the style sheet is written.
      */
    public String type;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static HTMLStyleElement prototype;
    public HTMLStyleElement(){}
    public StyleSheet sheet;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

