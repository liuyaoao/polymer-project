package jsweet.dom;
/**  <p>The <strong><span><code>DocumentFragment</code></span></strong> interface represents a minimal document object that has no parent. It is used as a light-weight version of <code>Document</code> to store well-formed or potentially non-well-formed fragments of XML.</p> <p>Various other methods can take a document fragment as an argument (e.g., any <code>Node</code> interface methods such as <code>Node.appendChild</code> and <code>Node.insertBefore</code>), in which case the children of the fragment are appended or inserted, not the fragment itself.</p> <p>This interface is also of great use with Web components: <code>&lt;template&gt;</code> elements contains a <code>DocumentFragment</code> in their <code>HTMLTemplateElement.content</code> property.</p> <p>An empty <code>DocumentFragment</code> can be created using the <code>document.createDocumentFragment</code> method or the constructor.</p>  */
@jsweet.lang.Extends({NodeSelector.class})
public class DocumentFragment extends Node {
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static DocumentFragment prototype;
    public DocumentFragment(){}
    /** 
 Returns the first <code>Element</code> node within the <code>DocumentFragment</code>, in document order, that matches the specified selectors.  */
    native public Element querySelector(String selectors);
    /** 
 Returns a <code>NodeList</code> of all the <code>Element</code> nodes within the <code>DocumentFragment</code> that match the specified selectors.  */
    native public NodeListOf<Element> querySelectorAll(String selectors);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

