package jsweet.dom;
/** <p>The <strong><code>HTMLOListElement</code></strong> interface provides special properties (beyond those defined on the regular <code>HTMLElement</code> interface it also has available to it by inheritance) for manipulating ordered list elements.</p>  */
public class HTMLOListElement extends HTMLElement {
    /** 
 Is a <code>Boolean</code> indicating that spacing between list items should be reduced. This property reflects the <code>compact</code> attribute only, it doesn't consider the <code>line-height</code> CSS property used for that behavior in modern pages.  */
    public Boolean compact;
    /**
      * The starting number.
      */
    public double start;
    /** 
 Is a <code>DOMString</code> value reflecting the <code>type</code> and defining the kind of marker to be used to display. It can have the following values: <ul> <li><code>'1'</code> meaning that decimal numbers are used: <code>1</code>, <code>2</code>, <code>3</code>, <code>4</code>, <code>5</code>, …</li> <li><code>'a'</code> meaning that the lowercase latin alphabet is used:&nbsp; <code>a</code>, <code>b</code>, <code>c</code>, <code>d</code>, <code>e</code>, …</li> <li><code>'A'</code> meaning that the uppercase latin alphabet is used: <code>A</code>, <code>B</code>, <code>C</code>, <code>D</code>, <code>E</code>, …</li> <li><code>'i'</code> meaning that the lowercase latin numerals are used: <code>i</code>, <code>ii</code>, <code>iii</code>, <code>iv</code>, <code>v</code>, …</li> <li><code>'I'</code> meaning that the uppercase latin numerals are used: <code>I</code>, <code>II</code>, <code>III</code>, <code>IV</code>, <code>V</code>, …</li> </ul>  */
    public String type;
    public static HTMLOListElement prototype;
    public HTMLOListElement(){}
}

