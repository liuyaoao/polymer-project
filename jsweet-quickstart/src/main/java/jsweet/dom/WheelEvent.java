package jsweet.dom;
/**  <p>The <strong><code>WheelEvent</code></strong> interface represents events that occur due to the user moving a mouse wheel or similar input device.</p> <div> <p><strong>This is the standard wheel event interface to use.</strong></p> <p>Old versions of browsers implemented the two non-standard and non-cross-browser-compatible <code>MouseWheelEvent</code> and <code>MouseScrollEvent</code> interfaces. Use this interface and avoid the latter two.</p> </div> <div> <pre> 
  &lt;div id=&quot;interfaceDiagram&quot; style=&quot;display: inline-block; position: relative; width: 100%; padding-bottom: 11.666666666666666%; vertical-align: middle; overflow: hidden;&quot;&gt;&lt;svg style=&quot;display: inline-block; position: absolute; top: 0; left: 0;&quot; viewbox=&quot;-50 0 600 70&quot; preserveAspectRatio=&quot;xMinYMin meet&quot;&gt;&lt;a xlink:href=&quot;https://developer.mozilla.org/en-US/docs/Web/API/Event&quot; target=&quot;_top&quot;&gt;&lt;rect x=&quot;1&quot; y=&quot;1&quot; width=&quot;75&quot; height=&quot;50&quot; fill=&quot;#fff&quot; stroke=&quot;#D4DDE4&quot; stroke-width=&quot;2px&quot; /&gt;&lt;text  x=&quot;38.5&quot; y=&quot;30&quot; font-size=&quot;12px&quot; font-family=&quot;Consolas,Monaco,Andale Mono,monospace&quot; fill=&quot;#4D4E53&quot; text-anchor=&quot;middle&quot; alignment-baseline=&quot;middle&quot;&gt;Event&lt;/text&gt;&lt;/a&gt;&lt;polyline points=&quot;76,25  86,20  86,30  76,25&quot; stroke=&quot;#D4DDE4&quot; fill=&quot;none&quot;/&gt;&lt;line x1=&quot;86&quot; y1=&quot;25&quot; x2=&quot;116&quot; y2=&quot;25&quot; stroke=&quot;#D4DDE4&quot;/&gt;&lt;a xlink:href=&quot;https://developer.mozilla.org/en-US/docs/Web/API/UIEvent&quot; target=&quot;_top&quot;&gt;&lt;rect x=&quot;116&quot; y=&quot;1&quot; width=&quot;75&quot; height=&quot;50&quot; fill=&quot;#fff&quot; stroke=&quot;#D4DDE4&quot; stroke-width=&quot;2px&quot; /&gt;&lt;text  x=&quot;153.5&quot; y=&quot;30&quot; font-size=&quot;12px&quot; font-family=&quot;Consolas,Monaco,Andale Mono,monospace&quot; fill=&quot;#4D4E53&quot; text-anchor=&quot;middle&quot; alignment-baseline=&quot;middle&quot;&gt;UIEvent&lt;/text&gt;&lt;/a&gt;&lt;polyline points=&quot;191,25  201,20  201,30  191,25&quot; stroke=&quot;#D4DDE4&quot; fill=&quot;none&quot;/&gt;&lt;line x1=&quot;201&quot; y1=&quot;25&quot; x2=&quot;231&quot; y2=&quot;25&quot; stroke=&quot;#D4DDE4&quot;/&gt;&lt;a xlink:href=&quot;https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent&quot; target=&quot;_top&quot;&gt;&lt;rect x=&quot;231&quot; y=&quot;1&quot; width=&quot;100&quot; height=&quot;50&quot; fill=&quot;#fff&quot; stroke=&quot;#D4DDE4&quot; stroke-width=&quot;2px&quot; /&gt;&lt;text  x=&quot;281&quot; y=&quot;30&quot; font-size=&quot;12px&quot; font-family=&quot;Consolas,Monaco,Andale Mono,monospace&quot; fill=&quot;#4D4E53&quot; text-anchor=&quot;middle&quot; alignment-baseline=&quot;middle&quot;&gt;MouseEvent&lt;/text&gt;&lt;/a&gt;&lt;polyline points=&quot;331,25  341,20  341,30  331,25&quot; stroke=&quot;#D4DDE4&quot; fill=&quot;none&quot;/&gt;&lt;line x1=&quot;341&quot; y1=&quot;25&quot; x2=&quot;371&quot; y2=&quot;25&quot; stroke=&quot;#D4DDE4&quot;/&gt;&lt;a xlink:href=&quot;https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent&quot; target=&quot;_top&quot;&gt;&lt;rect x=&quot;371&quot; y=&quot;1&quot; width=&quot;100&quot; height=&quot;50&quot; fill=&quot;#F4F7F8&quot; stroke=&quot;#D4DDE4&quot; stroke-width=&quot;2px&quot; /&gt;&lt;text  x=&quot;421&quot; y=&quot;30&quot; font-size=&quot;12px&quot; font-family=&quot;Consolas,Monaco,Andale Mono,monospace&quot; fill=&quot;#4D4E53&quot; text-anchor=&quot;middle&quot; alignment-baseline=&quot;middle&quot;&gt;WheelEvent&lt;/text&gt;&lt;/a&gt;&lt;/svg&gt;&lt;/div&gt; 
</pre> <pre> 
  a:hover text { fill: #0095DD; pointer-events: all;} 
</pre> </div> <iframe></iframe>  */
public class WheelEvent extends MouseEvent {
    /** 
 Returns an <code>unsigned long</code> representing the unit of the delta values scroll amount. Permitted values are: <table> <tbody> <tr> <td>Constant</td> <td>Value</td> <td>Description</td> </tr> <tr> <td><code>DOM_DELTA_PIXEL</code></td> <td><code>0x00</code></td> <td>The delta values are specified in pixels.</td> </tr> <tr> <td><code>DOM_DELTA_LINE</code></td> <td><code>0x01</code></td> <td>The delta values are specified in lines.</td> </tr> <tr> <td><code>DOM_DELTA_PAGE</code></td> <td><code>0x02</code></td> <td>The delta values are specified in pages.</td> </tr> </tbody> </table>  */
    public double deltaMode;
    /** 
 Returns a <code>double</code> representing the horizontal scroll amount.  */
    public double deltaX;
    /** 
 Returns a <code>double</code> representing the vertical scroll amount.  */
    public double deltaY;
    /** 
 Returns a <code>double</code> representing the scroll amount for the z-axis.  */
    public double deltaZ;
    native public void getCurrentPoint(Element element);
    native public void initWheelEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Window viewArg, double detailArg, double screenXArg, double screenYArg, double clientXArg, double clientYArg, double buttonArg, EventTarget relatedTargetArg, String modifiersListArg, double deltaXArg, double deltaYArg, double deltaZArg, double deltaMode);
    /** 
The delta values are specified in lines. */
    public double DOM_DELTA_LINE;
    /** 
The delta values are specified in pages. */
    public double DOM_DELTA_PAGE;
    /** 
The delta values are specified in pixels. */
    public double DOM_DELTA_PIXEL;
    public static WheelEvent prototype;
    public WheelEvent(String typeArg, WheelEventInit eventInitDict){}
    public WheelEvent(String typeArg){}
    protected WheelEvent(){}
}

