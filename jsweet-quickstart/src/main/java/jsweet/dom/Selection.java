package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> */
public class Selection extends jsweet.lang.Object {
    /** 
 Returns the <code>Node</code> in which the selection begins.  */
    public Node anchorNode;
    /** 
 Returns a number representing the offset of the selection's anchor within the anchorNode. If anchorNode is a text node, this is the number of characters within anchorNode preceding the anchor. If anchorNode is an element, this is the number of child nodes of the anchorNode preceding the anchor.  */
    public double anchorOffset;
    /** 
 Returns the <code>Node</code> in which the selection ends.  */
    public Node focusNode;
    /** 
 Returns a number representing the offset of the selection's anchor within the focusNode. If focusNode is a text node, this is the number of characters within focusNode preceding the focus. If focusNode is an element, this is the number of child nodes of the focusNode preceding the focus.  */
    public double focusOffset;
    /** 
 Returns a Boolean indicating whether the selection's start and end points are at the same position.  */
    public Boolean isCollapsed;
    /** 
 Returns the number of ranges in the selection.  */
    public double rangeCount;
    public String type;
    /** 
 A <code>Range</code> object that will be added to the selection.  */
    native public void addRange(Range range);
    /** 
 Collapses the current selection to a single point.  */
    native public void collapse(Node parentNode, double offset);
    /** 
 Collapses the selection to the end of the last range in the selection.  */
    native public void collapseToEnd();
    /** 
 Collapses the selection to the start of the first range in the selection.  */
    native public void collapseToStart();
    /** 
 Indicates if a certain node is part of the selection.  */
    native public Boolean containsNode(Node node, Boolean partlyContained);
    /** 
 Deletes the selection's content from the document.  */
    native public void deleteFromDocument();
    native public void empty();
    /** 
 Moves the focus of the selection to a specified point.  */
    native public void extend(Node newNode, double offset);
    /** 
 Returns a <code>Range</code> object representing one of the ranges currently selected.  */
    native public Range getRangeAt(double index);
    /** 
 Removes all ranges from the selection.  */
    native public void removeAllRanges();
    /** 
 Removes a range from the selection.  */
    native public void removeRange(Range range);
    /** 
 Adds all the children of the specified node to the selection.  */
    native public void selectAllChildren(Node parentNode);
    native public void setBaseAndExtent(Node baseNode, double baseOffset, Node extentNode, double extentOffset);
    /** 
 Returns a string currently being represented by the selection object, i.e. the currently selected text.  */
    native public String toString();
    public static Selection prototype;
    public Selection(){}
}

