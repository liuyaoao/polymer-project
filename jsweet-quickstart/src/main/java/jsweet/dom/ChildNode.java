package jsweet.dom;
/**  <p>The <code><strong>ChildNode</strong></code> interface contains methods that are particular to <code>Node</code> objects that can have a parent.</p> <p><code>ChildNode</code> is a raw interface and no object of this type can be created; it is implemented by <code>Element</code>, <code>DocumentType</code>, and <code>CharacterData</code> objects.</p>  */
@jsweet.lang.Interface
public abstract class ChildNode extends jsweet.lang.Object {
    /** 
 Removes this <code>ChildNode</code> from the children list of its parent.  */
    native public void remove();
}

