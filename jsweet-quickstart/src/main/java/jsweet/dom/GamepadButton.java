package jsweet.dom;
/** <p>The <strong><code>GamepadButton</code></strong> interface defines an individual button of a gamepad or other controller, allowing access to the current state of different types of buttons available on the control device.</p> <p>A <code>GamepadButton</code> object is returned by querying any value of the array returned by the <code>buttons</code> property of the <code>Gamepad</code> interface.</p> <div> <p><strong>Note</strong>: This is the case in Firefox Gecko 28 and later; Chrome and earlier Firefox versions still return an array of double values when this property is accessed.</p> </div>  */
public class GamepadButton extends jsweet.lang.Object {
    /** 
 A boolean value indicating whether the button is currently pressed ( <code>true</code>) or unpressed ( <code>false</code>).  */
    public Boolean pressed;
    /** 
 A double value used to represent the current state of analog buttons, such as the triggers on many modern gamepads. The values are normalized to the range 0.0 —1.0, with 0.0 representing a button that is not pressed, and 1.0 representing a button that is fully pressed.  */
    public double value;
    public static GamepadButton prototype;
    public GamepadButton(){}
}

