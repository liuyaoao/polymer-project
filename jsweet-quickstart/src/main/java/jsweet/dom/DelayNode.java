package jsweet.dom;
/**  <div> <p>The <code>DelayNode</code> interface represents a delay-line; an <code>AudioNode</code> audio-processing module that causes a delay between the arrival of an input data and its propagation to the output. A <code>DelayNode</code> always has exactly one input and one output, both with the same amount of channels.</p> </div> <p><img></img></p> <p>When creating a graph that has a cycle, it is mandatory to have at least one <code>DelayNode</code> in the cycle, or the nodes taking part in the cycle will be muted.</p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;max&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code> (not used in the default count mode)</td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class DelayNode extends AudioNode {
    /** 
 Is an a-rate <code>AudioParam</code> representing the amount of delay to apply.  */
    public AudioParam delayTime;
    public static DelayNode prototype;
    public DelayNode(){}
}

