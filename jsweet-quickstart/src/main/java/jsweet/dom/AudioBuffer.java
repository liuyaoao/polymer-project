package jsweet.dom;
import jsweet.lang.Float32Array;
/**  <div> <p>The <code>AudioBuffer</code> interface represents a short audio asset residing in memory, created from an audio file using the <code>AudioContext.decodeAudioData()</code> method, or from raw data using <code>AudioContext.createBuffer()</code>. Once put into an AudioBuffer, the audio can then be played by being passed into an <code>AudioBufferSourceNode</code>.</p> </div> <p>Objects of these types are designed to hold small audio snippets, typically less than 45&nbsp;s. For longer sounds, objects implementing the <code>MediaElementAudioSourceNode</code> are more suitable. The buffer contains data in the following format:&nbsp; non-interleaved IEEE754 32-bit linear PCM with a nominal range between <code>-1</code> and <code>+1</code>, that is, 32bits floating point buffer, with each samples between -1.0 and 1.0. If the <code>AudioBuffer</code> has multiple channels, they are stored in separate buffer.</p>  */
public class AudioBuffer extends jsweet.lang.Object {
    /** 
 Returns a double representing the duration, in seconds, of the PCM data stored in the buffer.  */
    public double duration;
    /** 
 Returns an integer representing the length, in sample-frames, of the PCM data stored in the buffer.  */
    public double length;
    /** 
 Returns an integer representing the number of discrete audio channels described by the PCM data stored in the buffer.  */
    public double numberOfChannels;
    /** 
 Returns a float representing the sample rate, in samples per second, of the PCM data stored in the buffer.  */
    public double sampleRate;
    /** 
 Returns a <code>Float32Array</code> containing the PCM data associated with the channel, defined by the <code>channel</code> parameter (with <code>0</code> representing the first channel).  */
    native public Float32Array getChannelData(double channel);
    public static AudioBuffer prototype;
    public AudioBuffer(){}
}

