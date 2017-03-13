package jsweet.dom;
/** <p>The <strong><code>HTMLLIElement</code></strong> interface expose specific properties and methods (beyond those defined by regular <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating list elements.</p>  */
public class HTMLLIElement extends HTMLElement {
    /** 
The type of the bullets, <code>&quot;disc&quot;</code>, <code>&quot;square&quot;</code> or <code>&quot;circle&quot;</code>. As the standard way of defining the list type is via the CSS <code>list-style-type</code> property, use the CSSOM methods to set it via a script. */
    public String type;
    /**
      * Sets or retrieves the value of a list item.
      */
    public double value;
    public static HTMLLIElement prototype;
    public HTMLLIElement(){}
}

