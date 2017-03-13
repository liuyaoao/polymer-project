package jsweet.dom;
/**  <div> <p>The <code>AudioDestinationNode</code> interface represents the end destination of an audio graph in a given context — usually the speakers of your device. It can also be the node that will &quot;record&quot; the audio data when used with an <code>OfflineAudioContext</code>.</p> </div> <p><code>AudioDestinationNode</code> has no output (as it <em>is</em> the output, no more <code>AudioNode</code> can be linked after it in the audio graph) and one input. The amount of channels in the input must be between <code>0</code> and the <code>maxChannelCount</code> value or an exception is raised.</p> <p>The <code>AudioDestinationNode</code> of a given <code>AudioContext</code> can be retrieved using the <code>AudioContext.destination</code> property.</p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>0</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;explicit&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code></td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class AudioDestinationNode extends AudioNode {
    /** 
 Is an <code>unsigned long</code> defining the maximum amount of channels that the physical device can handle.  */
    public double maxChannelCount;
    public static AudioDestinationNode prototype;
    public AudioDestinationNode(){}
}

