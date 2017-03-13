package jsweet.dom;
/** <p>The <strong><code>HTMLOptGroupElement</code></strong> interface provides special properties and methods (beyond the regular <code>HTMLElement</code> object interface they also have available to them by inheritance) for manipulating the layout and presentation of <code>&lt;optgroup&gt;</code> elements.</p>  */
public class HTMLOptGroupElement extends HTMLElement {
    /**
      * Sets or retrieves the status of an option.
      */
    public Boolean defaultSelected;
    /** 
If <code>true</code>, the whole list of children <code>&lt;option&gt;</code> is disabled */
    public Boolean disabled;
    /**
      * Retrieves a reference to the form that the object is embedded in.
      */
    public HTMLFormElement form;
    /**
      * Sets or retrieves the ordinal position of an option in a list box.
      */
    public double index;
    /**
      * Sets or retrieves a value that you can use to implement your own label functionality for the object.
      */
    public String label;
    /**
      * Sets or retrieves whether the option in the list box is the default item.
      */
    public Boolean selected;
    /**
      * Sets or retrieves the text string specified by the option tag.
      */
    public String text;
    /**
      * Sets or retrieves the value which is returned to the server when the form control is submitted.
      */
    public String value;
    public static HTMLOptGroupElement prototype;
    public HTMLOptGroupElement(){}
}

