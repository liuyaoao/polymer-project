package jsweet.dom;
/**    */
public class TreeWalker extends jsweet.lang.Object {
    /** 
 Is the <code>Node</code> on which the <code>TreeWalker</code> is currently pointing at.  */
    public Node currentNode;
    /** 
 Is a <code>Boolean</code> indicating if, when discarding an <code>EntityReference</code> its whole sub-tree must be discarded at the same time.  */
    public Boolean expandEntityReferences;
    /** 
 Returns a <code>NodeFilter</code> used to select the relevant nodes.  */
    public NodeFilter filter;
    /** 
 Returns a <code>Node</code> representing the root node as specified when the <code>TreeWalker</code> was created.  */
    public Node root;
    /** 
 Returns an <code>unsigned long</code> being a bitmask made of constants describing the types of <code>Node</code> that must to be presented. Non-matching nodes are skipped, but their children may be included, if relevant. The possible values are: <table> <tbody> <tr> <td>Constant</td> <td>Numerical value</td> <td>Description</td> </tr> <tr> <td><code>NodeFilter.SHOW_ALL</code></td> <td><code>-1</code> (that is the max value of <code>unsigned long</code>)</td> <td>Shows all nodes.</td> </tr> <tr> <td><code>NodeFilter.SHOW_ATTRIBUTE</code> <span><i> </i></span></td> <td><code>2</code></td> <td>Shows attribute <code>Attr</code> nodes. This is meaningful only when creating a <code>TreeWalker</code> with an <code>Attr</code> node as its root; in this case, it means that the attribute node will appear in the first position of the iteration or traversal. Since attributes are never children of other nodes, they do not appear when traversing over the document tree.</td> </tr> <tr> <td><code>NodeFilter.SHOW_CDATA_SECTION</code> <span><i> </i></span></td> <td><code>8</code></td> <td>Shows <code>CDATASection</code>&nbsp;nodes.</td> </tr> <tr> <td><code>NodeFilter.SHOW_COMMENT</code></td> <td><code>128</code></td> <td>Shows <code>Comment</code>&nbsp;nodes.</td> </tr> <tr> <td><code>NodeFilter.SHOW_DOCUMENT</code></td> <td><code>256</code></td> <td>Shows <code>Document</code>&nbsp;nodes.</td> </tr> <tr> <td><code>NodeFilter.SHOW_DOCUMENT_FRAGMENT</code></td> <td><code>1024</code></td> <td>Shows <code>DocumentFragment</code>&nbsp;nodes.</td> </tr> <tr> <td><code>NodeFilter.SHOW_DOCUMENT_TYPE</code></td> <td><code>512</code></td> <td>Shows <code>DocumentType</code>&nbsp;nodes.</td> </tr> <tr> <td><code>NodeFilter.SHOW_ELEMENT</code></td> <td><code>1</code></td> <td>Shows <code>Element</code>&nbsp;nodes.</td> </tr> <tr> <td><code>NodeFilter.SHOW_ENTITY</code> <span><i> </i></span></td> <td><code>32</code></td> <td>Shows <code>Entity</code>&nbsp;nodes. This is meaningful only when creating a <code>TreeWalker</code> with an <code>Entity</code> node as its root; in this case, it means that the <code>Entity</code> node will appear in the first position of the traversal. Since entities are not part of the document tree, they do not appear when traversing over the document tree.</td> </tr> <tr> <td><code>NodeFilter.SHOW_ENTITY_REFERENCE</code> <span><i> </i></span></td> <td><code>16</code></td> <td>Shows <code>EntityReference</code>&nbsp;nodes.</td> </tr> <tr> <td><code>NodeFilter.SHOW_NOTATION</code> <span><i> </i></span></td> <td><code>2048</code></td> <td>Shows <code>Notation</code> nodes. This is meaningful only when creating a <code>TreeWalker</code> with a <code>Notation</code> node as its root; in this case, it means that the <code>Notation</code> node will appear in the first position of the traversal. Since entities are not part of the document tree, they do not appear when traversing over the document tree.</td> </tr> <tr> <td><code>NodeFilter.SHOW_PROCESSING_INSTRUCTION</code></td> <td><code>64</code></td> <td>Shows <code>ProcessingInstruction</code>&nbsp;nodes.</td> </tr> <tr> <td><code>NodeFilter.SHOW_TEXT</code></td> <td><code>4</code></td> <td>Shows <code>Text</code>&nbsp;nodes.</td> </tr> </tbody> </table>  */
    public double whatToShow;
    /** 
 Moves the current <code>Node</code> to the first <em>visible</em> child of the current node, and returns the found child. It also moves the current node to this child. If no such child exists, returns <code>null</code> and the current node is not changed.  */
    native public Node firstChild();
    /** 
 Moves the current <code>Node</code> to the last <em>visible</em> child of the current node, and returns the found child. It also moves the current node to this child. If no such child exists, returns <code>null</code> and the current node is not changed.  */
    native public Node lastChild();
    /** 
 Moves the current <code>Node</code> to the next <em>visible</em> node in the document order, and returns the found node. It also moves the current node to this one. If no such node exists, returns <code>null</code> and the current node is not changed.  */
    native public Node nextNode();
    /** 
 Moves the current <code>Node</code> to its next sibling, if any, and returns the found sibling. If there is no such node, return <code>null</code> and the current node is not changed.  */
    native public Node nextSibling();
    /** 
 Moves the current <code>Node</code> to the first <em>visible</em> ancestor node in the document order, and returns the found node. It also moves the current node to this one. If no such node exists, or if it is before that the <em>root</em> <em> node</em> defined at the object construction, returns <code>null</code> and the current node is not changed.  */
    native public Node parentNode();
    /** 
 Moves the current <code>Node</code> to the previous <em>visible</em> node in the document order, and returns the found node. It also moves the current node to this one. If no such node exists,or if it is before that the <em>root</em> <em> node</em> defined at the object construction, returns <code>null</code> and the current node is not changed.  */
    native public Node previousNode();
    /** 
 Moves the current <code>Node</code> to its previous sibling, if any, and returns the found sibling. If there is no such node, return <code>null</code> and the current node is not changed.  */
    native public Node previousSibling();
    public static TreeWalker prototype;
    public TreeWalker(){}
}

