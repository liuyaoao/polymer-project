package jsweet.dom;
/** <p>The <strong><code>HTMLObjectElement</code></strong> interface provides special properties and methods (beyond those on the <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating the layout and presentation of <code>&lt;object&gt;</code> element, representing external resources.</p>  */
@jsweet.lang.Extends({GetSVGDocument.class})
public class HTMLObjectElement extends HTMLElement {
    /**
      * Retrieves a string of the URL where the object tag can be found. This is often the href of the document that the object is in, or the value set by a base element.
      */
    public String BaseHref;
    /** 
 Is a <code>DOMString</code> representing an enumerated property indicating alignment of the element's contents with respect to the surrounding context. The possible values are <code>&quot;left&quot;</code>, <code>&quot;right&quot;</code>, <code>&quot;justify&quot;</code>, and <code>&quot;center&quot;</code>.  */
    public String align;
    /**
      * Sets or retrieves a text alternative to the graphic.
      */
    public String alt;
    /**
      * Gets or sets the optional alternative HTML script to execute if the object fails to load.
      */
    public String altHtml;
    /**
      * Sets or retrieves a character string that can be used to implement your own archive functionality for the object.
      */
    public String archive;
    /** 
 Is a <code>DOMString</code> that reflects the <code>border</code> HTML attribute, specifying the width of a border around the object.  */
    public String border;
    /**
      * Sets or retrieves the URL of the file containing the compiled Java class.
      */
    public String code;
    /**
      * Sets or retrieves the URL of the component.
      */
    public String codeBase;
    /**
      * Sets or retrieves the Internet media type for the code associated with the object.
      */
    public String codeType;
    /**
      * Retrieves the document object of the page or frame.
      */
    public Document contentDocument;
    /**
      * Sets or retrieves the URL that references the data of the object.
      */
    public String data;
    /** 
 Is a <code>Boolean</code> that reflects the <code>declare</code> HTML attribute, indicating that this is a declaration, not an instantiation, of the object.  */
    public Boolean declare;
    /**
      * Retrieves a reference to the form that the object is embedded in.
      */
    public HTMLFormElement form;
    /**
      * Sets or retrieves the height of the object.
      */
    public String height;
    /** 
 Is a <code>long</code> representing the horizontal space in pixels around the control.  */
    public double hspace;
    /**
      * Gets or sets whether the DLNA PlayTo device is available.
      */
    public Boolean msPlayToDisabled;
    /**
      * Gets or sets the path to the preferred media source. This enables the Play To target device to stream the media content, which can be DRM protected, from a different location, such as a cloud media server.
      */
    public String msPlayToPreferredSourceUri;
    /**
      * Gets or sets the primary DLNA PlayTo device.
      */
    public Boolean msPlayToPrimary;
    /**
      * Gets the source associated with the media element for use by the PlayToManager.
      */
    public Object msPlayToSource;
    /**
      * Sets or retrieves the name of the object.
      */
    public String name;
    /**
      * Retrieves the contained object.
      */
    public Object object;
    public double readyState;
    /**
      * Sets or retrieves a message to be displayed while an object is loading.
      */
    public String standby;
    /**
      * Sets or retrieves the MIME type of the object.
      */
    public String type;
    /**
      * Sets or retrieves the URL, often with a bookmark extension (#name), to use as a client-side image map.
      */
    public String useMap;
    /**
      * Returns the error message that would be displayed if the user submits the form, or an empty string if no error message. It also triggers the standard error message, such as "this is a required field". The result is that the user sees validation messages without actually submitting.
      */
    public String validationMessage;
    /**
      * Returns a  ValidityState object that represents the validity states of an element.
      */
    public ValidityState validity;
    /** 
 Is a <code>long</code> representing the horizontal space in pixels around the control.  */
    public double vspace;
    /**
      * Sets or retrieves the width of the object.
      */
    public String width;
    /**
      * Returns whether an element will successfully validate based on forms validation rules and constraints.
      */
    public Boolean willValidate;
    /**
      * Returns whether a form will validate when it is submitted, without having to submit it.
      */
    native public Boolean checkValidity();
    /**
      * Sets a custom error message that is displayed when a form is submitted.
      * @param error Sets a custom error message that is displayed when a form is submitted.
      */
    native public void setCustomValidity(String error);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static HTMLObjectElement prototype;
    public HTMLObjectElement(){}
    native public Document getSVGDocument();
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

