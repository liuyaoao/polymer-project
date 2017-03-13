package jsweet.dom;
/**  <p>The <code><strong>DOMImplementation</strong></code> interface represent an object providing methods which are not dependent on any particular document. Such an object is returned by the <code>Document.implementation</code> property.</p>  */
public class DOMImplementation extends jsweet.lang.Object {
    /** 
 Creates and returns an <code>XMLDocument</code>.  */
    native public Document createDocument(String namespaceURI, String qualifiedName, DocumentType doctype);
    /** 
 Creates and returns a <code>DocumentType</code>.  */
    native public DocumentType createDocumentType(String qualifiedName, String publicId, String systemId);
    /** 
 Creates and returns an HTML <code>Document</code>.  */
    native public Document createHTMLDocument(String title);
    /** 
 Returns a <code>Boolean</code> indicating if a given feature is supported or not. This function is unreliable and kept for compatibility purpose alone: except for SVG-related queries, it always returns <code>true</code>. Old browsers are very inconsistent in their behavior.  */
    native public Boolean hasFeature(String feature, String version);
    public static DOMImplementation prototype;
    public DOMImplementation(){}
}

