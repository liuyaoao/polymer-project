package jsweet.dom;
/** <p>The <strong><code>PositionOptions</code></strong> interface describes an object containing option properties to pass as a parameter of <code>Geolocation.getCurrentPosition()</code> and <code>Geolocation.watchPosition()</code>.</p>  */
@jsweet.lang.Interface
public abstract class PositionOptions extends jsweet.lang.Object {
    /** 
 Is a <code>Boolean</code> that indicates the application would like to receive the best possible results. If <code>true</code> and if the device is able to provide a more accurate position, it will do so. Note that this can result in slower response times or increased power consumption (with a GPS chip on a mobile device for example). On the other hand, if <code>false</code>, the device can take the liberty to save resources by responding more quickly and/or using less power. Default: <code>false</code>.  */
    @jsweet.lang.Optional
    public Boolean enableHighAccuracy;
    /** 
 Is a positive <code>long</code> value representing the maximum length of time (in milliseconds) the device is allowed to take in order to return a position. The default value is <code>Infinity</code>, meaning that <code>getCurrentPosition()</code> won't return until the position is available.  */
    @jsweet.lang.Optional
    public double timeout;
    /** 
 Is a positive <code>long</code> value indicating the maximum age in milliseconds of a possible cached position that is acceptable to return. If set to <code>0</code>, it means that the device cannot use a cached position and must attempt to retrieve the real current position. If set to <code>Infinity</code> the device must return a cached position regardless of its age. Default: 0.  */
    @jsweet.lang.Optional
    public double maximumAge;
}

