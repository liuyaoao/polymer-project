package jsweet.dom;
/** <div> <p><strong>Obsolete</strong><br></br>This feature is obsolete. Although it may still work in some browsers, its use is discouraged since it could be removed at any time. Try to avoid using it.</p> </div> <p>The <strong><code>HTMLIsIndexElement</code></strong> interface provides special properties (beyond the regular <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating <code>&lt;isindex&gt;</code> elements.</p> <p>The <code>&lt;isindex&gt;</code> element has been deprecated in HTML4 and removed in HTML5. This latest specification requires that this element implements <code>HTMLUnknownElement</code> rather than <code>HTMLIsIndexElement</code>.</p>  */
public class HTMLIsIndexElement extends HTMLElement {
    /**
      * Sets or retrieves the URL to which the form content is sent for processing.
      */
    public String action;
    /**
      * Retrieves a reference to the form that the object is embedded in. 
      */
    public HTMLFormElement form;
    /** 
 Is a <code>DOMString</code> representing a text to be prompted for the field.  */
    public String prompt;
    public static HTMLIsIndexElement prototype;
    public HTMLIsIndexElement(){}
}

