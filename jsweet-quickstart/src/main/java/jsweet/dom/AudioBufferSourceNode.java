package jsweet.dom;
/**  <div> <p><span>The <strong><code>AudioBufferSourceNode</code></strong><strong> </strong>interface represents an audio source consisting of in-memory audio data, stored in an <code>AudioBuffer</code>. It is an <code>AudioNode</code> that acts as an audio source<code>.</code></span></p> </div> <p><code>AudioBufferSourceNode</code> has no input and exactly one output. The number of channels in the output corresponds to the number of channels of the <code>AudioBuffer</code> that is set to the <code>AudioBufferSourceNode.buffer</code> property. If there is no buffer set—that is, if the attribute's value is <code>NULL</code>—the output contains one channel consisting of silence. An <code>AudioBufferSourceNode</code> can only be played once; that is, only one call to <code>AudioBufferSourceNode.start()</code> is allowed. If the sound needs to be played again, another <code>AudioBufferSourceNode</code> has to be created. Those nodes are cheap to create, and <code>AudioBuffer</code>s can be reused across plays. It is often said that <code>AudioBufferSourceNode</code>s have to be used in a &quot;fire and forget&quot; fashion: once it has been started, all references to the node can be dropped, and it will be garbage-collected automatically.</p> <p>Multiple calls to <code>AudioBufferSourceNode.stop()</code> are allowed. The most recent call replaces the previous one, granted the <code>AudioBufferSourceNode</code> has not already reached the end of the buffer.</p> <p><br></br> <img></img></p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>0</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count</th> <td>defined by the associated <code>AudioBuffer</code></td> </tr> </tbody> </table>  */
public class AudioBufferSourceNode extends AudioNode {
    /** 
 Is an <code>AudioBuffer</code> that defines the audio asset to be played, or when set to the value <code>null</code>, defines a single channel of silence.&nbsp;  */
    public AudioBuffer buffer;
    /** 
 Is a Boolean attribute indicating if the audio asset must be replayed when the end of the <code>AudioBuffer</code> is reached. Its default value is <code>false</code>.  */
    public Boolean loop;
    /** 
 Is a double value indicating, in seconds, where in the <code>AudioBuffer</code> the replay of the play must stop (and eventually loop again). Its default value is <code>0</code>.  */
    public double loopEnd;
    /** 
 Is a double value indicating, in seconds, where in the <code>AudioBuffer</code> the restart of the play must happen. Its default value is <code>0</code>.  */
    public double loopStart;
    /** 
 Is an <code>EventHandler</code> containing the callback associated with the <code>ended</code> event.  */
    public java.util.function.Function<Event,Object> onended;
    /** 
 Is an a-rate <code>AudioParam</code> that defines the speed factor at which the audio asset will be played. Since no pitch correction is applied on the output, this can be used to change the pitch of the sample.  */
    public AudioParam playbackRate;
    /** 
 Schedules the start of the playback of the audio asset.  */
    native public void start(double when, double offset, double duration);
    /** 
 Schedules the end of the playback of an audio asset.  */
    native public void stop(double when);
    native public void addEventListener(jsweet.util.StringTypes.ended type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static AudioBufferSourceNode prototype;
    public AudioBufferSourceNode(){}
    /** 
 Schedules the start of the playback of the audio asset.  */
    native public void start(double when, double offset);
    /** 
 Schedules the start of the playback of the audio asset.  */
    native public void start(double when);
    /** 
 Schedules the start of the playback of the audio asset.  */
    native public void start();
    /** 
 Schedules the end of the playback of an audio asset.  */
    native public void stop();
    native public void addEventListener(jsweet.util.StringTypes.ended type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

