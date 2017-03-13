package jsweet.dom;
/** <p>The <code>SVGStylable</code> interface is implemented on all objects corresponding to SVG elements that can have <code>style</code>, <code>class</code> and presentation attributes specified on them.</p>  */
@jsweet.lang.Interface
public abstract class SVGStylable extends jsweet.lang.Object {
    /** 
Corresponds to attribute <code>class</code> on the given element. */
    public Object className;
    /** 
Corresponds to attribute <code>style</code> on the given element. */
    public CSSStyleDeclaration style;
}

