package jsweet.dom;
/**  <p>The <strong><code>MessageChannel</code></strong> interface of the Channel Messaging API allows us to create a new message channel and send data through it via its two <code>MessagePort</code> properties.</p> <div> <p><strong>Note</strong>: This feature is available in Web Workers.</p> </div>  */
public class MessageChannel extends jsweet.lang.Object {
    /** 
 Returns port1 of the channel.  */
    public MessagePort port1;
    /** 
 Returns port2 of the channel.  */
    public MessagePort port2;
    public static MessageChannel prototype;
    public MessageChannel(){}
}

