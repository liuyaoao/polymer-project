package jsweet.dom;
/** <p>The <strong><code>Coordinates</code></strong> interface represents the position and altitude of the device on Earth, as well as the accuracy with which these properties are calculated.</p>  */
public class Coordinates extends jsweet.lang.Object {
    /** 
 Returns a <code>double</code> representing the accuracy of the <code>latitude</code> and <code>longitude</code> properties, expressed in meters.  */
    public double accuracy;
    /** 
 Returns a <code>double</code> representing the position's altitude in metres, relative to sea level. This value can be <code>null</code>&nbsp;if the implementation cannot provide the data.  */
    public double altitude;
    /** 
 Returns a <code>double</code> representing the accuracy of the <code>altitude</code> expressed in meters. This value can be <code>null</code>.  */
    public double altitudeAccuracy;
    /** 
 Returns a <code>double</code> representing the direction in which the device is traveling. This value, specified in degrees, indicates how far off from heading due north the device is. <code>0</code> degrees represents true true north, and the direction is determined clockwise (which means that east is <code>90</code> degrees and west is <code>270</code> degrees). If <code>speed</code> is <code>0</code>, <code>heading</code> is <code>NaN</code>. If the device is unable to provide <code>heading</code> information, this value is <code>null</code>.  */
    public double heading;
    /** 
 Returns a <code>double</code> representing the position's latitude in decimal degrees.  */
    public double latitude;
    /** 
 Returns a <code>double</code> representing the position's longitude in decimal degrees.  */
    public double longitude;
    /** 
 Returns a <code>double</code> representing the velocity of the device in meters per second. This value can be <code>null</code>.  */
    public double speed;
    public static Coordinates prototype;
    public Coordinates(){}
}

