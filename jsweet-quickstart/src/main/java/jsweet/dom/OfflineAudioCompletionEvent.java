package jsweet.dom;
/**  <p>The Web Audio API <code>OfflineAudioCompletionEvent</code> interface represents events that occur when the processing of an <code>OfflineAudioContext</code> is terminated. The <code>complete</code> event implements this interface.</p> <div> <p><strong>Note</strong>: This interface is marked as deprecated; it is still supported for legacy reasons, but it will soon be superseded when the promise version of <code>OfflineAudioContext.startRendering</code> is supported in browsers, which will no longer need it.</p> </div>  */
public class OfflineAudioCompletionEvent extends Event {
    /** 
The buffer containing the result of the processing of an <code>OfflineAudioContext</code> */
    public AudioBuffer renderedBuffer;
    public static OfflineAudioCompletionEvent prototype;
    public OfflineAudioCompletionEvent(){}
}

