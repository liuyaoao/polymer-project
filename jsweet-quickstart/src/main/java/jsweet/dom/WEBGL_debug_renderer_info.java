package jsweet.dom;
/** <p>The <code><strong>WEBGL_debug_renderer_info</strong></code> extension is part of the WebGL API and exposes two constants with information about the graphics driver for debugging purposes.</p> <p>Depending on the privacy settings of the browser, this extension might only be available to privileged contexts. Generally, the graphics driver information should only be used in edge cases to optimize your WebGL content or to debug GPU problems. The <code>WebGLRenderingContext.getParameter()</code> method can help you to detect which features are supported and the <code>failIfMajorPerformanceCaveat</code> context attribute lets you control if a context should be returned at all, if the performance would be dramatically slow.</p> <p>WebGL extensions are available using the <code>WebGLRenderingContext.getExtension()</code> method. For more information, see also Using Extensions in the WebGL tutorial.</p>  */
public class WEBGL_debug_renderer_info extends jsweet.lang.Object {
    public double UNMASKED_RENDERER_WEBGL;
    public double UNMASKED_VENDOR_WEBGL;
    public static WEBGL_debug_renderer_info prototype;
    public WEBGL_debug_renderer_info(){}
}

