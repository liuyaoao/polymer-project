package jsweet.dom;
/** <p>The <strong><code>HTMLAnchorElement</code></strong> interface represents hyperlink elements and provides special properties and methods (beyond those of the regular <code>HTMLElement</code> object interface they also have available to them by inheritance) for manipulating the layout and presentation of such elements.</p>  */
public class HTMLAnchorElement extends HTMLElement {
    public String Methods;
    /**
      * Sets or retrieves the character set used to encode the object.
      */
    public String charset;
    /**
      * Sets or retrieves the coordinates of the object.
      */
    public String coords;
    /**
      * Contains the anchor portion of the URL including the hash sign (#).
      */
    public String hash;
    /**
      * Contains the hostname and port values of the URL.
      */
    public String host;
    /**
      * Contains the hostname of a URL.
      */
    public String hostname;
    /**
      * Sets or retrieves a destination URL or an anchor point.
      */
    public String href;
    /**
      * Sets or retrieves the language code of the object.
      */
    public String hreflang;
    public String mimeType;
    /**
      * Sets or retrieves the shape of the object.
      */
    public String name;
    public String nameProp;
    /**
      * Contains the pathname of the URL.
      */
    public String pathname;
    /**
      * Sets or retrieves the port number associated with a URL.
      */
    public String port;
    /**
      * Contains the protocol of the URL.
      */
    public String protocol;
    public String protocolLong;
    /**
      * Sets or retrieves the relationship between the object and the destination of the link.
      */
    public String rel;
    /**
      * Sets or retrieves the relationship between the object and the destination of the link.
      */
    public String rev;
    /**
      * Sets or retrieves the substring of the href property that follows the question mark.
      */
    public String search;
    /**
      * Sets or retrieves the shape of the object.
      */
    public String shape;
    /**
      * Sets or retrieves the window or frame at which to target content.
      */
    public String target;
    /**
      * Retrieves or sets the text of the object as a string. 
      */
    public String text;
    /** 
 Is a <code>DOMString</code> that reflects the <code>type</code> HTML attribute, indicating the MIME type of the linked resource.  */
    public String type;
    public String urn;
    /** 
      * Returns a string representation of an object.
      */
    native public String toString();
    public static HTMLAnchorElement prototype;
    public HTMLAnchorElement(){}
}

