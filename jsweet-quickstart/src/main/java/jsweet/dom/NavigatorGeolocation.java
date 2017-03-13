package jsweet.dom;
/** <p><code><strong>NavigatorGeolocation</strong></code> contains a creation method allowing objects implementing it to obtain a <code>Geolocation</code> instance.</p> <p>There is no object of type <code>NavigatorGeolocation</code>, but some interfaces, like <code>Navigator</code> implements it.</p>  */
@jsweet.lang.Interface
public abstract class NavigatorGeolocation extends jsweet.lang.Object {
    /** 
 Returns a <code>Geolocation</code> object allowing accessing the location of the device.  */
    public Geolocation geolocation;
}

