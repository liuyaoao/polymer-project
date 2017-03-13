package jsweet.dom;
/** <div>
 &nbsp; </div> <p>The <strong><code>HTMLBaseElement</code></strong> interface contains the base URI&nbsp;for a document. This object inherits all of the properties and methods as described in the <code>HTMLElement</code> interface.</p>  */
public class HTMLBaseElement extends HTMLElement {
    /**
      * Gets or sets the baseline URL on which relative links are based.
      */
    public String href;
    /**
      * Sets or retrieves the window or frame at which to target content.
      */
    public String target;
    public static HTMLBaseElement prototype;
    public HTMLBaseElement(){}
}

