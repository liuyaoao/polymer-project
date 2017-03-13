package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <code>DeviceOrientationEvent</code> provides web developers with information from the physical orientation of the device running the web page.</p> <div> <p><strong>Warning:</strong> Currently, Firefox and Chrome does not handle the coordinates the same way. Take care about this while using them.</p> </div>  */
public class DeviceOrientationEvent extends Event {
    /** 
 A boolean that indicates whether or not the device is providing orientation data absolutely.  */
    public Boolean absolute;
    /** 
 A number representing the motion of the device around the z axis, express in degrees with values ranging from 0 to 360  */
    public double alpha;
    /** 
 A number representing the motion of the device around the x axis, express in degrees with values ranging from -180 to 180. This represents a front to back motion of the device.  */
    public double beta;
    /** 
 A number representing the motion of the device around the y axis, express in degrees with values ranging from -90 to 90. This represents a left to right motion of the device.  */
    public double gamma;
    native public void initDeviceOrientationEvent(String type, Boolean bubbles, Boolean cancelable, double alpha, double beta, double gamma, Boolean absolute);
    public static DeviceOrientationEvent prototype;
    public DeviceOrientationEvent(){}
}

