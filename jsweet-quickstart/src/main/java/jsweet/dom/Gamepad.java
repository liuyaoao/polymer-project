package jsweet.dom;
/**  <p>The <strong><code>Gamepad</code></strong> interface of the Gamepad API defines an individual gamepad or other controller, allowing access to information such as button presses, axis positions, and id.</p> <p>A Gamepad object can be returned in one of two ways: via the <code>gamepad</code> property of the <code>gamepadconnected</code> and <code>gamepaddisconnected</code> events, or by grabbing any position in the array returned by the <code>Navigator.getGamepads()</code> method.</p>  */
public class Gamepad extends jsweet.lang.Object {
    /** 
 An array representing the controls with axes present on the device (e.g. analog thumb sticks).  */
    public double[] axes;
    /** 
 An array of <code>gamepadButton</code> objects representing the buttons present on the device.  */
    public GamepadButton[] buttons;
    /** 
 A boolean indicating whether the gamepad is still connected to the system.  */
    public Boolean connected;
    /** 
 A <code>DOMString</code> containing identifying information about the controller.  */
    public String id;
    /** 
 An integer that is auto-incremented to be unique for each device currently connected to the system.  */
    public double index;
    /** 
 A string indicating whether the browser has remapped the controls on the device to a known layout.  */
    public String mapping;
    /** 
 A <code>DOMHighResTimeStamp</code> representing the last time the data for this gamepad was updated. Note that this property is not currently supported anywhere.  */
    public double timestamp;
    public static Gamepad prototype;
    public Gamepad(){}
}

