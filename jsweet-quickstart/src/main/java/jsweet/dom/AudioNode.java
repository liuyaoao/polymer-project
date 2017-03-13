package jsweet.dom;
/**  <p>The <code>AudioNode</code> interface is a generic interface for representing an audio processing module like an audio source (e.g. an HTML <code>&lt;audio&gt;</code> or <code>&lt;video&gt;</code> element, an <code>OscillatorNode</code>, etc.), the audio destination, intermediate processing module (e.g. a filter like <code>BiquadFilterNode</code> or <code>ConvolverNode</code>), or volume control (like <code>GainNode</code>).</p> <p><img></img></p> <p>An <code>AudioNode</code> has inputs and outputs, each with a given amount of <em>channels</em>.<em> </em>An <code>AudioNode</code> with zero inputs and one or multiple outputs is called a <em>source node</em>. The exact processing done varies from one <code>AudioNode</code> to another but, in general, a node reads its inputs, does some audio-related processing, and generates new values for its outputs, or simply lets the audio pass through (for example in the <code>AnalyserNode</code>, where the result of the processing is accessed separately).</p> <p>Different nodes can be linked together to build a <em>processing graph</em>. Such a graph is contained in an <code>AudioContext</code>. Each <code>AudioNode</code> participates in exactly one such context. In general, processing nodes inherit the properties and methods of <code>AudioNode</code>, but also define their own functionality on top. See the individual node pages for more details, as listed on the Web Audio API homepage.</p> <div> <p><strong>Note</strong>: An <code>AudioNode</code> can be target of events, therefore it implements the <code>EventTarget</code> interface.</p> </div>  */
public class AudioNode extends EventTarget {
    /** 
 Represents an integer used to determine how many channels are used when up-mixing and down-mixing connections to any inputs to the node. Its usage and precise definition depend on the value of <code>AudioNode.channelCountMode</code>.  */
    public double channelCount;
    /** 
 Represents an enumerated value describing the way channels must be matched between the node's inputs and outputs.  */
    public String channelCountMode;
    /** 
 Represents an enumerated value describing the meaning of the channels. This interpretation will define how audio up-mixing and down-mixing will happen. <br></br> The possible values are <code>&quot;speakers&quot;</code> or <code>&quot;discrete&quot;</code>.  */
    public String channelInterpretation;
    /** 
 Returns the associated <code>AudioContext</code>, that is the object representing the processing graph the node is participating in.  */
    public AudioContext context;
    /** 
 Returns the number of inputs feeding the node. Source nodes are defined as nodes having a <code>numberOfInputs</code> property with a value of <code>0</code>.  */
    public double numberOfInputs;
    /** 
 Returns the number of outputs coming out of the node. Destination nodes — like <code>AudioDestinationNode</code> — have a value of <code>0</code> for this attribute.  */
    public double numberOfOutputs;
    native public void connect(AudioNode destination, double output, double input);
    /** 
 Allows us to disconnect the current node from another one it is already connected to.  */
    native public void disconnect(double output);
    /** 
 Allows us to disconnect the current node from another one it is already connected to.  */
    native public void disconnect(AudioNode destination, double output, double input);
    /** 
 Allows us to disconnect the current node from another one it is already connected to.  */
    native public void disconnect(AudioParam destination, double output);
    public static AudioNode prototype;
    public AudioNode(){}
    native public void connect(AudioNode destination, double output);
    native public void connect(AudioNode destination);
    /** 
 Allows us to disconnect the current node from another one it is already connected to.  */
    native public void disconnect();
    /** 
 Allows us to disconnect the current node from another one it is already connected to.  */
    native public void disconnect(AudioNode destination, double output);
    /** 
 Allows us to disconnect the current node from another one it is already connected to.  */
    native public void disconnect(AudioNode destination);
    /** 
 Allows us to disconnect the current node from another one it is already connected to.  */
    native public void disconnect(AudioParam destination);
}

