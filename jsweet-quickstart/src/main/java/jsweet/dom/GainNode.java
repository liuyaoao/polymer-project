package jsweet.dom;
/**  <div> <p>The <code>GainNode</code> interface represents a change in volume. It is an <code>AudioNode</code> audio-processing module that causes a given gain to be applied to the input data before its propagation to the output. A <code>GainNode</code> always has exactly one input and one output, both with the same number of channels.</p> </div> <p>The gain is a unitless value, changing with time, that is multiplied to each corresponding sample of all input channels. If modified, the new gain is applied using a de-zippering algorithm in order to prevent unaesthetic 'clicks' from appearing in the resulting audio.</p> <p><img></img></p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;max&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code> (not used in the default count mode)</td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class GainNode extends AudioNode {
    /** 
 Is an a-rate <code>AudioParam</code> representing the amount of gain to apply.  */
    public AudioParam gain;
    public static GainNode prototype;
    public GainNode(){}
}

