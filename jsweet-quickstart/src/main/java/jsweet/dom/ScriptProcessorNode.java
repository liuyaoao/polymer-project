package jsweet.dom;
/**  <div> <p><strong>Note</strong>: As of the August 29 2014 Web Audio API spec publication, this feature has been marked as deprecated, and is soon to be replaced by Audio Workers.</p> </div> <div> <p>The <code>ScriptProcessorNode</code> interface allows the generation, processing, or analyzing of audio using JavaScript. It is an <code>AudioNode</code> audio-processing module that is linked to two buffers, one containing the input audio data, one containing the processed output audio data. An event, implementing the <code>AudioProcessingEvent</code> interface, is sent to the object each time the input buffer contains new data, and the event handler terminates when it has filled the output buffer with data.</p> </div> <p><img></img></p> <p>The size of the input and output buffer are defined at the creation time, when the <code>AudioContext.createScriptProcessor()</code> method is called (both are defined by <code>AudioContext.createScriptProcessor()</code>'s <code>bufferSize</code> parameter). The buffer size must be a power of 2 between <code>256</code> and <code>16384</code>, that is <code>256</code>, <code>512</code>, <code>1024</code>, <code>2048</code>, <code>4096</code>, <code>8192</code> or <code>16384</code>. Small numbers lower the <em>latency</em>, but large number may be necessary to avoid audio breakup and glitches.</p> <p>If the buffer size is not defined, which is recommended, the browser will pick one that its heuristic deems appropriate.</p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;max&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code> (not used in the default count mode)</td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class ScriptProcessorNode extends AudioNode {
    /** 
 Returns an integer representing both the input and output buffer size. Its value can be a power of 2 value in the range <code>256</code>– <code>16384</code>.  */
    public double bufferSize;
    /** 
 Represents the <code>EventHandler</code> to be called.  */
    public java.util.function.Function<AudioProcessingEvent,Object> onaudioprocess;
    native public void addEventListener(jsweet.util.StringTypes.audioprocess type, java.util.function.Function<AudioProcessingEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static ScriptProcessorNode prototype;
    public ScriptProcessorNode(){}
    native public void addEventListener(jsweet.util.StringTypes.audioprocess type, java.util.function.Function<AudioProcessingEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

