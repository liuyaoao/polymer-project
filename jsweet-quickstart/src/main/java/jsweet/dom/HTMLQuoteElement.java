package jsweet.dom;
/** <p>The <strong><code>HTMLQuoteElement</code></strong> interface provides special properties and methods (beyond the regular <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating quoting elements, like <code>&lt;blockquote&gt;</code> and <code>&lt;q&gt;</code>, but not the <code>&lt;cite&gt;</code> element.</p>  */
public class HTMLQuoteElement extends HTMLElement {
    /**
      * Sets or retrieves reference information about the object.
      */
    public String cite;
    /**
      * Sets or retrieves the date and time of a modification to the object.
      */
    public String dateTime;
    public static HTMLQuoteElement prototype;
    public HTMLQuoteElement(){}
}

