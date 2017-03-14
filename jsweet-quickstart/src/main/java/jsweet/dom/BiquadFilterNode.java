package jsweet.dom;
import jsweet.lang.Float32Array;
/**  <div> <p><span>The <code>BiquadFilterNode</code> interface represents a simple low-order filter, and is created using the <code>AudioContext.createBiquadFilter()</code> method. It is an <code>AudioNode</code> that can represent different kinds of filters, tone control devices, and graphic equalizers.</span> A <code>BiquadFilterNode</code> always has exactly one input and one output.</p> </div> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;max&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code> (not used in the default count mode)</td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class BiquadFilterNode extends AudioNode {
    /** 
 Is a k-rate <code>AudioParam</code>, a double representing a Q factor, or <em>quality factor</em>.  */
    public AudioParam Q;
    /** 
 Is an a-rate <code>AudioParam</code> representing detuning of the frequency in cents.  */
    public AudioParam detune;
    /** 
 Is a k-rate <code>AudioParam</code>, a double representing a frequency in the current filtering algorithm measured in hertz (Hz).  */
    public AudioParam frequency;
    /** 
 Is a k-rate <code>AudioParam</code>, a double representing the gain used in the current filtering algorithm.  */
    public AudioParam gain;
    /** 
 Is a string value defining the kind of filtering algorithm the node is implementing. <br></br> &nbsp; <table> <caption>
 The meaning of the different parameters depending of the type of the filter (detune has the same meaning regardless, so isn't listed below) </caption> <thead> <tr> <th><code>type</code></th> <th>Description</th> <th><code>frequency</code></th> <th><code>Q</code></th> <th><code>gain</code></th> </tr> </thead> <tbody> <tr> <th><code>lowpass</code></th> <td>Standard second-order resonant lowpass filter with 12dB/octave rolloff. Frequencies below the cutoff pass through; frequencies above it are attenuated.</td> <td>The cutoff frequency.</td> <td>Indicates how peaked the frequency is around the cutoff. The greater the value is, the greater is the peak.</td> <td><em>Not used</em></td> </tr> <tr> <th><code>highpass</code></th> <td>Standard second-order resonant highpass filter with 12dB/octave rolloff. Frequencies below the cutoff are attenuated; frequencies above it pass through.</td> <td>The cutoff frequency.</td> <td>Indicates how peaked the frequency is around the cutoff. The greater the value, the greater the peak.</td> <td><em>Not used</em></td> </tr> <tr> <th><code>bandpass</code></th> <td>Standard second-order bandpass filter. Frequencies outside the given range of frequencies are attenuated; the frequencies inside it pass through.</td> <td>The center of the range of frequencies.</td> <td>Controls the width of the frequency band. The greater the <code>Q</code> value, the smaller the frequency band.</td> <td><em>Not used</em></td> </tr> <tr> <th><code>lowshelf</code></th> <td>Standard second-order lowshelf filer. Frequencies lower than the frequency get a boost, or an attenuation; frequencies over it are unchanged.</td> <td>The upper limit of the frequencies getting a boost or an attenuation.</td> <td><em>Not used</em></td> <td>The boost, in dB, to be applied; if negative, it will be an attenuation.</td> </tr> <tr> <th><code>highshelf</code></th> <td>Standard second-order highshelf filer. Frequencies higher than the frequency get a boost or an attenuation; frequencies lower than it are unchanged.</td> <td>The lower limit of the frequencies getting a boost or an attenuation.</td> <td><em>Not used</em></td> <td>The boost, in dB, to be applied; if negative, it will be an attenuation.</td> </tr> <tr> <th><code>peaking</code></th> <td>Frequencies inside the range get a boost or an attenuation; frequencies outside it are unchanged.</td> <td>The middle of the frequency range getting a boost or an attenuation.</td> <td>Controls the width of the frequency band. The greater the <code>Q</code> value, the smaller the frequency band.</td> <td>The boost, in dB, to be applied; if negative, it will be an attenuation.</td> </tr> <tr> <th><code>notch</code></th> <td>Standard notch filter, also called a <em>band-stop</em> or <em>band-rejection</em> filter. It is the opposite of a bandpass filter: frequencies outside the give range of frequencies pass through; frequencies inside it are attenuated.</td> <td>The center of the range of frequencies.</td> <td>Controls the width of the frequency band. The greater the <code>Q</code> value, the smaller the frequency band.</td> <td><em>Not used</em></td> </tr> <tr> <th><code>allpass</code></th> <td>Standard second-order allpass filter. It lets all frequencies through, but changes the phase-relationship between the various frequencies.</td> <td>The frequency with the maximal group delay, that is, the frequency where the center of the phase transition occurs.</td> <td>Controls how sharp the transition is at the medium frequency. The larger this parameter is, the sharper and larger the transition will be.</td> <td><em>Not used</em></td> </tr> </tbody> </table>  */
    public String type;
    /** 
 From the current filter parameter settings this method calculates the frequency response for frequencies specified in the provided array of frequencies.  */
    native public void getFrequencyResponse(Float32Array frequencyHz, Float32Array magResponse, Float32Array phaseResponse);
    public static BiquadFilterNode prototype;
    public BiquadFilterNode(){}
}
