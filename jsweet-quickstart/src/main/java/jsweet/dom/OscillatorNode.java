package jsweet.dom;
/**  <p>The&nbsp;<strong><code>OscillatorNode</code></strong>&nbsp;interface represents a periodic waveform, like a sine wave. It is an <code>AudioNode</code> audio-processing module that causes a given&nbsp;frequency&nbsp;of sine wave to be created — in effect, a constant tone.</p> <p>An <code>OscillatorNode</code> is created using the <code>AudioContext.createOscillator</code> method. It always has exactly one output and no inputs, both with the same amount of channels. Its basic property defaults (see <code>AudioNode</code> for definitions) are:</p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>0</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>max</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code> (not used in the default count mode)</td> </tr> <tr> <th>Channel interpretation</th> <td><code>speakers</code></td> </tr> </tbody> </table>  */
public class OscillatorNode extends AudioNode {
    /** 
 An a-rate <code>AudioParam</code> representing detuning of oscillation in cents (though the&nbsp; <code>AudioParam</code>&nbsp;returned is read-only, the value it represents is not.)  */
    public AudioParam detune;
    /** 
 An a-rate <code>AudioParam</code> representing the frequency of oscillation in hertz (though the&nbsp; <code>AudioParam</code>&nbsp;returned is read-only, the value it represents is not.)  */
    public AudioParam frequency;
    /** 
 Used to set the event handler for the <code>ended</code> event, which fires when the tone has stopped playing.  */
    public java.util.function.Function<Event,Object> onended;
    /** 
 Represents the shape of the oscillator wave generated. Different waves will produce different tones.  */
    public String type;
    /** 
 Used to point to a <code>PeriodicWave</code> defining a periodic waveform that can be used to shape the oscillator's output, when <code>type = &quot;custom&quot;</code> is used. This replaces the now-obsolete <code>OscillatorNode.setWaveTable</code>.  */
    native public void setPeriodicWave(PeriodicWave periodicWave);
    /** 
 This method specifies the exact time to start playing the tone.  */
    native public void start(double when);
    /** 
 This method specifies the exact time to stop playing the tone.  */
    native public void stop(double when);
    native public void addEventListener(jsweet.util.StringTypes.ended type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static OscillatorNode prototype;
    public OscillatorNode(){}
    /** 
 This method specifies the exact time to start playing the tone.  */
    native public void start();
    /** 
 This method specifies the exact time to stop playing the tone.  */
    native public void stop();
    native public void addEventListener(jsweet.util.StringTypes.ended type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

