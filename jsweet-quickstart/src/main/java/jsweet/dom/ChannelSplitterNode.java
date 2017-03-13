package jsweet.dom;
/**  <div> <p>The <code>ChannelSplitterNode</code> interface, often used in conjunction with its opposite, <code>ChannelMergerNode</code>, separates the different channels of an audio source into a set of mono outputs. This is useful for accessing each channel separately, e.g. for performing channel mixing where gain must be separately controlled on each channel.</p> </div> <p><img></img></p> <p>If your <code>ChannelSplitterNode</code> always has one single input, the amount of outputs is defined by a parameter on its constructor and the call to <code>AudioContext.createChannelSplitter()</code>. In the case that no value is given, it will default to <code>6</code>. If there are less channels in the input than there are outputs, supernumerary outputs are silent.</p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td>variable; default to <code>6</code>.</td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;max&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2 </code>(not used in the default count mode)</td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class ChannelSplitterNode extends AudioNode {
    public static ChannelSplitterNode prototype;
    public ChannelSplitterNode(){}
}

