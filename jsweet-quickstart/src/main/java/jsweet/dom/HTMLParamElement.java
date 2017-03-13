package jsweet.dom;
/** <p>The <strong><code>HTMLParamElement</code></strong> interface provides special properties (beyond those of the regular <code>HTMLElement</code> object interface it inherits) for manipulating <code>&lt;param&gt;</code> elements, representing a pair of a key and a value that acts as a parameter for an <code>&lt;object&gt;</code> element.</p>  */
public class HTMLParamElement extends HTMLElement {
    /**
      * Sets or retrieves the name of an input parameter for an element.
      */
    public String name;
    /**
      * Sets or retrieves the content type of the resource designated by the value attribute.
      */
    public String type;
    /**
      * Sets or retrieves the value of an input parameter for an element.
      */
    public String value;
    /**
      * Sets or retrieves the data type of the value attribute.
      */
    public String valueType;
    public static HTMLParamElement prototype;
    public HTMLParamElement(){}
}

