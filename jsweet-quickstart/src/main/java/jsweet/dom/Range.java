package jsweet.dom;
/**  <p>The <strong><code>Range</code></strong> interface represents a fragment of a document that can contain nodes and parts of text nodes.</p> <p>A range can be created using the <code>createRange()</code>&nbsp;method of the&nbsp;<code>Document</code>&nbsp;object. Range objects can also be retrieved by using the <code>getRangeAt()</code>&nbsp;method of the&nbsp;<code>Selection</code>&nbsp;object or the <code>caretRangeAtPoint()</code> method of the <code>Document</code> object.</p> <p>There also is the <code>Range()</code> constructor available.</p>  */
public class Range extends jsweet.lang.Object {
    /** 
 Returns a <code>Boolean</code> indicating whether the range's start and end points are at the same position.  */
    public Boolean collapsed;
    /** 
 Returns the deepest&nbsp; <code>Node</code>&nbsp;that contains the <code>startContainer</code> and <code>endContainer</code> nodes.  */
    public Node commonAncestorContainer;
    /** 
 Returns the&nbsp; <code>Node</code>&nbsp;within which the <code>Range</code> ends.  */
    public Node endContainer;
    /** 
 Returns a number representing where in the <code>endContainer</code> the <code>Range</code> ends.  */
    public double endOffset;
    /** 
 Returns the&nbsp; <code>Node</code>&nbsp;within which the <code>Range</code> starts.  */
    public Node startContainer;
    /** 
 Returns a number representing where in the <code>startContainer</code> the <code>Range</code> starts.  */
    public double startOffset;
    /** 
 Returns a&nbsp; <code>DocumentFragment</code>&nbsp;copying the nodes of a <code>Range</code>.  */
    native public DocumentFragment cloneContents();
    /** 
 Returns a <code>Range</code> object with boundary points identical to the cloned <code>Range</code>.  */
    native public Range cloneRange();
    /** 
 Collapses the <code>Range</code> to one of its boundary points.  */
    native public void collapse(Boolean toStart);
    /** 
 Compares the boundary points of the <code>Range</code> with another <code>Range</code>.  */
    native public double compareBoundaryPoints(double how, Range sourceRange);
    /** 
 Returns a&nbsp; <code>DocumentFragment</code>&nbsp;created from a given string of code.  */
    native public DocumentFragment createContextualFragment(String fragment);
    /** 
 Removes the contents of a <code>Range</code> from the <code>Document</code>.  */
    native public void deleteContents();
    /** 
 Releases the <code>Range</code> from use to improve performance.  */
    native public void detach();
    native public Boolean expand(String Unit);
    /** 
 Moves contents of a <code>Range</code> from the document tree into a&nbsp; <code>DocumentFragment</code>.  */
    native public DocumentFragment extractContents();
    /** 
 Returns a <code>ClientRect</code> object which bounds the entire contents of the <code>Range</code>; this would be the union of all the rectangles returned by <code>range.getClientRects()</code>.  */
    native public ClientRect getBoundingClientRect();
    /** 
 Returns a list of <code>ClientRect</code> objects that aggregates the results of <code>Element.getClientRects()</code> for all the elements in the <code>Range</code>.  */
    native public ClientRectList getClientRects();
    /** 
 Insert a&nbsp; <code>Node</code>&nbsp;at the start of a <code>Range</code>.  */
    native public void insertNode(Node newNode);
    /** 
 Sets the <code>Range</code> to contain the&nbsp; <code>Node</code>&nbsp;and its contents.  */
    native public void selectNode(Node refNode);
    /** 
 Sets the <code>Range</code> to contain the contents of a&nbsp; <code>Node</code>.  */
    native public void selectNodeContents(Node refNode);
    /** 
 Sets the end position of a <code>Range</code>.  */
    native public void setEnd(Node refNode, double offset);
    /** 
 Sets the end position of a <code>Range</code> relative to another&nbsp; <code>Node</code>.  */
    native public void setEndAfter(Node refNode);
    /** 
 Sets the end position of a <code>Range</code> relative to another&nbsp; <code>Node</code>.  */
    native public void setEndBefore(Node refNode);
    /** 
 Sets the start position of a <code>Range</code>.  */
    native public void setStart(Node refNode, double offset);
    /** 
 Sets the start position of a <code>Range</code> relative to another&nbsp; <code>Node</code>.  */
    native public void setStartAfter(Node refNode);
    /** 
 Sets the start position of a <code>Range</code> relative to another&nbsp; <code>Node</code>.  */
    native public void setStartBefore(Node refNode);
    /** 
 Moves content of a <code>Range</code> into a new&nbsp; <code>Node</code>.  */
    native public void surroundContents(Node newParent);
    /** 
 Returns the text of the <code>Range</code>.  */
    native public String toString();
    public double END_TO_END;
    public double END_TO_START;
    public double START_TO_END;
    public double START_TO_START;
    public static Range prototype;
    public Range(){}
}

