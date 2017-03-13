package jsweet.dom;
/** <p>The <strong><code>HTMLLinkElement</code></strong> interface represents reference information for external resources and the relationship of those resources to a document and vice-versa. This object inherits all of the properties and methods of the <code>HTMLElement</code> interface.</p>  */
@jsweet.lang.Extends({LinkStyle.class})
public class HTMLLinkElement extends HTMLElement {
    /**
      * Sets or retrieves the character set used to encode the object.
      */
    public String charset;
    /** 
 Gets or sets whether the link is disabled; currently only used with style sheet links.  */
    public Boolean disabled;
    /**
      * Sets or retrieves a destination URL or an anchor point.
      */
    public String href;
    /**
      * Sets or retrieves the language code of the object.
      */
    public String hreflang;
    /**
      * Sets or retrieves the media type.
      */
    public String media;
    /**
      * Sets or retrieves the relationship between the object and the destination of the link.
      */
    public String rel;
    /**
      * Sets or retrieves the relationship between the object and the destination of the link.
      */
    public String rev;
    /**
      * Sets or retrieves the window or frame at which to target content.
      */
    public String target;
    /**
      * Sets or retrieves the MIME type of the object.
      */
    public String type;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static HTMLLinkElement prototype;
    public HTMLLinkElement(){}
    public StyleSheet sheet;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

