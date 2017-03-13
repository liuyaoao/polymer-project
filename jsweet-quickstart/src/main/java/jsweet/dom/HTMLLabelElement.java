package jsweet.dom;
/** <p>The <strong><code>HTMLLabelElement</code></strong> interface gives access to properties specific to <code>&lt;label&gt;</code> elements. It inherits from <code>HTMLElement</code>.</p>  */
public class HTMLLabelElement extends HTMLElement {
    /**
      * Retrieves a reference to the form that the object is embedded in.
      */
    public HTMLFormElement form;
    /**
      * Sets or retrieves the object to which the given label object is assigned.
      */
    public String htmlFor;
    public static HTMLLabelElement prototype;
    public HTMLLabelElement(){}
}

