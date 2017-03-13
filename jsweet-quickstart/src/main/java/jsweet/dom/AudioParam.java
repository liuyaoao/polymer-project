package jsweet.dom;
import jsweet.lang.Float32Array;
/**  <div> <p>The <code>AudioParam</code> interface represents an audio-related parameter, usually a parameter of an <code>AudioNode</code> (such as <code>GainNode.gain</code>). An <code>AudioParam</code> can be set to a specific value or a change in value, and can be scheduled to happen at a specific time and following a specific pattern.</p> </div> <p>There are two kinds of <code>AudioParam</code>, <em>a-rate</em> and <em>k-rate</em> parameters:</p> <ul> <li>An <em>a-rate</em> <code>AudioParam</code> takes the current audio parameter value for each sample frame of the audio signal.</li> <li>A <em>k-rate</em> <code>AudioParam</code> uses the same initial audio parameter value for the whole block processed, that is 128 sample frames.</li> </ul> <p>Each <code>AudioNode</code> defines which of its parameters are <em>a-rate</em> or <em>k-rate</em> in the spec.</p> <p>Each <code>AudioParam</code> has a list of events, initially empty, that define when and how values change. When this list is not empty, changes using the <code>AudioParam.value</code> attributes are ignored. This list of events allows us to schedule changes that have to happen at very precise times, using arbitrary timelime-based automation curves. The time used is the one defined in <code>AudioContext.currentTime</code>.</p>  */
public class AudioParam extends jsweet.lang.Object {
    /** 
 Represents the initial value of the attributes as defined by the specific <code>AudioNode</code> creating the <code>AudioParam</code>.  */
    public double defaultValue;
    /** 
 Represents the parameter's current floating point value; initially set to the value of <code>AudioParam.defaultValue</code>. Though it can be set, any modifications happening while there are automation events scheduled — that is events scheduled using the methods of the <code>AudioParam</code> — are ignored, without raising any exception.  */
    public double value;
    /** 
 Cancels all scheduled future changes to the <code>AudioParam</code>.  */
    native public void cancelScheduledValues(double startTime);
    /** 
 Schedules a gradual exponential change in the value of the <code>AudioParam</code>. The change starts at the time specified for the <em>previous</em> event, follows an exponential ramp to the new value given in the <code>value</code> parameter, and reaches the new value at the time given in the <code>endTime</code> parameter.  */
    native public void exponentialRampToValueAtTime(double value, double endTime);
    /** 
 Schedules a gradual linear change in the value of the <code>AudioParam</code>. The change starts at the time specified for the <em>previous</em> event, follows a linear ramp to the new value given in the <code>value</code> parameter, and reaches the new value at the time given in the <code>endTime</code> parameter.  */
    native public void linearRampToValueAtTime(double value, double endTime);
    /** 
 Schedules the start of a change to the value of the <code>AudioParam</code>. The change starts at the time specified in <code>startTime</code> and exponentially moves towards the value given by the <code>target</code> parameter. The exponential decay rate is defined by the <code>timeConstant</code> parameter, which is a time measured in seconds.  */
    native public void setTargetAtTime(double target, double startTime, double timeConstant);
    /** 
 Schedules an instant change to the value of the <code>AudioParam</code> at a precise time, as measured against <code>AudioContext.currentTime</code>. The new value is given in the <code>value</code> parameter.  */
    native public void setValueAtTime(double value, double startTime);
    /** 
 Schedules the values of the <code>AudioParam</code> to follow a set of values, defined by the <code>values</code> <code>Float32Array</code> scaled to fit into the given interval, starting at <code>startTime</code>, and having a specific <code>duration</code>.  */
    native public void setValueCurveAtTime(Float32Array values, double startTime, double duration);
    public static AudioParam prototype;
    public AudioParam(){}
}

