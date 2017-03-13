package jsweet.dom;
import jsweet.lang.Uint8Array;
import jsweet.lang.Float32Array;
/**  <p>The <strong><code>AnalyserNode</code></strong><strong> </strong>interface represents a node able to provide real-time frequency and time-domain analysis information. It is an <code>AudioNode</code> that passes the audio stream unchanged from the input to the output, but allows you to take the generated data, process it, and create audio visualizations.</p> <p>An <code>AnalyzerNode</code> has exactly one input and one output. The node works even if the output is not connected.</p> <p><img></img></p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code> (but may be left unconnected)</td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;explicit&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>1</code></td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class AnalyserNode extends AudioNode {
    /** 
 Is an unsigned long value representing the size of the FFT ( Fast Fourier Transform) to be used to determine the frequency domain.  */
    public double fftSize;
    /** 
 Is an unsigned long value half that of the FFT size. This generally equates to the number of data values you will have to play with for the visualization.  */
    public double frequencyBinCount;
    /** 
 Is a double value representing the maximum power value in the scaling range for the FFT analysis data, for conversion to unsigned byte values — basically, this specifies the maximum value for the range of results when using <code>getByteFrequencyData()</code>.  */
    public double maxDecibels;
    /** 
 Is a double value representing the minimum power value in the scaling range for the FFT analysis data, for conversion to unsigned byte values — basically, this specifies the minimum value for the range of results when using <code>getByteFrequencyData()</code>.  */
    public double minDecibels;
    /** 
 Is a double value representing the averaging constant with the last analysis frame — basically, it makes the transition between values over time smoother.  */
    public double smoothingTimeConstant;
    /** 
 Copies the current frequency data into a <code>Uint8Array</code> (unsigned byte array) passed into it.  */
    native public void getByteFrequencyData(Uint8Array array);
    /** 
 Copies the current waveform, or time-domain, data into a <code>Uint8Array</code> (unsigned byte array) passed into it.  */
    native public void getByteTimeDomainData(Uint8Array array);
    /** 
 Copies the current frequency data into a <code>Float32Array</code> array passed into it.  */
    native public void getFloatFrequencyData(Float32Array array);
    /** 
 Copies the current waveform, or time-domain, data into a <code>Float32Array</code> array passed into it.  */
    native public void getFloatTimeDomainData(Float32Array array);
    public static AnalyserNode prototype;
    public AnalyserNode(){}
}

