package jsweet.dom;
/** <div> <p><strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div>  */
public class DeviceMotionEvent extends Event {
    /** 
 An object giving the acceleration of the device on the three axis X, Y and Z. Acceleration is expressed in m/s<sup>2</sup>.  */
    public DeviceAcceleration acceleration;
    /** 
 An object giving the acceleration of the device on the three axis X, Y and Z with the effect of gravity. Acceleration is expressed in m/s<sup>2</sup>.  */
    public DeviceAcceleration accelerationIncludingGravity;
    /** 
 A number representing the interval of time, in milliseconds, at which data is obtained from the device.  */
    public double interval;
    /** 
 An object giving the rate of change of the device's orientation on the three orientation axis alpha, beta and gamma. Rotation rate is express in degrees per seconds.  */
    public DeviceRotationRate rotationRate;
    native public void initDeviceMotionEvent(String type, Boolean bubbles, Boolean cancelable, DeviceAccelerationDict acceleration, DeviceAccelerationDict accelerationIncludingGravity, DeviceRotationRateDict rotationRate, double interval);
    public static DeviceMotionEvent prototype;
    public DeviceMotionEvent(){}
}

