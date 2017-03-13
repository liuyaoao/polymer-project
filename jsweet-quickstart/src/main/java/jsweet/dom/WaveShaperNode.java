package jsweet.dom;
import jsweet.lang.Float32Array;
/**  <div> <p>The <code>WaveShaperNode</code> interface represents a non-linear distorter. It is an <code>AudioNode</code> that uses a curve to apply a wave shaping distortion to the signal. Beside obvious distortion effects, it is often used to add a warm feeling to the signal.</p> </div> <p>A <code>WaveShaperNode</code> always has exactly one input and one output.</p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;max&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code> (not used in the default count mode)</td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class WaveShaperNode extends AudioNode {
    /** 
 Is a <code>Float32Array</code> of numbers describing the distortion to apply.  */
    public Float32Array curve;
    /** 
 Is an enumerated value indicating if oversampling must be used. Oversampling is a technique for creating more samples (up-sampling) before applying the distortion effect to the audio signal.  */
    public String oversample;
    public static WaveShaperNode prototype;
    public WaveShaperNode(){}
}

