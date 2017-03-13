package jsweet.dom;
/** <div> <p><strong><span><i> </i></span> Deprecated</strong><br></br>This feature has been removed from the Web standards. Though some browsers may still support it, it is in the process of being dropped. Do not use it in old or new projects. Pages or Web apps using it may break at any time.</p> </div> <p><span>The Web Audio API <code>AudioProcessingEvent</code> represents events that occur when a <code>ScriptProcessorNode</code> input buffer is ready to be processed.</span></p> <div> <p><strong>Note</strong>: As of the August 29 2014 Web Audio API spec publication, this feature has been marked as deprecated, and is soon to be replaced by Audio Workers.</p> </div>  */
public class AudioProcessingEvent extends Event {
    /** 
The buffer containing the input audio data to be processed. The number of channels is defined as a parameter, <code>numberOfInputChannels</code>, of the factory method <code>AudioContext.createScriptProcessor()</code>. Note the the returned <code>AudioBuffer</code> is only valid in the scope of the <code>onaudioprocess</code> function. */
    public AudioBuffer inputBuffer;
    /** 
The buffer where the output audio data should be written. The number of channels is defined as a parameter, <code>numberOfOutputChannels</code>, of the factory method <code>AudioContext.createScriptProcessor()</code>. Note the the returned <code>AudioBuffer</code> is only valid in the scope of the <code>onaudioprocess</code> function. */
    public AudioBuffer outputBuffer;
    /** 
The time when the audio will be played, as defined by the time of <code>AudioContext.currentTime</code> */
    public double playbackTime;
    public static AudioProcessingEvent prototype;
    public AudioProcessingEvent(){}
}

