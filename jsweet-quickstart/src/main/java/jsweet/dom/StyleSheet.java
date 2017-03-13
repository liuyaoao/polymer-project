package jsweet.dom;
/** <p>An object implementing the <code>StyleSheet</code> interface represents a single style sheet. CSS style sheets will further implement the more specialized <code>CSSStyleSheet</code> interface.</p>  */
public class StyleSheet extends jsweet.lang.Object {
    /** 
 Is a <code>Boolean</code> representing whether the current stylesheet has been applied or not.  */
    public Boolean disabled;
    /** 
 Returns a <code>DOMString</code> representing the location of the stylesheet.  */
    public String href;
    /** 
 Returns a <code>MediaList</code> representing the intended destination medium for style information.  */
    public MediaList media;
    /** 
 Returns a <code>Node</code> associating this style sheet with the current document.  */
    public Node ownerNode;
    /** 
 Returns a <code>StyleSheet</code> including this one, if any; returns <code>null</code> if there aren't any.  */
    public StyleSheet parentStyleSheet;
    /** 
 Returns a <code>DOMString</code> representing the advisory title of the current style sheet.  */
    public String title;
    /** 
 Returns a <code>DOMString</code> representing the style sheet language for this style sheet.  */
    public String type;
    public static StyleSheet prototype;
    public StyleSheet(){}
}

