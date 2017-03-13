package jsweet.dom;
import jsweet.util.union.Union3;
/** <p>The <code><strong>CanvasRenderingContext2D</strong></code> interface provides the 2D rendering context for the drawing surface of a <code>&lt;canvas&gt;</code> element.</p> <p>To get an object of this interface, call <code>getContext()</code> on a <code>&lt;canvas&gt;</code>, supplying &quot;2d&quot; as the argument:</p> <pre>var canvas = document.getElementById('mycanvas');
var ctx = canvas.getContext('2d');
</pre> <p>Once you have the 2D rendering context for a canvas, you can draw within it. For example:</p> <pre>ctx.fillStyle = &quot;rgb(200,0,0)&quot;;  
ctx.fillRect(10, 10, 55, 50);  
</pre> <p>See the properties and methods in the sidebar and below. The canvas tutorial has more information, examples, and resources as well.</p>  */
public class CanvasRenderingContext2D extends jsweet.lang.Object {
    /** 
 A read-only back-reference to the <code>HTMLCanvasElement</code>. Might be <code>null</code> if it is not associated with a <code>&lt;canvas&gt;</code> element.  */
    public HTMLCanvasElement canvas;
    /** 
 Color or style to use inside shapes. Default <code>#000</code> (black).  */
    public Union3<String,CanvasGradient,CanvasPattern> fillStyle;
    /** 
 Font setting. Default value <code>10px sans-serif</code>.  */
    public String font;
    /** 
 Alpha value that is applied to shapes and images before they are composited onto the canvas. Default <code>1.0</code> (opaque).  */
    public double globalAlpha;
    /** 
 With <code>globalAlpha</code> applied this sets how shapes and images are drawn onto the existing bitmap.  */
    public String globalCompositeOperation;
    /** 
 Type of endings on the end of lines. Possible values: <code>butt</code> (default), <code>round</code>, <code>square</code>.  */
    public String lineCap;
    /** 
 Specifies where to start a dash array on a line.  */
    public double lineDashOffset;
    /** 
 Defines the type of corners where two lines meet. Possible values: <code>round</code>, <code>bevel</code>, <code>miter</code> (default).  */
    public String lineJoin;
    /** 
 Width of lines. Default <code>1.0</code>  */
    public double lineWidth;
    /** 
 Miter limit ratio. Default <code>10</code>.  */
    public double miterLimit;
    /** 
 The fill rule to use. This must be one of <code>evenodd</code> or <code>nonzero</code> (default).  */
    public String msFillRule;
    public Boolean msImageSmoothingEnabled;
    /** 
 Specifies the blurring effect. Default <code>0</code>  */
    public double shadowBlur;
    /** 
 Color of the shadow. Default fully-transparent black.  */
    public String shadowColor;
    /** 
 Horizontal distance the shadow will be offset. Default 0.  */
    public double shadowOffsetX;
    /** 
 Vertical distance the shadow will be offset. Default 0.  */
    public double shadowOffsetY;
    /** 
 Color or style to use for the lines around shapes. Default <code>#000</code> (black).  */
    public Union3<String,CanvasGradient,CanvasPattern> strokeStyle;
    /** 
 Text alignment setting. Possible values: <code>start</code> (default), <code>end</code>, <code>left</code>, <code>right</code> or <code>center</code>.  */
    public String textAlign;
    /** 
 Baseline alignment setting. Possible values: <code>top</code>, <code>hanging</code>, <code>middle</code>, <code>alphabetic</code> (default), <code>ideographic</code>, <code>bottom</code>.  */
    public String textBaseline;
    /** 
 Adds an arc to the path which is centered at <em>(x, y)</em> position with radius <em> r</em> starting at <em>startAngle</em> and ending at <em>endAngle</em> going in the given direction by <em>anticlockwise</em> (defaulting to clockwise).  */
    native public void arc(double x, double y, double radius, double startAngle, double endAngle, Boolean anticlockwise);
    /** 
 Adds an arc to the path with the given control points and radius, connected to the previous point by a straight line.  */
    native public void arcTo(double x1, double y1, double x2, double y2, double radius);
    /** 
 Starts a new path by emptying the list of sub-paths. Call this method when you want to create a new path.  */
    native public void beginPath();
    /** 
 Adds a cubic B&eacute;zier curve to the path. It requires three points. The first two points are control points and the third one is the end point. The starting point is the last point in the current path, which can be changed using <code>moveTo()</code> before creating the B&eacute;zier curve.  */
    native public void bezierCurveTo(double cp1x, double cp1y, double cp2x, double cp2y, double x, double y);
    /** 
 Sets all pixels in the rectangle defined by starting point&nbsp; <em>(x, y)</em>&nbsp;and size <em>(width, height)</em>&nbsp;to transparent black, erasing any previously drawn content.  */
    native public void clearRect(double x, double y, double w, double h);
    /** 
 Creates a clipping path from the current sub-paths. Everything drawn after <code>clip()</code> is called appears inside the clipping path only. For an example, see Clipping paths in the Canvas tutorial.  */
    native public void clip(String fillRule);
    /** 
 Causes the point of the pen to move back to the start of the current sub-path. It tries to draw a straight line from the current point to the start. If the shape has already been closed or has only one point, this function does nothing.  */
    native public void closePath();
    /** 
 Creates a new, blank <code>ImageData</code> object with the specified dimensions. All of the pixels in the new object are transparent black.  */
    native public ImageData createImageData(double imageDataOrSw, double sh);
    /** 
 Creates a linear gradient along the line given by the coordinates represented by the parameters.  */
    native public CanvasGradient createLinearGradient(double x0, double y0, double x1, double y1);
    /** 
 Creates a pattern using the specified image (a <code>CanvasImageSource</code>). It repeats the source in the directions specified by the repetition argument. This method returns a <code>CanvasPattern</code>.  */
    native public CanvasPattern createPattern(HTMLImageElement image, String repetition);
    /** 
 Creates a radial gradient given by the coordinates of the two circles represented by the parameters.  */
    native public CanvasGradient createRadialGradient(double x0, double y0, double r0, double x1, double y1, double r1);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLImageElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX, double canvasOffsetY, double canvasImageWidth, double canvasImageHeight);
    /** 
 Fills the subpaths with the current fill style.  */
    native public void fill(String fillRule);
    /** 
 Draws a filled rectangle at <em>(x, y) </em>position whose size is determined by <em>width</em> and <em>height</em>.  */
    native public void fillRect(double x, double y, double w, double h);
    /** 
 Draws (fills) a given text at the given (x,y) position.  */
    native public void fillText(String text, double x, double y, double maxWidth);
    /** 
 Returns an <code>ImageData</code> object representing the underlying pixel data for the area of the canvas denoted by the rectangle which starts at <em>(sx, sy)</em> and has an <em>sw</em> width and <em>sh</em> height.  */
    native public ImageData getImageData(double sx, double sy, double sw, double sh);
    /** 
 Returns the current line dash pattern array containing an even number of non-negative numbers.  */
    native public double[] getLineDash();
    /** 
 Reports whether or not the specified point is contained in the current path.  */
    native public Boolean isPointInPath(double x, double y, String fillRule);
    /** 
 Connects the last point in the subpath to the <code>x, y</code> coordinates with a straight line.  */
    native public void lineTo(double x, double y);
    /** 
 Returns a <code>TextMetrics</code> object.  */
    native public TextMetrics measureText(String text);
    /** 
 Moves the starting point of a new sub-path to the <strong>(x, y)</strong> coordinates.  */
    native public void moveTo(double x, double y);
    /** 
 Paints data from the given <code>ImageData</code> object onto the bitmap. If a dirty rectangle is provided, only the pixels from that rectangle are painted.  */
    native public void putImageData(ImageData imagedata, double dx, double dy, double dirtyX, double dirtyY, double dirtyWidth, double dirtyHeight);
    /** 
 Adds a quadratic B&eacute;zier curve to the current path.  */
    native public void quadraticCurveTo(double cpx, double cpy, double x, double y);
    /** 
 Creates a path for a rectangle at <em> </em>position <em>(x, y)</em> with a size that is determined by <em>width</em> and <em>height</em>.  */
    native public void rect(double x, double y, double w, double h);
    /** 
 Restores the drawing style state to the last element on the 'state stack' saved by <code>save()</code>.  */
    native public void restore();
    /** 
 Adds a rotation to the transformation matrix. The angle argument represents a clockwise rotation angle and is expressed in radians.  */
    native public void rotate(double angle);
    /** 
 Saves the current drawing style state using a stack so you can revert any change you make to it using <code>restore()</code>.  */
    native public void save();
    /** 
 Adds a scaling transformation to the canvas units by x horizontally and by y vertically.  */
    native public void scale(double x, double y);
    /** 
 Sets the current line dash pattern.  */
    native public void setLineDash(double[] segments);
    /** 
 Resets the current transform to the identity matrix, and then invokes the <code>transform()</code> method with the same arguments.  */
    native public void setTransform(double m11, double m12, double m21, double m22, double dx, double dy);
    /** 
 Strokes the subpaths with the current stroke style.  */
    native public void stroke();
    /** 
 Paints a rectangle which has a starting point at <em>(x, y)</em> and has a <em> w</em> width and an <em>h</em> height onto the canvas, using the current stroke style.  */
    native public void strokeRect(double x, double y, double w, double h);
    /** 
 Draws (strokes) a given text at the given <em>(x, y) </em>position.  */
    native public void strokeText(String text, double x, double y, double maxWidth);
    /** 
 Multiplies the current transformation matrix with the matrix described by its arguments.  */
    native public void transform(double m11, double m12, double m21, double m22, double dx, double dy);
    /** 
 Adds a translation transformation by moving the canvas and its origin x horzontally and y vertically on the grid.  */
    native public void translate(double x, double y);
    public static CanvasRenderingContext2D prototype;
    public CanvasRenderingContext2D(){}
    /** 
 Adds an arc to the path which is centered at <em>(x, y)</em> position with radius <em> r</em> starting at <em>startAngle</em> and ending at <em>endAngle</em> going in the given direction by <em>anticlockwise</em> (defaulting to clockwise).  */
    native public void arc(double x, double y, double radius, double startAngle, double endAngle);
    /** 
 Creates a clipping path from the current sub-paths. Everything drawn after <code>clip()</code> is called appears inside the clipping path only. For an example, see Clipping paths in the Canvas tutorial.  */
    native public void clip();
    /** 
 Creates a new, blank <code>ImageData</code> object with the specified dimensions. All of the pixels in the new object are transparent black.  */
    native public ImageData createImageData(double imageDataOrSw);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLImageElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX, double canvasOffsetY, double canvasImageWidth);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLImageElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX, double canvasOffsetY);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLImageElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLImageElement image, double offsetX, double offsetY, double width, double height);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLImageElement image, double offsetX, double offsetY, double width);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLImageElement image, double offsetX, double offsetY);
    /** 
 Fills the subpaths with the current fill style.  */
    native public void fill();
    /** 
 Draws (fills) a given text at the given (x,y) position.  */
    native public void fillText(String text, double x, double y);
    /** 
 Reports whether or not the specified point is contained in the current path.  */
    native public Boolean isPointInPath(double x, double y);
    /** 
 Paints data from the given <code>ImageData</code> object onto the bitmap. If a dirty rectangle is provided, only the pixels from that rectangle are painted.  */
    native public void putImageData(ImageData imagedata, double dx, double dy, double dirtyX, double dirtyY, double dirtyWidth);
    /** 
 Paints data from the given <code>ImageData</code> object onto the bitmap. If a dirty rectangle is provided, only the pixels from that rectangle are painted.  */
    native public void putImageData(ImageData imagedata, double dx, double dy, double dirtyX, double dirtyY);
    /** 
 Paints data from the given <code>ImageData</code> object onto the bitmap. If a dirty rectangle is provided, only the pixels from that rectangle are painted.  */
    native public void putImageData(ImageData imagedata, double dx, double dy, double dirtyX);
    /** 
 Paints data from the given <code>ImageData</code> object onto the bitmap. If a dirty rectangle is provided, only the pixels from that rectangle are painted.  */
    native public void putImageData(ImageData imagedata, double dx, double dy);
    /** 
 Draws (strokes) a given text at the given <em>(x, y) </em>position.  */
    native public void strokeText(String text, double x, double y);
    /** 
 Creates a new, blank <code>ImageData</code> object with the specified dimensions. All of the pixels in the new object are transparent black.  */
    native public ImageData createImageData(ImageData imageDataOrSw, double sh);
    /** 
 Creates a pattern using the specified image (a <code>CanvasImageSource</code>). It repeats the source in the directions specified by the repetition argument. This method returns a <code>CanvasPattern</code>.  */
    native public CanvasPattern createPattern(HTMLCanvasElement image, String repetition);
    /** 
 Creates a pattern using the specified image (a <code>CanvasImageSource</code>). It repeats the source in the directions specified by the repetition argument. This method returns a <code>CanvasPattern</code>.  */
    native public CanvasPattern createPattern(HTMLVideoElement image, String repetition);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLVideoElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX, double canvasOffsetY, double canvasImageWidth, double canvasImageHeight);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLCanvasElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX, double canvasOffsetY, double canvasImageWidth, double canvasImageHeight);
    /** 
 Creates a new, blank <code>ImageData</code> object with the specified dimensions. All of the pixels in the new object are transparent black.  */
    native public ImageData createImageData(ImageData imageDataOrSw);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLVideoElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX, double canvasOffsetY, double canvasImageWidth);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLCanvasElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX, double canvasOffsetY, double canvasImageWidth);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLVideoElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX, double canvasOffsetY);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLCanvasElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX, double canvasOffsetY);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLVideoElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLCanvasElement image, double offsetX, double offsetY, double width, double height, double canvasOffsetX);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLVideoElement image, double offsetX, double offsetY, double width, double height);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLCanvasElement image, double offsetX, double offsetY, double width, double height);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLVideoElement image, double offsetX, double offsetY, double width);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLCanvasElement image, double offsetX, double offsetY, double width);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLVideoElement image, double offsetX, double offsetY);
    /** 
 Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.  */
    native public void drawImage(HTMLCanvasElement image, double offsetX, double offsetY);
}

