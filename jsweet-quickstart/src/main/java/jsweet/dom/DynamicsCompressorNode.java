package jsweet.dom;
/**  <div> <p>The <code>DynamicsCompressorNode</code> interface provides a compression effect, which lowers the volume of the loudest parts of the signal in order to help prevent clipping and distortion that can occur when multiple sounds are played and multiplexed together at once. This is often used in musical production and game audio. <code>DynamicsCompressorNode</code> is an <code>AudioNode</code> that has exactly one input and one output; it is created using the <code>AudioContext.createDynamicsCompressor</code> method.</p> </div> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;explicit&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code></td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class DynamicsCompressorNode extends AudioNode {
    /** 
 Is a k-rate <code>AudioParam</code> representing the amount of time, in seconds, required to reduce the gain by 10 dB.  */
    public AudioParam attack;
    /** 
 Is a k-rate <code>AudioParam</code> containing a decibel value representing the range above the threshold where the curve smoothly transitions to the compressed portion.  */
    public AudioParam knee;
    /** 
 Is a k-rate <code>AudioParam</code> representing the amount of change, in dB, needed in the input for a 1 dB change in the output.  */
    public AudioParam ratio;
    /** 
 Is a k-rate <code>AudioParam</code> representing the amount of gain reduction currently applied by the compressor to the signal.  */
    public AudioParam reduction;
    /** 
 Is a k-rate <code>AudioParam</code> representing the amount of time, in seconds, required to increase the gain by 10 dB.  */
    public AudioParam release;
    /** 
 Is a k-rate <code>AudioParam</code> representing the decibel value above which the compression will start taking effect.  */
    public AudioParam threshold;
    public static DynamicsCompressorNode prototype;
    public DynamicsCompressorNode(){}
}

