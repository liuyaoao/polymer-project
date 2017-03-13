package jsweet.dom;
/**  <p>A CDATA Section can be used within XML to include extended portions of unescaped text, such that the symbols &lt; and &amp; do not need escaping as they normally do within XML when used as text.</p> <p>It takes the form:</p> <pre>&lt;![CDATA[  ... ]]&gt;
</pre> <p>For example:</p> <pre>&lt;foo&gt;Here is a CDATA section: &lt;![CDATA[  &lt; &gt; &amp; ]]&gt; with all kinds of unescaped text. &lt;/foo&gt;
</pre> <p>The only sequence which is not allowed within a CDATA section is the closing sequence of a CDATA section itself:</p> <pre>&lt;![CDATA[  ]]&gt; will cause an error   ]]&gt;
</pre> <p>Note that CDATA sections should not be used (without hiding) within HTML.</p> <p>As a CDATASection has no properties or methods unique to itself and only directly implements the Text interface, one can refer to <code>Text</code> to find its properties and methods.</p>  */
public class CDATASection extends Text {
    public static CDATASection prototype;
    public CDATASection(){}
}

