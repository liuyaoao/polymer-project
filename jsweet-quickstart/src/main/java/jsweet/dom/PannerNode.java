package jsweet.dom;
/**  <div> <p>The <code>PannerNode</code> interface represents the position and behavior of an audio source signal in space. It is an <code>AudioNode</code> audio-processing module describing its position with right-hand Cartesian coordinates, its movement using a velocity vector and its directionality using a directionality cone.</p> </div> <p>A <code>PannerNode</code> always has exactly one input and one output: the input can be <em>mono</em> or <em>stereo</em> but the output is always <em>stereo</em> (2 channels) — you need stereo sound for panning effects!</p> <p><img></img></p> <table> <tbody> <tr> <th>Number of inputs</th> <td><code>1</code></td> </tr> <tr> <th>Number of outputs</th> <td><code>1</code></td> </tr> <tr> <th>Channel count mode</th> <td><code>&quot;clamped-max&quot;</code></td> </tr> <tr> <th>Channel count</th> <td><code>2</code></td> </tr> <tr> <th>Channel interpretation</th> <td><code>&quot;speakers&quot;</code></td> </tr> </tbody> </table>  */
public class PannerNode extends AudioNode {
    /** 
 Is a double value describing the angle, in degrees, of a cone inside of which there will be no volume reduction.  */
    public double coneInnerAngle;
    /** 
 Is a double value describing the angle, in degrees, of a cone outside of which the volume will be reduced by a constant value, defined by the <code>coneOuterGain</code> attribute.  */
    public double coneOuterAngle;
    /** 
 Is a double value describing the amount of volume reduction outside the cone defined by the <code>coneOuterAngle</code> attribute. Its default value is <code>0</code>, meaning that no sound can be heard.  */
    public double coneOuterGain;
    /** 
 Is an enumerated value determining which algorithm to use to reduce the volume of the audio source as it moves away from the listener.  */
    public String distanceModel;
    /** 
 Is a double value representing the maximum distance between the audio source and the listener, after which the volume is not reduced any further.  */
    public double maxDistance;
    /** 
 Is an enumerated value determining which spatialisation algorithm to use to position the audio in 3D space.  */
    public String panningModel;
    /** 
 Is a double value representing the reference distance for reducing volume as the audio source moves further from the listener.  */
    public double refDistance;
    /** 
 Is a double value describing how quickly the volume is reduced as the source moves away from the listener. This value is used by all distance models.  */
    public double rolloffFactor;
    /** 
 Defines the direction the audio source is playing in.  */
    native public void setOrientation(double x, double y, double z);
    /** 
 Defines the position of the audio source relative to the listener (represented by an <code>AudioListener</code> object stored in the <code>AudioContext.listener</code> attribute.)  */
    native public void setPosition(double x, double y, double z);
    /** 
 Defines the velocity vector of the audio source — how fast it is moving and in what direction. In a previous version of the specification, the <code>PannerNode</code> had a velocity that could pitch up or down <code>AudioBufferSourceNode</code>s connected downstream. This feature was not clearly specified and had a number of issues, so it has been removed.  */
    native public void setVelocity(double x, double y, double z);
    public static PannerNode prototype;
    public PannerNode(){}
}

