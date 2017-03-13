package jsweet.dom;
/**  <div> <p>The <code>StereoPannerNode</code> interface of the Web Audio API represents a simple stereo panner node that can be used to pan an audio stream left or right. It is an <code>AudioNode</code> audio-processing module that positions an incoming audio stream in a stereo image using a low-cost equal-power panning algorithm.</p> </div> <p>The <code>pan</code> property takes a unitless value between <code>-1</code> (full left pan) and <code>1</code> (full right pan). This interface was introduced as a much simpler way to apply a simple panning effect than having to use a full <code>PannerNode</code>.</p> <p><img></img></p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;clamped-max&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code></td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class StereoPannerNode extends AudioNode {
    /** 
 Is an a-rate <code>AudioParam</code> representing the amount of panning to apply.  */
    public AudioParam pan;
    public static StereoPannerNode prototype;
    public StereoPannerNode(){}
}

