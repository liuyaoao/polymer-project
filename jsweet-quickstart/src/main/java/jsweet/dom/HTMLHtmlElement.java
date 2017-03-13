package jsweet.dom;
/** <p>The <strong><code>HTMLHtmlElement</code></strong> interface serves as the root node for a given HTML&nbsp;document.&nbsp; This object inherits the properties and methods described in the <code>HTMLElement</code> interface.</p> <p>You can retrieve the <code>HTMLHtmlElement</code> object for a given document by reading the value of the <code>document.documentElement</code> property.</p>  */
public class HTMLHtmlElement extends HTMLElement {
    /**
      * Sets or retrieves the DTD version that governs the current document.
      */
    public String version;
    public static HTMLHtmlElement prototype;
    public HTMLHtmlElement(){}
}

