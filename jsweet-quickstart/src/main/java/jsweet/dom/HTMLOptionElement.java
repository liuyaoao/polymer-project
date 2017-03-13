package jsweet.dom;
/** <p>The <strong><code>HTMLOptionElement</code></strong> interface represents <code>&lt;option&gt;</code> elements and inherits all classes and methods of the <code>HTMLElement</code> interface.</p>  */
public class HTMLOptionElement extends HTMLElement {
    /**
      * Sets or retrieves the status of an option.
      */
    public Boolean defaultSelected;
    /** 
Reflects the value of the <code>disabled</code> HTML&nbsp;attribute, which indicates that the option is unavailable to be selected. An option can also be disabled if it is a child of an <code>&lt;optgroup&gt;</code> element that is disabled. */
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
    public static HTMLOptionElement prototype;
    public HTMLOptionElement(){}
    native public static HTMLOptionElement create();
}

