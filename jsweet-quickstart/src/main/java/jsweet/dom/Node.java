package jsweet.dom;
/** <p>A <strong><code>Node</code></strong> is an interface from which a number of DOM types inherit, and allows these various types to be treated (or tested) similarly.</p> <p>The following interfaces all inherit from <code>Node</code> its methods and properties: <code>Document</code>, <code>Element</code>, <code>CharacterData</code> (which <code>Text</code>, <code>Comment</code>, and <code>CDATASection</code> inherit), <code>ProcessingInstruction</code>, <code>DocumentFragment</code>, <code>DocumentType</code>, <code>Notation</code>, <code>Entity</code>, <code>EntityReference</code></p> <p>These interfaces may return null in particular cases where the methods and properties are not relevant. They may throw an exception - for example when adding children to a node type for which no children can exist.</p>  */
public class Node extends EventTarget {
    public NamedNodeMap attributes;
    /** 
 Returns a <code>DOMString</code> representing the base URL. The concept of base URL changes from one language to another; in HTML, it corresponds to the protocol, the domain name and the directory structure, that is all until the last <code>'/'</code>.  */
    public String baseURI;
    /** 
 Returns a live <code>NodeList</code> containing all the children of this node. <code>NodeList</code> being live means that if the children of the <code>Node</code> change, the <code>NodeList</code> object is automatically updated.  */
    public NodeList childNodes;
    /** 
 Returns a <code>Node</code> representing the first direct child node of the node, or <code>null</code> if the node has no child.  */
    public Node firstChild;
    /** 
 Returns a <code>Node</code> representing the last direct child node of the node, or <code>null</code> if the node has no child.  */
    public Node lastChild;
    /** 
 Returns a <code>DOMString</code> representing the local part of the qualified name of an element. In Firefox 3.5 and earlier, the property upper-cases the local name for HTML&nbsp;elements (but not XHTML&nbsp;elements). In later versions, this does not happen, so the property is in lower case for both HTML&nbsp;and XHTML. <br></br> Though recent specifications require <code>localName</code> to be defined on the <code>Element</code> interface, Gecko-based browsers still implement it on the <code>Node</code> interface.  */
    public String localName;
    /** 
 The namespace URI of this node, or <code>null</code> if it is no namespace. In Firefox 3.5 and earlier, HTML&nbsp;elements are in no namespace. In later versions, HTML&nbsp;elements are in the <code>http://www.w3.org/1999/xhtml</code> namespace in both HTML&nbsp;and XML&nbsp;trees. <br></br> Though recent specifications require <code>namespaceURI</code> to be defined on the <code>Element</code> interface, Gecko-based browsers still implement it on the <code>Node</code> interface.  */
    public String namespaceURI;
    /** 
 Returns a <code>Node</code> representing the next node in the tree, or <code>null</code> if there isn't such node.  */
    public Node nextSibling;
    /** 
 Returns a <code>DOMString</code> containing the name of the <code>Node</code>. The structure of the name will differ with the name type. E.g. An <code>HTMLElement</code> will contain the name of the corresponding tag, like <code>'audio'</code> for an <code>HTMLAudioElement</code>, a <code>Text</code> node will have the <code>'#text'</code> string, or a <code>Document</code> node will have the <code>'#document'</code> string.  */
    public String nodeName;
    /** 
 Returns an <code>unsigned short</code> representing the type of the node. Possible values are: <table> <tbody> <tr> <th>Name</th> <th>Value</th> </tr> <tr> <td><code>ELEMENT_NODE</code></td> <td><code>1</code></td> </tr> <tr> <td><code>ATTRIBUTE_NODE</code> <span><i> </i></span></td> <td><code>2</code></td> </tr> <tr> <td><code>TEXT_NODE</code></td> <td><code>3</code></td> </tr> <tr> <td><code>CDATA_SECTION_NODE</code> <span><i> </i></span></td> <td><code>4</code></td> </tr> <tr> <td><code>ENTITY_REFERENCE_NODE</code> <span><i> </i></span></td> <td><code>5</code></td> </tr> <tr> <td><code>ENTITY_NODE</code> <span><i> </i></span></td> <td><code>6</code></td> </tr> <tr> <td><code>PROCESSING_INSTRUCTION_NODE</code></td> <td><code>7</code></td> </tr> <tr> <td><code>COMMENT_NODE</code></td> <td><code>8</code></td> </tr> <tr> <td><code>DOCUMENT_NODE</code></td> <td><code>9</code></td> </tr> <tr> <td><code>DOCUMENT_TYPE_NODE</code></td> <td><code>10</code></td> </tr> <tr> <td><code>DOCUMENT_FRAGMENT_NODE</code></td> <td><code>11</code></td> </tr> <tr> <td><code>NOTATION_NODE</code> <span><i> </i></span></td> <td><code>12</code></td> </tr> </tbody> </table>  */
    public double nodeType;
    /** 
 Is a <code>DOMString</code> representing the value of an object. For most <code>Node</code> types, this returns <code>null</code> and any set operation is ignored. For nodes of type <code>TEXT_NODE</code> ( <code>Text</code> objects), <code>COMMENT_NODE</code> ( <code>Comment</code> objects), and <code>PROCESSING_INSTRUCTION_NODE</code> ( <code>ProcessingInstruction</code> objects), the value corresponds to the text data contained in the object.  */
    public String nodeValue;
    /** 
 Returns the <code>Document</code> that this node belongs to. If no document is associated with it, returns <code>null</code>.  */
    public Document ownerDocument;
    /** 
 Returns an <code>Element</code> that is the parent of this node. If the node has no parent, or if that parent is not an <code>Element</code>, this property returns <code>null</code>.  */
    public HTMLElement parentElement;
    /** 
 Returns a <code>Node</code> that is the parent of this node. If there is no such node, like if this node is the top of the tree or if doesn't participate in a tree, this property returns <code>null</code>.  */
    public Node parentNode;
    /** 
 Is a <code>DOMString</code> representing the namespace prefix of the node, or <code>null</code> if no prefix is specified. <br></br> Though recent specifications require <code>prefix</code> to be defined on the <code>Element</code> interface, Gecko-based browsers still implement it on the <code>Node</code> interface.  */
    public String prefix;
    /** 
 Returns a <code>Node</code> representing the previous node in the tree, or <code>null</code> if there isn't such node.  */
    public Node previousSibling;
    /** 
 Is a <code>DOMString</code> representing the textual content of an element and all its descendants.  */
    public String textContent;
    /** 
 Insert a <code>Node</code> as the last child node of this element.  */
    native public Node appendChild(Node newChild);
    /** 
 Clone a <code>Node</code>, and optionally, all of its contents. By default, it clones the content of the node.  */
    native public Node cloneNode(Boolean deep);
    /** 
 &nbsp;  */
    native public double compareDocumentPosition(Node other);
    /** 
 Returns a <code>Boolean</code> indicating if the element has any attributes, or not.  */
    native public Boolean hasAttributes();
    /** 
 Returns a <code>Boolean</code> indicating if the element has any child nodes, or not.  */
    native public Boolean hasChildNodes();
    /** 
 Inserts the first <code>Node</code> given in a parameter immediately before the second, child of this element, <code>Node</code>.  */
    native public Node insertBefore(Node newChild, Node refChild);
    /** 
 &nbsp;  */
    native public Boolean isDefaultNamespace(String namespaceURI);
    /** 
 &nbsp;  */
    native public Boolean isEqualNode(Node arg);
    /** 
 &nbsp;  */
    native public Boolean isSameNode(Node other);
    /** 
 &nbsp;  */
    native public String lookupNamespaceURI(String prefix);
    /** 
 &nbsp;  */
    native public String lookupPrefix(String namespaceURI);
    /** 
 Clean up all the text nodes under this element (merge adjacent, remove empty).  */
    native public void normalize();
    /** 
 Removes a child node from the current element, which must be a child of the current node.  */
    native public Node removeChild(Node oldChild);
    /** 
 Replaces one child <code>Node</code> of the current one with the second one given in parameter.  */
    native public Node replaceChild(Node newChild, Node oldChild);
    /** 
 &nbsp;  */
    native public Boolean contains(Node node);
    public double ATTRIBUTE_NODE;
    public double CDATA_SECTION_NODE;
    public double COMMENT_NODE;
    public double DOCUMENT_FRAGMENT_NODE;
    public double DOCUMENT_NODE;
    public double DOCUMENT_POSITION_CONTAINED_BY;
    public double DOCUMENT_POSITION_CONTAINS;
    public double DOCUMENT_POSITION_DISCONNECTED;
    public double DOCUMENT_POSITION_FOLLOWING;
    public double DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC;
    public double DOCUMENT_POSITION_PRECEDING;
    public double DOCUMENT_TYPE_NODE;
    public double ELEMENT_NODE;
    public double ENTITY_NODE;
    public double ENTITY_REFERENCE_NODE;
    public double NOTATION_NODE;
    public double PROCESSING_INSTRUCTION_NODE;
    public double TEXT_NODE;
    public static Node prototype;
    public Node(){}
    /** 
 Clone a <code>Node</code>, and optionally, all of its contents. By default, it clones the content of the node.  */
    native public Node cloneNode();
    /** 
 Inserts the first <code>Node</code> given in a parameter immediately before the second, child of this element, <code>Node</code>.  */
    native public Node insertBefore(Node newChild);
}

