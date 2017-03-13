package jsweet.dom;
/**  <p>The <strong><code>AnimationEvent</code></strong> interface represents events providing information related to animations.</p> <div> <pre> 
  &lt;div id=&quot;interfaceDiagram&quot; style=&quot;display: inline-block; position: relative; width: 100%; padding-bottom: 11.666666666666666%; vertical-align: middle; overflow: hidden;&quot;&gt;&lt;svg style=&quot;display: inline-block; position: absolute; top: 0; left: 0;&quot; viewbox=&quot;-50 0 600 70&quot; preserveAspectRatio=&quot;xMinYMin meet&quot;&gt;&lt;a xlink:href=&quot;https://developer.mozilla.org/en-US/docs/Web/API/Event&quot; target=&quot;_top&quot;&gt;&lt;rect x=&quot;1&quot; y=&quot;1&quot; width=&quot;75&quot; height=&quot;50&quot; fill=&quot;#fff&quot; stroke=&quot;#D4DDE4&quot; stroke-width=&quot;2px&quot; /&gt;&lt;text  x=&quot;38.5&quot; y=&quot;30&quot; font-size=&quot;12px&quot; font-family=&quot;Consolas,Monaco,Andale Mono,monospace&quot; fill=&quot;#4D4E53&quot; text-anchor=&quot;middle&quot; alignment-baseline=&quot;middle&quot;&gt;Event&lt;/text&gt;&lt;/a&gt;&lt;polyline points=&quot;76,25  86,20  86,30  76,25&quot; stroke=&quot;#D4DDE4&quot; fill=&quot;none&quot;/&gt;&lt;line x1=&quot;86&quot; y1=&quot;25&quot; x2=&quot;116&quot; y2=&quot;25&quot; stroke=&quot;#D4DDE4&quot;/&gt;&lt;a xlink:href=&quot;https://developer.mozilla.org/en-US/docs/Web/API/AnimationEvent&quot; target=&quot;_top&quot;&gt;&lt;rect x=&quot;116&quot; y=&quot;1&quot; width=&quot;140&quot; height=&quot;50&quot; fill=&quot;#F4F7F8&quot; stroke=&quot;#D4DDE4&quot; stroke-width=&quot;2px&quot; /&gt;&lt;text  x=&quot;186&quot; y=&quot;30&quot; font-size=&quot;12px&quot; font-family=&quot;Consolas,Monaco,Andale Mono,monospace&quot; fill=&quot;#4D4E53&quot; text-anchor=&quot;middle&quot; alignment-baseline=&quot;middle&quot;&gt;AnimationEvent&lt;/text&gt;&lt;/a&gt;&lt;/svg&gt;&lt;/div&gt; 
</pre> <pre> 
  a:hover text { fill: #0095DD; pointer-events: all;} 
</pre> </div> <iframe></iframe>  */
public class AnimationEvent extends Event {
    /** 
 Is a <code>DOMString</code> containing the value of the <code>animation-name</code> CSS property associated with the transition.  */
    public String animationName;
    /** 
 Is a <code>float</code> giving the amount of time the animation has been running, in seconds, when this event fired, excluding any time the animation was paused. For an <code>&quot;animationstart&quot;</code> event, <code>elapsedTime</code> is <code>0.0</code> unless there was a negative value for <code>animation-delay</code>, in which case the event will be fired with <code>elapsedTime</code> containing&nbsp; <code>(-1 * </code> <em>delay</em> <code>)</code>.  */
    public double elapsedTime;
    /** 
 Initializes a <code>AnimationEvent</code> created using the deprecated <code>Document.createEvent(&quot;AnimationEvent&quot;)</code> method.  */
    native public void initAnimationEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, String animationNameArg, double elapsedTimeArg);
    public static AnimationEvent prototype;
    public AnimationEvent(){}
}

