package jsweet.dom;
/**  <p>The DOM <code>CompositionEvent</code> represents events that occur due to the user indirectly entering text.</p>  */
public class CompositionEvent extends UIEvent {
    /** <p>For <code>compositionstart</code> events, this is the currently selected text that will be replaced by the string being composed. This value doesn't change even if content changes the selection range; rather, it indicates the string that was selected when composition started.</p> <p>For <code>compositionupdate</code>, this is the string as it stands currently as editing is ongoing.</p> <p>For <code>compositionend</code> events, this is the string as committed to the editor.</p> <p><strong>Read only</strong>.</p>  */
    public String data;
    /** <p>The locale of current input method (for example, the keyboard layout locale if the composition is associated with IME). <strong>Read only.</strong></p>  */
    public String locale;
    native public void initCompositionEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Window viewArg, String dataArg, String locale);
    public static CompositionEvent prototype;
    public CompositionEvent(String typeArg, CompositionEventInit eventInitDict){}
    public CompositionEvent(String typeArg){}
    protected CompositionEvent(){}
}

