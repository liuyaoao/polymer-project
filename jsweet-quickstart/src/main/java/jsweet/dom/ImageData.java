package jsweet.dom;
import jsweet.lang.Uint8ClampedArray;
/** <p>The <code><strong>ImageData</strong></code> interface represents the underlying pixel data of an area of a <code>&lt;canvas&gt;</code> element. It is created using the <code>ImageData()</code> constructor or creator methods on the <code>CanvasRenderingContext2D</code> object associated with a canvas: <code>createImageData()</code> and <code>getImageData()</code>. It can also be used to set a part of the canvas by using <code>putImageData()</code>.</p>  */
public class ImageData extends jsweet.lang.Object {
    /** 
 Is a <code>Uint8ClampedArray</code> representing a one-dimensional array containing the data in the RGBA order, with integer values between <code>0</code> and <code>255</code> (included).  */
    public Uint8ClampedArray data;
    /** 
 Is an <code>unsigned</code> <code>long</code> representing the actual height, in pixels, of the <code>ImageData</code>.  */
    public double height;
    /** 
 Is an <code>unsigned</code> <code>long</code> representing the actual width, in pixels, of the <code>ImageData</code>.  */
    public double width;
    public static ImageData prototype;
    public ImageData(double width, double height){}
    public ImageData(Uint8ClampedArray array, double width, double height){}
    protected ImageData(){}
}

