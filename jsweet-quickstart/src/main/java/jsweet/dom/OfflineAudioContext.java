package jsweet.dom;
/**  <div> <p>The <code>OfflineAudioContext</code> interface is an <code>AudioContext</code> interface representing an audio-processing graph built from linked together <code>AudioNode</code>s. In contrast with a standard <code>AudioContext</code>, an <code>OfflineAudioContext</code> doesn't render the audio to the device hardware; instead, it generates it, as fast as it can, and outputs the result to an <code>AudioBuffer</code>.</p> <p>It is important to note that, whereas you can create a new <code>AudioContext</code> using the <code>new AudioContext()</code> constructor with no arguments, the <code>new OfflineAudioContext()</code> constructor requires three arguments:</p> <pre>new OfflineAudioContext(numOfChannels,length,sampleRate);</pre> <p>This works in exactly the same way as when you create a new <code>AudioBuffer</code> with the <code>AudioContext.createBuffer</code> method. For more detail, read Audio buffers: frames, samples and channels from our Basic concepts guide. The arguments are:</p> <dl> <dt>
 numOfChannels </dt> <dd>
 An integer representing the number of channels this buffer should have. Implementations must support a minimum 32 channels. </dd> <dt>
 length </dt> <dd>
 An integer representing the size of the buffer in sample-frames. </dd> <dt>
 sampleRate </dt> <dd>
 The sample-rate of the linear audio data in sample-frames per second. An implementation must support sample-rates in at least the range 22050 to 96000, with 44100 being the most commonly used. </dd> </dl> </div> <div> <p><strong>Note</strong>: Like a regular <code>AudioContext</code>, an <code>OfflineAudioContext</code> can be the target of events, therefore it implements the <code>EventTarget</code> interface.</p> </div>  */
public class OfflineAudioContext extends AudioContext {
    /** 
 Is an <code>EventHandler</code> called when the processing is terminated, that is when the <code>complete</code> event (of type <code>OfflineAudioCompletionEvent</code>) is raised.  */
    public java.util.function.Function<Event,Object> oncomplete;
    /** 
 Starts rendering the audio, taking into account the current connections and the current scheduled changes. This is the event-based version.  */
    native public void startRendering();
    native public void addEventListener(jsweet.util.StringTypes.complete type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static OfflineAudioContext prototype;
    public OfflineAudioContext(double numberOfChannels, double length, double sampleRate){}
    native public void addEventListener(jsweet.util.StringTypes.complete type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
    protected OfflineAudioContext(){}
}

