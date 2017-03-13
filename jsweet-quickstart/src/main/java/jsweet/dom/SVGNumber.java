package jsweet.dom;
/** <p>The <code>SVGNumber</code> interface correspond to the &lt;number&gt; basic data type.</p> <p>An <code>SVGNumber</code> object can be designated as read only, which means that attempts to modify the object will result in an exception being thrown.</p>  */
public class SVGNumber extends jsweet.lang.Object {
    /** <p>The value of the given attribute.</p> <p><strong>Exceptions on setting:</strong> a <code>DOMException</code> with code <code>NO_MODIFICATION_ALLOWED_ERR</code> is Raised on an attempt to change the value of a read only attribute.</p>  */
    public double value;
    public static SVGNumber prototype;
    public SVGNumber(){}
}

