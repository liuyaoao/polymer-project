package jsweet.dom;
/**  <p>The <code>ConvolverNode</code> interface is an&nbsp;<code>AudioNode</code> that&nbsp;performs a Linear Convolution on a given <code>AudioBuffer</code>, often used to achieve a reverb effect. A <code>ConvolverNode</code> always has exactly one input and one output.</p> <div> <p><strong>Note</strong>: For more information on the theory behind Linear Convolution, see the W3C Web Audio API spec section, Linear Effects Using Convolution, or read the The Wikipedia Linear Convolution Article.</p> </div> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;clamped-max&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code></td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class ConvolverNode extends AudioNode {
    /** <span>A mono, stereo, or 4-channel&nbsp;</span> <em><code>AudioBuffer</code></em> <span>&nbsp;containing the (possibly multichannel) impulse response used by the <code>ConvolverNode</code> to create the reverb effect.</span>  */
    public AudioBuffer buffer;
    /** <span>A boolean that controls whether the impulse response from the buffer will be scaled by an equal-power normalization when the <code>buffer</code> attribute is set, or not.</span>  */
    public Boolean normalize;
    public static ConvolverNode prototype;
    public ConvolverNode(){}
}

