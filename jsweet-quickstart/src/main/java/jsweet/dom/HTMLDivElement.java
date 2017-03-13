package jsweet.dom;
/** <div>
 &nbsp; </div> <p>The <strong><code>HTMLDivElement</code></strong> interface provides special properties (beyond the regular <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating div elements.</p>  */
public class HTMLDivElement extends HTMLElement {
    /**
      * Sets or retrieves how the object is aligned with adjacent text. 
      */
    public String align;
    /**
      * Sets or retrieves whether the browser automatically performs wordwrap.
      */
    public Boolean noWrap;
    public static HTMLDivElement prototype;
    public HTMLDivElement(){}
}

