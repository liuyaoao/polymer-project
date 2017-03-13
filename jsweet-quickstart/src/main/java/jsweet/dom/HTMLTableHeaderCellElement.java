package jsweet.dom;
/** <p>The <strong><code>HTMLTableHeaderCellElement</code></strong> interface provides special properties and methods (beyond the regular <code>HTMLTableCellElement</code> and <code>HTMLElement</code> interfaces it also has available to it by inheritance) for manipulating the layout and presentation of table header cells in an HTML document.</p>  */
public class HTMLTableHeaderCellElement extends HTMLTableCellElement {
    /**
      * Sets or retrieves the group of cells in a table to which the object's information applies.
      */
    public String scope;
    public static HTMLTableHeaderCellElement prototype;
    public HTMLTableHeaderCellElement(){}
}

