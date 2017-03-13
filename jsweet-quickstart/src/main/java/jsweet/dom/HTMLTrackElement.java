package jsweet.dom;
/** <p>The&nbsp;<strong><code>HTMLTrackElement</code></strong>&nbsp;interface provides access to the properties of <code>&lt;track&gt;</code> elements, as well as methods to manipulate them.</p>  */
public class HTMLTrackElement extends HTMLElement {
    @jsweet.lang.Name("default")
    public Boolean Default;
    /** 
Reflects the <code>kind</code>&nbsp;HTML attribute,&nbsp;indicating&nbsp;how the text track is meant to be used. Possible values are: subtitles, captions, descriptions, chapters, metadata. See&nbsp;<code>kind</code>&nbsp;attribute documentation for details. */
    public String kind;
    /** 
Reflects the&nbsp;<code>label</code>&nbsp;HTML attribute,&nbsp;indicating&nbsp;a user-readable title for the track. */
    public String label;
    /** <p>The readiness state of the track.</p> <table> <tbody> <tr> <td>Constant</td> <td>Value</td> <td>Description</td> </tr> <tr> <td><code>NONE</code></td> <td>0</td> <td>Indicates that the text track's cues have not been obtained.</td> </tr> <tr> <td><code>LOADING</code></td> <td>1</td> <td>Indicates that the text track is loading and there have been no fatal errors encountered so far. Further cues might still be added to the track by the parser.</td> </tr> <tr> <td><code>LOADED</code></td> <td>2</td> <td>Indicates that the text track has been loaded with no fatal errors.</td> </tr> <tr> <td><code>ERROR</code></td> <td>3</td> <td>Indicates that the text track was enabled, but when the user agent attempted to obtain it, this failed in some way. Some or all of the cues are likely missing and will not be obtained.</td> </tr> </tbody> </table>  */
    public double readyState;
    /** 
Reflects the&nbsp;<code>src</code>&nbsp;HTML attribute, indicating the address of the text track data. */
    public String src;
    /** 
Reflects the&nbsp;<code>srclang</code>&nbsp;HTML attribute,&nbsp;indicating the language of the text track data. */
    public String srclang;
    /** 
The track element's text track data. */
    public TextTrack track;
    /** 
Indicates that the text track was enabled, but when the user agent attempted to obtain it, this failed in some way. Some or all of the cues are likely missing and will not be obtained. */
    public double ERROR;
    /** 
Indicates that the text track has been loaded with no fatal errors. */
    public double LOADED;
    /** 
Indicates that the text track is loading and there have been no fatal errors encountered so far. Further cues might still be added to the track by the parser. */
    public double LOADING;
    /** 
Indicates that the text track's cues have not been obtained. */
    public double NONE;
    public static HTMLTrackElement prototype;
    public HTMLTrackElement(){}
}

