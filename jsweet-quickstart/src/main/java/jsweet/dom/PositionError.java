package jsweet.dom;
/** <p>The <strong><code>PositionError</code></strong> interface represents the reason of an error occurring when using the geolocating device.</p>  */
public class PositionError extends jsweet.lang.Object {
    /** 
 Returns an <code>unsigned short</code> representing the error code. The following values are possible: <table> <tbody> <tr> <th>Value</th> <th>Associated constant</th> <th>Description</th> </tr> <tr> <td><code>1</code></td> <td><code>PERMISSION_DENIED</code></td> <td>The acquisition of the geolocation information failed because the page didn't have the permission to do it.</td> </tr> <tr> <td><code>2</code></td> <td><code>POSITION_UNAVAILABLE</code></td> <td>The acquisition of the geolocation failed because at least one internal source of position returned an internal error.</td> </tr> <tr> <td><code>3</code></td> <td><code>TIMEOUT</code></td> <td>The time allowed to acquire&nbsp;the geolocation, defined by <code>PositionOptions.timeout</code> information was reached before the information was obtained.</td> </tr> </tbody> </table>  */
    public double code;
    /** 
 Returns a human-readable <code>DOMString</code> describing the details of the error. Specifications note that this is primarily intended for debugging use and not to be shown directly in a user interface.  */
    public String message;
    native public String toString();
    public double PERMISSION_DENIED;
    public double POSITION_UNAVAILABLE;
    public double TIMEOUT;
    public static PositionError prototype;
    public PositionError(){}
}

