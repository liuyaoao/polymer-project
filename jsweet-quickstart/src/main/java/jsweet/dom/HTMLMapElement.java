package jsweet.dom;
/** <p>The <strong><code>HTMLMapElement</code></strong> interface provides special properties and methods (beyond those of the regular object <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating the layout and presentation of map elements.</p>  */
public class HTMLMapElement extends HTMLElement {
    /**
      * Retrieves a collection of the area objects defined for the given map object.
      */
    public HTMLAreasCollection areas;
    /**
      * Sets or retrieves the name of the object.
      */
    public String name;
    public static HTMLMapElement prototype;
    public HTMLMapElement(){}
}

