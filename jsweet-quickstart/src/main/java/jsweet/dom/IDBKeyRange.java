package jsweet.dom;
/**  <div> <p>The <strong><code>IDBKeyRange</code></strong> interface of the IndexedDB API&nbsp;represents a continuous interval over some data type that is used for keys. Records can be retrieved from <code>IDBObjectStore</code> and <code>IDBIndex</code> objects using keys or a range of keys. You can limit the range using lower and upper bounds. For example, you can iterate over all values of a key in the value range A–Z.</p> </div> <p>A key range can be a single value or a range with upper and lower bounds or endpoints. If the key range has both upper and lower bounds, then it is <em>bounded</em>; if it has no bounds, it is <em>unbounded</em>. A bounded key range can either be open (the endpoints are excluded) or closed (the endpoints are included). To retrieve all keys within a certain range, you can use the following code constructs:</p> <table> <thead> <tr> <th>Range</th> <th>Code</th> </tr> <tr> <td>All keys ≤ <strong>x</strong></td> <td><code>IDBKeyRange.upperBound</code><code>(<strong>x</strong>)</code></td> </tr> <tr> <td>All keys &lt; <strong>x</strong></td> <td><code>IDBKeyRange.upperBound</code><code>(<strong>x</strong>, true) </code></td> </tr> <tr> <td>All keys ≥<strong> y</strong></td> <td><code>IDBKeyRange.lowerBound</code><code>(<strong>y</strong>)</code></td> </tr> <tr> <td>All keys &gt;<strong> y</strong></td> <td><code>IDBKeyRange.lowerBound</code><code>(<strong>y</strong>, true)</code></td> </tr> <tr> <td>All keys ≥ <strong>x</strong> &amp;&amp; ≤ <strong>y</strong></td> <td><code>IDBKeyRange.bound</code><code>(<strong>x</strong>, <strong>y</strong>)</code></td> </tr> <tr> <td>All keys &gt; <strong>x</strong> &amp;&amp;&lt; <strong>y</strong></td> <td><code>IDBKeyRange.bound</code><code>(<strong>x</strong>, <strong>y</strong>, true, true)</code></td> </tr> <tr> <td>All keys &gt; <strong>x</strong> &amp;&amp; ≤ <strong>y</strong></td> <td><code>IDBKeyRange.bound</code><code>(<strong>x</strong>, <strong>y</strong>, true, false)</code></td> </tr> <tr> <td>All keys ≥ <strong>x</strong> &amp;&amp;&lt; <strong>y</strong></td> <td><code>IDBKeyRange.bound</code><code>(<strong>x</strong>, <strong>y</strong>, false, true)</code></td> </tr> <tr> <td>The key = <strong>z</strong></td> <td><code>IDBKeyRange.only</code><code>(<strong>z</strong>)</code></td> </tr> </thead> </table> <p>A key is in a key range if the following conditions are true:</p> <ul> <li>The lower value of the key range is one of the following: <ul> <li><code>undefined</code></li> <li>Less than key value</li> <li>Equal to key value if <code>lowerOpen</code> is <code>false</code>.</li> </ul> </li> <li>The upper value of the key range is one of the following: <ul> <li><code>undefined</code></li> <li>Greater than key value</li> <li>Equal to key value if <code>upperOpen</code> is <code>false</code>.</li> </ul> </li> </ul> <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div>  */
public class IDBKeyRange extends jsweet.lang.Object {
    /** 
 Lower bound of the key range.  */
    public Object lower;
    /** 
 Returns false if the lower-bound value is included in the key range.  */
    public Boolean lowerOpen;
    /** 
 Upper bound of the key range.  */
    public Object upper;
    /** 
 Returns false if the upper-bound value is included in the key range.  */
    public Boolean upperOpen;
    public static IDBKeyRange prototype;
    public IDBKeyRange(){}
    /** 
 Creates a new key range with upper and lower bounds.  */
    native public static IDBKeyRange bound(Object lower, Object upper, Boolean lowerOpen, Boolean upperOpen);
    /** 
 Creates a new key range with only a lower bound.  */
    native public static IDBKeyRange lowerBound(Object bound, Boolean open);
    /** 
 Creates a new key range containing a single value.  */
    native public static IDBKeyRange only(Object value);
    /** 
 Creates a new upper-bound key range.  */
    native public static IDBKeyRange upperBound(Object bound, Boolean open);
    /** 
 Creates a new key range with upper and lower bounds.  */
    native public static IDBKeyRange bound(Object lower, Object upper, Boolean lowerOpen);
    /** 
 Creates a new key range with upper and lower bounds.  */
    native public static IDBKeyRange bound(Object lower, Object upper);
    /** 
 Creates a new key range with only a lower bound.  */
    native public static IDBKeyRange lowerBound(Object bound);
    /** 
 Creates a new upper-bound key range.  */
    native public static IDBKeyRange upperBound(Object bound);
}

