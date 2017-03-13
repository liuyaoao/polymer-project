package jsweet.dom;
/** <p>The <code><strong>Geolocation</strong></code> interface represents an object able to programmatically obtain the position of the device. It gives Web content access to the location of the device. This allows a Web site or app to offer customized results based on the user's location.</p> <p>An object with this interface is obtained using the <code>NavigatorGeolocation.geolocation</code> property implemented by the <code>Navigator</code> object.</p> <div> <p><strong>Note:</strong> For security reasons, when a web page tries to access location information, the user is notified and asked to grant permission. Be aware that each browser has its own policies and methods for requesting this permission.</p> </div>  */
public class Geolocation extends jsweet.lang.Object {
    /** 
 Removes the particular handler previously installed using <code>watchPosition()</code>.  */
    native public void clearWatch(double watchId);
    /** 
 Determines the device's current location and gives back a <code>Position</code> object with the data.  */
    native public void getCurrentPosition(PositionCallback successCallback, PositionErrorCallback errorCallback, PositionOptions options);
    /** 
 Returns a <code>long</code> value representing the newly established callback function to be invoked whenever the device location changes.  */
    native public double watchPosition(PositionCallback successCallback, PositionErrorCallback errorCallback, PositionOptions options);
    public static Geolocation prototype;
    public Geolocation(){}
    /** 
 Determines the device's current location and gives back a <code>Position</code> object with the data.  */
    native public void getCurrentPosition(PositionCallback successCallback, PositionErrorCallback errorCallback);
    /** 
 Determines the device's current location and gives back a <code>Position</code> object with the data.  */
    native public void getCurrentPosition(PositionCallback successCallback);
    /** 
 Returns a <code>long</code> value representing the newly established callback function to be invoked whenever the device location changes.  */
    native public double watchPosition(PositionCallback successCallback, PositionErrorCallback errorCallback);
    /** 
 Returns a <code>long</code> value representing the newly established callback function to be invoked whenever the device location changes.  */
    native public double watchPosition(PositionCallback successCallback);
}

