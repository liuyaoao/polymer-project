package jsweet.dom;
/** <p>A <strong><code>NodeFilter</code></strong> interface represents an object used to filter the nodes in a <code>NodeIterator</code> or <code>TreeWalker</code>. They don't know anything about the DOM or how to traverse nodes; they just know how to evaluate a single node against the provided filter.</p> <div> <p>The browser doesn't provide any object implementing this interface. It is the user who is expected to write one, tailoring the <code>acceptNode()</code> method to its needs, and using it with some <code>TreeWalker</code> or <code>NodeIterator</code> objects.</p> </div>  */
public class NodeFilter extends jsweet.lang.Object {
    /** 
 Returns an <code>unsigned short</code> that will be used to tell if a given <code>Node</code> must be accepted or not by the <code>NodeIterator</code> or <code>TreeWalker</code> iteration algorithm. This method is expected to be written by the user of a <code>NodeFilter</code>. Possible return values are: <table> <tbody> <tr> <td>Constant</td> <td>Description</td> </tr> <tr> <td><code>FILTER_ACCEPT</code></td> <td>Value returned by the <code>NodeFilter.acceptNode()</code> method when a node should be accepted.</td> </tr> <tr> <td><code>FILTER_REJECT</code></td> <td>Value to be returned by the <code>NodeFilter.acceptNode()</code> method when a node should be rejected. The children of rejected nodes are not visited by the <code>NodeIterator</code> or <code>TreeWalker</code> object; this value is treated as &quot;skip this node and all its children&quot;.</td> </tr> <tr> <td><code>FILTER_SKIP</code></td> <td>Value to be returned by <code>NodeFilter.acceptNode()</code> for nodes to be skipped by the <code>NodeIterator</code> or <code>TreeWalker</code> object. The children of skipped nodes are still considered. This is treated as &quot;skip this node but not its children&quot;.</td> </tr> </tbody> </table>  */
    native public double acceptNode(Node n);
    public static double FILTER_ACCEPT;
    public static double FILTER_REJECT;
    public static double FILTER_SKIP;
    public static double SHOW_ALL;
    public static double SHOW_ATTRIBUTE;
    public static double SHOW_CDATA_SECTION;
    public static double SHOW_COMMENT;
    public static double SHOW_DOCUMENT;
    public static double SHOW_DOCUMENT_FRAGMENT;
    public static double SHOW_DOCUMENT_TYPE;
    public static double SHOW_ELEMENT;
    public static double SHOW_ENTITY;
    public static double SHOW_ENTITY_REFERENCE;
    public static double SHOW_NOTATION;
    public static double SHOW_PROCESSING_INSTRUCTION;
    public static double SHOW_TEXT;
}

