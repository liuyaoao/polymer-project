package jsweet.dom;
/**  <p><strong><code>KeyboardEvent</code></strong> objects describe a user interaction with the keyboard. Each event describes a key; the event type (<code>keydown</code>, <code>keypress</code>, or <code>keyup</code>) identifies what kind of activity was performed.</p> <div> <strong>Note:</strong> The <code>KeyboardEvent</code> indicates just what's happening on a key. When you need to handle text input, use HTML5 <code>input</code> event instead. For example, if user inputs text from hand-writing system like tablet PC, key events may not be fired. </div>  */
public class KeyboardEvent extends UIEvent {
    /** 
 Returns a <code>Boolean</code> that is <code>true</code> if the <kbd>Alt</kbd> ( <kbd>Option</kbd> or <kbd>⌥</kbd> on OS X) key was active when the key event was generated.  */
    public Boolean altKey;
    @jsweet.lang.Name("char")
    public String Char;
    /** 
 Returns a&nbsp; <code>Number</code> representing the Unicode reference number of the key; this attribute is used only by the <code>keypress</code> event. For keys whose <code>char</code> attribute contains multiple characters, this is the Unicode value of the first character in that attribute. In Firefox 26 this returns codes for printable characters. <div> <strong>Warning:</strong> This attribute is deprecated; you should use <code>KeyboardEvent.key</code> instead, if available. </div>  */
    public double charCode;
    /** 
 Returns a <code>Boolean</code> that is <code>true</code> if the <kbd>Ctrl</kbd> key was active when the key event was generated.  */
    public Boolean ctrlKey;
    /** 
 Returns a <code>DOMString</code> representing the key value of the key represented by the event.  */
    public String key;
    /** 
 Returns a&nbsp; <code>Number</code>&nbsp;representing a system and implementation dependent numerical code identifying the unmodified value of the pressed key. <div> <strong>Warning:</strong> This attribute is deprecated; you should use <code>KeyboardEvent.key</code> instead, if available. </div>  */
    public double keyCode;
    /** 
 Returns a <code>DOMString</code> representing a locale string indicating the locale the keyboard is configured for. This may be the empty string if the browser or device doesn't know the keyboard's locale. <div> <strong>Note:</strong> This does not describe the locale of the data being entered. A user may be using one keyboard layout while typing text in a different language. </div>  */
    public String locale;
    /** 
 Returns a&nbsp; <code>Number</code> representing the location of the key on the keyboard or other input device.  */
    public double location;
    /** 
 Returns a <code>Boolean</code> that is <code>true</code> if the <kbd>Meta</kbd> key (on Mac keyboards, the <kbd>⌘ Command</kbd> key; on Windows keyboards, the Windows key ( <kbd>⊞</kbd>)) was active when the key event was generated.  */
    public Boolean metaKey;
    /** 
 Returns a <code>Boolean</code> that is <code>true</code> if the key is being held down such that it is automatically repeating.  */
    public Boolean repeat;
    /** 
 Returns a <code>Boolean</code> that is <code>true</code> if the <kbd>Shift</kbd> key was active when the key event was generated.  */
    public Boolean shiftKey;
    /** 
 Returns a&nbsp; <code>Number</code> representing a system and implementation dependent numeric code identifying the unmodified value of the pressed key; this is usually the same as <code>keyCode</code>. <div> <strong>Warning:</strong> This attribute is deprecated; you should use <code>KeyboardEvent.key</code> instead, if available. </div>  */
    public double which;
    /** 
 Returns a <code>Boolean</code> indicating if the modifier key, like&nbsp; <kbd>Alt</kbd>,&nbsp; <kbd>Shift</kbd>,&nbsp; <kbd>Ctrl</kbd>, or <kbd>Meta</kbd>, was pressed when the event was created.  */
    native public Boolean getModifierState(String keyArg);
    /** 
 Initializes a <code>KeyboardEvent</code> object. This has never been implemented by Gecko (who used <code>KeyboardEvent.initKeyEvent()</code>) and should not be used any more. The standard modern way is to use the <code>KeyboardEvent()</code> constructor.  */
    native public void initKeyboardEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Window viewArg, String keyArg, double locationArg, String modifiersListArg, Boolean repeat, String locale);
    public double DOM_KEY_LOCATION_JOYSTICK;
    public double DOM_KEY_LOCATION_LEFT;
    public double DOM_KEY_LOCATION_MOBILE;
    public double DOM_KEY_LOCATION_NUMPAD;
    public double DOM_KEY_LOCATION_RIGHT;
    public double DOM_KEY_LOCATION_STANDARD;
    public static KeyboardEvent prototype;
    public KeyboardEvent(String typeArg, KeyboardEventInit eventInitDict){}
    public KeyboardEvent(String typeArg){}
    protected KeyboardEvent(){}
}

