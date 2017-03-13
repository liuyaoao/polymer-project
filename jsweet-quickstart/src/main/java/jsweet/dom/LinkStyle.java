package jsweet.dom;
/** <p>The <code><strong>LinkStyle</strong></code> interface allows to access the <em>associated CSS style sheet</em> of a node.</p> <p><code>LinkStyle</code> is a raw interface and no object of this type can be created; it is implemented by <code>HTMLLinkElement</code> and <code>HTMLStyleElement</code> objects.</p>  */
@jsweet.lang.Interface
public abstract class LinkStyle extends jsweet.lang.Object {
    /** 
 Returns the <code>StyleSheet</code> object associated with the given element, or <code>null</code> if there is none.  */
    public StyleSheet sheet;
}

