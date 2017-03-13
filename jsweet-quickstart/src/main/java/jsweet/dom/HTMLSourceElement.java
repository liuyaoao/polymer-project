package jsweet.dom;
/** <p>The <strong><code>HTMLSourceElement</code></strong> interface provides special properties (beyond the regular <code>HTMLElement</code> object interface it also has available to it by inheritance) for manipulating <code>&lt;source&gt;</code> elements.</p>  */
public class HTMLSourceElement extends HTMLElement {
    /**
      * Gets or sets the intended media type of the media source.
     */
    public String media;
    public String msKeySystem;
    /**
      * The address or URL of the a media resource that is to be considered.
      */
    public String src;
    /**
     * Gets or sets the MIME type of a media resource.
     */
    public String type;
    public static HTMLSourceElement prototype;
    public HTMLSourceElement(){}
}

