package jsweet.dom;
/** <p>The <strong><code>TextMetrics</code></strong> interface represents the dimension of a text in the canvas, as created by the <code>CanvasRenderingContext2D.measureText()</code> method.</p>  */
public class TextMetrics extends jsweet.lang.Object {
    /** 
 Is a <code>double</code> giving the calculated width of a segment of inline text in CSS pixels. It takes into account the current font of the context.  */
    public double width;
    public static TextMetrics prototype;
    public TextMetrics(){}
}

