package jsweet.dom;
/** <p>The <strong><code><span>HTMLCanvasElement</span></code></strong> interface provides properties and methods for manipulating the layout and presentation of canvas elements. The <code>HTMLCanvasElement</code> interface also inherits the properties and methods of the <code>HTMLElement</code> interface.</p>  */
public class HTMLCanvasElement extends HTMLElement {
    /**
      * Gets or sets the height of a canvas element on a document.
      */
    public double height;
    /**
      * Gets or sets the width of a canvas element on a document.
      */
    public double width;
    /**
      * Returns an object that provides methods and properties for drawing and manipulating images and graphics on a canvas element in a document. A context object includes information about colors, line widths, fonts, and other graphic parameters that can be drawn on a canvas.
      * @param contextId The identifier (ID) of the type of canvas to create. Internet Explorer 9 and Internet Explorer 10 support only a 2-D context using canvas.getContext("2d"); IE11 Preview also supports 3-D or WebGL context using canvas.getContext("experimental-webgl");
      */
    native public CanvasRenderingContext2D getContext(jsweet.util.StringTypes._2d contextId);
    /** 
 Returns a drawing context on the canvas, or null if the context ID is not supported. A drawing context lets you draw on the canvas. Calling getContext with <code>&quot;2d&quot;</code> returns a <code>CanvasRenderingContext2D</code> object, whereas calling it with <code>&quot;experimental-webgl&quot;</code> (or <code>&quot;webgl&quot;</code>) returns a <code>WebGLRenderingContext</code> object. This context is only available on browsers that implement WebGL.  */
    native public WebGLRenderingContext getContext(jsweet.util.StringTypes.experimental_webgl contextId);
    /** 
 Returns a drawing context on the canvas, or null if the context ID is not supported. A drawing context lets you draw on the canvas. Calling getContext with <code>&quot;2d&quot;</code> returns a <code>CanvasRenderingContext2D</code> object, whereas calling it with <code>&quot;experimental-webgl&quot;</code> (or <code>&quot;webgl&quot;</code>) returns a <code>WebGLRenderingContext</code> object. This context is only available on browsers that implement WebGL.  */
    native public jsweet.util.union.Union<CanvasRenderingContext2D,WebGLRenderingContext> getContext(String contextId, Object... args);
    /**
      * Returns a blob object encoded as a Portable Network Graphics (PNG) format from a canvas image or drawing.
      */
    native public Blob msToBlob();
    /**
      * Returns the content of the current canvas as an image that you can use as a source for another canvas or an HTML element.
      * @param type The standard MIME type for the image format to return. If you do not specify this parameter, the default value is a PNG format image.
      */
    native public String toDataURL(String type, Object... args);
    /** 
 Creates a <code>Blob</code> object representing the image contained in the canvas; this file may be cached on the disk or stored in memory at the discretion of the user agent.  */
    native public Blob toBlob();
    public static HTMLCanvasElement prototype;
    public HTMLCanvasElement(){}
    /**
      * Returns the content of the current canvas as an image that you can use as a source for another canvas or an HTML element.
      * @param type The standard MIME type for the image format to return. If you do not specify this parameter, the default value is a PNG format image.
      */
    native public String toDataURL();
}

