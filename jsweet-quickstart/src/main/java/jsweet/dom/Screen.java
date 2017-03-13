package jsweet.dom;
/** <p>The <code>Screen</code> interface represents a screen, usually the one on which the current window is being rendered.</p> <p>Usually it is the one on which the current window is being rendered, obtained using <code>window.screen</code>.</p>  */
public class Screen extends EventTarget {
    /** 
 Specifies the height of the screen, in pixels, minus permanent or semipermanent user interface features displayed by the operating system, such as the Taskbar on Windows.  */
    public double availHeight;
    /** 
 Returns the amount of horizontal space in pixels available to the window.  */
    public double availWidth;
    public double bufferDepth;
    /** 
 Returns the color depth of the screen.  */
    public double colorDepth;
    public double deviceXDPI;
    public double deviceYDPI;
    public Boolean fontSmoothingEnabled;
    /** 
 Returns the height of the screen in pixels.  */
    public double height;
    public double logicalXDPI;
    public double logicalYDPI;
    public String msOrientation;
    public java.util.function.Function<Event,Object> onmsorientationchange;
    /** 
 Gets the bit depth of the screen.  */
    public double pixelDepth;
    public double systemXDPI;
    public double systemYDPI;
    /** 
 Returns the width of the screen.  */
    public double width;
    native public Boolean msLockOrientation(String orientations);
    native public void msUnlockOrientation();
    native public void addEventListener(jsweet.util.StringTypes.MSOrientationChange type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static Screen prototype;
    public Screen(){}
    native public void addEventListener(jsweet.util.StringTypes.MSOrientationChange type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public Boolean msLockOrientation(String[] orientations);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

