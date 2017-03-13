package jsweet.dom;
/** <p>The <code>SVGStyleElement</code> interface corresponds to the SVG <code>&lt;style&gt;</code> element.</p>  */
@jsweet.lang.Extends({SVGLangSpace.class})
public class SVGStyleElement extends SVGElement {
    /** 
Corresponds to attribute <code>media</code> on the given element. A <code>DOMException</code> is raised with code <code>NO_MODIFICATION_ALLOWED_ERR</code> on an attempt to change the value of a read only attribut. */
    public String media;
    /** 
Corresponds to attribute <code>title</code> on the given element. A <code>DOMException</code> is raised with code <code>NO_MODIFICATION_ALLOWED_ERR</code> on an attempt to change the value of a read only attribut. */
    public String title;
    /** 
Corresponds to attribute <code>type</code> on the given element. A <code>DOMException</code> is raised with code <code>NO_MODIFICATION_ALLOWED_ERR</code> on an attempt to change the value of a read only attribut. */
    public String type;
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static SVGStyleElement prototype;
    public SVGStyleElement(){}
    public String xmllang;
    public String xmlspace;
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

