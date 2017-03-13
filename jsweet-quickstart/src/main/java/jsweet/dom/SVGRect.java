package jsweet.dom;
/** <p>The <code>SVGRect</code> represents rectangular geometry. Rectangles are defined as consisting of a (x,y) coordinate pair identifying a minimum X value, a minimum Y value, and a width and height, which are usually constrained to be non-negative.</p> <p>An <code>SVGRect</code> object can be designated as read only, which means that attempts to modify the object will result in an exception being thrown.</p>  */
public class SVGRect extends jsweet.lang.Object {
    /** 
The <em>height</em> coordinate of the rectangle, in user units. */
    public double height;
    /** 
The <em>width</em> coordinate of the rectangle, in user units. */
    public double width;
    /** 
The <em>x</em> coordinate of the rectangle, in user units. */
    public double x;
    /** 
The <em>y</em> coordinate of the rectangle, in user units. */
    public double y;
    public static SVGRect prototype;
    public SVGRect(){}
}

