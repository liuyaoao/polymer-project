package jsweet.dom;
/**  <p>The GamepadEvent interface of the Gamepad API contains references to gamepads connected to the system, which is what the gamepad events <code>Window.gamepadconnected</code> and <code>Window.gamepaddisconnected</code> are fired in response to.</p> <div> <p><strong>Note</strong>: These events are not fired in Chrome, only Firefox. In Chrome you have to use <code>Navigator.getGamepads()</code> to access <code>Gamepad</code> objects.</p> </div>  */
public class GamepadEvent extends Event {
    /** 
 Returns a <code>Gamepad</code> object, providing access to the associated gamepad data for the event fired.  */
    public Gamepad gamepad;
    public static GamepadEvent prototype;
    public GamepadEvent(){}
}

