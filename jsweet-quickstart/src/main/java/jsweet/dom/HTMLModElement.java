package jsweet.dom;
/** <p>The <strong><code>HTMLModElement</code></strong> interface provides special properties (beyond the regular methods and properties available through the <code>HTMLElement</code> interface they also have available to them by inheritance) for manipulating modification elements, that is <code>&lt;del&gt;</code> and <code>&lt;ins&gt;</code>.</p>  */
public class HTMLModElement extends HTMLElement {
    /**
      * Sets or retrieves reference information about the object.
      */
    public String cite;
    /**
      * Sets or retrieves the date and time of a modification to the object.
      */
    public String dateTime;
    public static HTMLModElement prototype;
    public HTMLModElement(){}
}

