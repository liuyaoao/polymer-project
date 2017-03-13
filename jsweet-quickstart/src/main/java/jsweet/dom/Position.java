package jsweet.dom;
/** <p>The <strong><code>Position</code></strong> interface represents the position of the concerned device at a given time. The position, represented by a <code>Coordinates</code> object, comprehends the 2D position of the device, on a spheroid representing the Earth, but also its altitude and its speed.</p>  */
public class Position extends jsweet.lang.Object {
    /** 
 Returns a <code>Coordinates</code> object defining the current location.  */
    public Coordinates coords;
    /** 
 Returns a <code>DOMTimeStamp</code> representing the time at which the location was retrieved.  */
    public double timestamp;
    public static Position prototype;
    public Position(){}
}

