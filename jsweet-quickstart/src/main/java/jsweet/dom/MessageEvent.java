package jsweet.dom;
/** <p>A <code><strong>MessageEvent</strong></code> is the interface representing a message received by a target, being a <code>WebSocket</code> or a WebRTC <code>RTCDataChannel</code></p> <p>The action triggered by this event is set via an event handler set on <code>WebSocket.onmessage</code> or <code>RTCDataChannel.onmessage</code>.</p>  */
public class MessageEvent extends Event {
    /** 
The data from the server. */
    public Object data;
    public String origin;
    public Object ports;
    public Window source;
    native public void initMessageEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Object dataArg, String originArg, String lastEventIdArg, Window sourceArg);
    public static MessageEvent prototype;
    public MessageEvent(String type, MessageEventInit eventInitDict){}
    public MessageEvent(String type){}
    protected MessageEvent(){}
}

