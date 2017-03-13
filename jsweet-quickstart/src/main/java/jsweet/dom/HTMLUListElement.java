package jsweet.dom;
/** <p>The <strong><code>HTMLUListElement</code></strong> interface provides special properties (beyond those defined on the regular <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating unordered list elements.</p>  */
public class HTMLUListElement extends HTMLElement {
    /** 
 Is a <code>Boolean</code> indicating that spacing between list items should be reduced. This property reflects the <code>compact</code> attribute only, it doesn't consider the <code>line-height</code> CSS property used for that behavior in modern pages.  */
    public Boolean compact;
    /** 
 Is a <code>DOMString</code> value reflecting the <code>type</code> and defining the kind of marker to be used to display. The values are browser dependent and have never been standardized.  */
    public String type;
    public static HTMLUListElement prototype;
    public HTMLUListElement(){}
}

