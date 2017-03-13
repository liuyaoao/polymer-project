package jsweet.dom;
/** <p>The <strong><code>DragEvent</code></strong> interface is a <code>DOM event</code> that represents a drag and drop interaction. The user initiates a drag by placing a pointer device (such as a mouse) on the touch surface and then dragging the pointer to a new location (such as another DOM element). Applications are free to interpret a drag and drop interaction in an application-specific way.</p> <p>This interface inherits properties from <code>MouseEvent</code> and <code>Event</code>.</p>  */
public class DragEvent extends MouseEvent {
    /** 
 The data that is transferred during a drag and drop interaction.  */
    public DataTransfer dataTransfer;
    native public void initDragEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Window viewArg, double detailArg, double screenXArg, double screenYArg, double clientXArg, double clientYArg, Boolean ctrlKeyArg, Boolean altKeyArg, Boolean shiftKeyArg, Boolean metaKeyArg, double buttonArg, EventTarget relatedTargetArg, DataTransfer dataTransferArg);
    native public void msConvertURL(File file, String targetType, String targetURL);
    public static DragEvent prototype;
    public DragEvent(){}
    native public void msConvertURL(File file, String targetType);
}

