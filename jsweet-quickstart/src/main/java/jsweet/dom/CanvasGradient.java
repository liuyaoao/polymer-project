package jsweet.dom;
/** <p>The <code><strong>CanvasGradient</strong></code> interface represents an opaque object describing a gradient. It is returned by the methods <code>CanvasRenderingContext2D.createLinearGradient()</code> or <code>CanvasRenderingContext2D.createRadialGradient()</code>.</p>  */
public class CanvasGradient extends jsweet.lang.Object {
    /** 
 Adds a new stop, defined by an <code>offset</code> and a <code>color</code>, to the gradient. If the offset is not between <code>0</code> and <code>1</code> an <code>INDEX_SIZE_ERR</code> is raised, if the color can't be parsed as a CSS <code>&lt;color&gt;</code>, a <code>SYNTAX_ERR</code> is raised.  */
    native public void addColorStop(double offset, String color);
    public static CanvasGradient prototype;
    public CanvasGradient(){}
}

