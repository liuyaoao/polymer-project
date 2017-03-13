package jsweet.dom;
/**  <div> <p>The <code>MediaElementAudioSourceNode</code> interface represents an audio source consisting of an HTML5 <code>&lt;audio&gt;</code> or <code>&lt;video&gt;</code> element. It is an <code>AudioNode</code> that acts as an audio source.</p> </div> <p>A <code>MediaElementSourceNode</code> has no inputs and exactly one output, and is created using the <code>AudioContext.createMediaElementSource</code> method. The amount of channels in the output equals the number of channels of the audio referenced by the <code>HTMLMediaElement</code> used in the creation of the node, or is 1 if the <code>HTMLMediaElement</code> has no audio.</p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>0</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count</th> <td>defined by the media in the <code>HTMLMediaElement</code> passed to the <code>AudioContext.createMediaElementSource</code> method that created it.</td> </tr> </tbody> </table>  */
public class MediaElementAudioSourceNode extends AudioNode {
    public static MediaElementAudioSourceNode prototype;
    public MediaElementAudioSourceNode(){}
}

