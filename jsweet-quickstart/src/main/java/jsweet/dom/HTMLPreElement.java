package jsweet.dom;
/** <p>The <strong><code>HTMLPreElement</code></strong> interface expose specific properties and methods (beyond those defined by regular <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating block of preformatted text.</p>  */
public class HTMLPreElement extends HTMLElement {
    /**
      * Indicates a citation by rendering text in italic type.
      */
    public String cite;
    public String clear;
    /**
      * Sets or gets a value that you can use to implement your own width functionality for the object.
      */
    public double width;
    public static HTMLPreElement prototype;
    public HTMLPreElement(){}
}

