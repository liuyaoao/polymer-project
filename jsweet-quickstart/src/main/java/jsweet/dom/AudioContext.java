package jsweet.dom;
import jsweet.lang.Float32Array;
import jsweet.lang.ArrayBuffer;
/**  <div> <p>The <code>AudioContext</code> interface represents an audio-processing graph built from audio modules linked together, each represented by an <code>AudioNode</code>. An audio context controls both the creation of the nodes it contains and the execution of the audio processing, or decoding. You need to create an AudioContext before you do anything else, as everything happens inside a context.</p> </div> <p>An <code>AudioContext</code> can be a target of events, therefore it implements the <code>EventTarget</code> interface.</p>  */
public class AudioContext extends EventTarget {
    /** 
 Returns a double representing an ever-increasing hardware time in seconds used for scheduling. It starts at <code>0</code>.  */
    public double currentTime;
    /** 
 Returns an <code>AudioDestinationNode</code> representing the final destination of all audio in the context. It can be thought of as the audio-rendering device.  */
    public AudioDestinationNode destination;
    /** 
 Returns the <code>AudioListener</code> object, used for 3D spatialization.  */
    public AudioListener listener;
    /** 
 Returns a float representing the sample rate (in samples per second) used by all nodes in this context. The sample-rate of an <code>AudioContext</code> cannot be changed.  */
    public double sampleRate;
    /** 
 Returns the current state of the <code>AudioContext</code>.  */
    public String state;
    /** 
 Creates an <code>AnalyserNode</code>, which can be used to expose audio time and frequency data and for example to create data visualisations.  */
    native public AnalyserNode createAnalyser();
    /** 
 Creates a <code>BiquadFilterNode</code>, which represents a second order filter configurable as several different common filter types: high-pass, low-pass, band-pass, etc.  */
    native public BiquadFilterNode createBiquadFilter();
    /** 
 Creates a new, empty <code>AudioBuffer</code> object, which can then be populated by data and played via an <code>AudioBufferSourceNode</code>.  */
    native public AudioBuffer createBuffer(double numberOfChannels, double length, double sampleRate);
    /** 
 Creates an <code>AudioBufferSourceNode</code>, which can be used to play and manipulate audio data contained within an <code>AudioBuffer</code> object. <code>AudioBuffer</code>s are created using <code>AudioContext.createBuffer</code> or returned by <code>AudioContext.decodeAudioData</code> when it successfully decodes an audio track.  */
    native public AudioBufferSourceNode createBufferSource();
    /** 
 Creates a <code>ChannelMergerNode</code>, which is used to combine channels from multiple audio streams into a single audio stream.  */
    native public ChannelMergerNode createChannelMerger(double numberOfInputs);
    /** 
 Creates a <code>ChannelSplitterNode</code>, which is used to access the individual channels of an audio stream and process them separately.  */
    native public ChannelSplitterNode createChannelSplitter(double numberOfOutputs);
    /** 
 Creates a <code>ConvolverNode</code>, which can be used to apply convolution effects to your audio graph, for example a reverberation effect.  */
    native public ConvolverNode createConvolver();
    /** 
 Creates a <code>DelayNode</code>, which is used to delay the incoming audio signal by a certain amount. This node is also useful to create feedback loops in a Web Audio API graph.  */
    native public DelayNode createDelay(double maxDelayTime);
    /** 
 Creates a <code>DynamicsCompressorNode</code>, which can be used to apply acoustic compression to an audio signal.  */
    native public DynamicsCompressorNode createDynamicsCompressor();
    /** 
 Creates a <code>GainNode</code>, which can be used to control the overall volume of the audio graph.  */
    native public GainNode createGain();
    /** 
 Creates a <code>MediaElementAudioSourceNode</code> associated with an <code>HTMLMediaElement</code>. This can be used to play and manipulate audio from <code>&lt;video&gt;</code> or <code>&lt;audio&gt;</code> elements.  */
    native public MediaElementAudioSourceNode createMediaElementSource(HTMLMediaElement mediaElement);
    /** 
 Creates an <code>OscillatorNode</code>, a source representing a periodic waveform. It basically generates a tone.  */
    native public OscillatorNode createOscillator();
    /** 
 Creates a <code>PannerNode</code>, which is used to spatialise an incoming audio stream in 3D space.  */
    native public PannerNode createPanner();
    /** 
 Creates a <code>PeriodicWave</code>, used to define a periodic waveform that can be used to determine the output of an <code>OscillatorNode</code>.  */
    native public PeriodicWave createPeriodicWave(Float32Array real, Float32Array imag);
    /** 
 Creates a <code>ScriptProcessorNode</code>, which can be used for direct audio processing via JavaScript.  */
    native public ScriptProcessorNode createScriptProcessor(double bufferSize, double numberOfInputChannels, double numberOfOutputChannels);
    /** 
 Creates a <code>StereoPannerNode</code>, which can be used to apply stereo panning to an audio source.  */
    native public StereoPannerNode createStereoPanner();
    /** 
 Creates a <code>WaveShaperNode</code>, which is used to implement non-linear distortion effects.  */
    native public WaveShaperNode createWaveShaper();
    /** 
 Asynchronously decodes audio file data contained in an <code>ArrayBuffer</code>. In this case, the ArrayBuffer is usually loaded from an <code>XMLHttpRequest</code>'s <code>response</code> attribute after setting the <code>responseType</code> to <code>arraybuffer</code>. This method only works on complete files, not fragments of audio files.  */
    native public void decodeAudioData(ArrayBuffer audioData, DecodeSuccessCallback successCallback, DecodeErrorCallback errorCallback);
    public static AudioContext prototype;
    public AudioContext(){}
    /** 
 Creates a <code>ChannelMergerNode</code>, which is used to combine channels from multiple audio streams into a single audio stream.  */
    native public ChannelMergerNode createChannelMerger();
    /** 
 Creates a <code>ChannelSplitterNode</code>, which is used to access the individual channels of an audio stream and process them separately.  */
    native public ChannelSplitterNode createChannelSplitter();
    /** 
 Creates a <code>DelayNode</code>, which is used to delay the incoming audio signal by a certain amount. This node is also useful to create feedback loops in a Web Audio API graph.  */
    native public DelayNode createDelay();
    /** 
 Creates a <code>ScriptProcessorNode</code>, which can be used for direct audio processing via JavaScript.  */
    native public ScriptProcessorNode createScriptProcessor(double bufferSize, double numberOfInputChannels);
    /** 
 Creates a <code>ScriptProcessorNode</code>, which can be used for direct audio processing via JavaScript.  */
    native public ScriptProcessorNode createScriptProcessor(double bufferSize);
    /** 
 Creates a <code>ScriptProcessorNode</code>, which can be used for direct audio processing via JavaScript.  */
    native public ScriptProcessorNode createScriptProcessor();
    /** 
 Asynchronously decodes audio file data contained in an <code>ArrayBuffer</code>. In this case, the ArrayBuffer is usually loaded from an <code>XMLHttpRequest</code>'s <code>response</code> attribute after setting the <code>responseType</code> to <code>arraybuffer</code>. This method only works on complete files, not fragments of audio files.  */
    native public void decodeAudioData(ArrayBuffer audioData, DecodeSuccessCallback successCallback);
}

