package jsweet.dom;
/**  <div> <p>The <code>AudioListener</code> interface represents the position and orientation of the unique person listening to the audio scene, and is used in audio spatialisation. All <code>PannerNode</code>s spatialise in relation to the <code>AudioListener</code> stored in the <code>AudioContext.listener</code> attribute.</p> </div> <p>It is important to note that there is only one listener per context and that it isn't an <code>AudioNode</code>.</p> <p><img></img></p>  */
public class AudioListener extends jsweet.lang.Object {
    /** 
 Is a double value representing the amount of pitch shift to use when rendering a doppler effect.  */
    public double dopplerFactor;
    /** 
 Is a double value representing the speed of sound, in <em>meters per second</em>.  */
    public double speedOfSound;
    /** 
 Defines the orientation of the listener.  */
    native public void setOrientation(double x, double y, double z, double xUp, double yUp, double zUp);
    /** 
 Defines the position of the listener.  */
    native public void setPosition(double x, double y, double z);
    native public void setVelocity(double x, double y, double z);
    public static AudioListener prototype;
    public AudioListener(){}
}

