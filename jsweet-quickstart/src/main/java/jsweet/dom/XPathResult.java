package jsweet.dom;
/**  <dl> <dt> <code>XPathResult.booleanValue</code> </dt> <dd>
 readonly boolean </dd> </dl> <dl> <dt> <code>XPathResult.invalidIteratorState</code> </dt> <dd>
 readonly boolean </dd> </dl> <dl> <dt> <code>XPathResult.numberValue</code> </dt> <dd>
 readonly float </dd> </dl> <dl> <dt> <code>XPathResult.resultType</code> </dt> <dd>
 readonly integer (short) </dd> </dl> <dl> <dt> <code>XPathResult.singleNodeValue</code> </dt> <dd>
 readonly Node </dd> </dl> <dl> <dt> <code>XPathResult.snapshotLength</code> </dt> <dd>
 readonly Integer </dd> </dl> <dl> <dt> <code>XPathResult.stringValue</code> </dt> <dd>
 readonly String </dd> </dl>  */
public class XPathResult extends jsweet.lang.Object {
    /** 
 readonly boolean  */
    public Boolean booleanValue;
    /** 
 readonly boolean  */
    public Boolean invalidIteratorState;
    /** 
 readonly float  */
    public double numberValue;
    /** 
 readonly integer (short)  */
    public double resultType;
    /** 
 readonly Node  */
    public Node singleNodeValue;
    /** 
 readonly Integer  */
    public double snapshotLength;
    /** 
 readonly String  */
    public String stringValue;
    /** 
 ...  */
    native public Node iterateNext();
    /** 
 ...  */
    native public Node snapshotItem(double index);
    /** 
A result set containing whatever type naturally results from evaluation of the expression. Note that if the result is a node-set then UNORDERED_NODE_ITERATOR_TYPE is always the resulting type. */
    public double ANY_TYPE;
    /** 
A result node-set containing any single node that matches the expression. The node is not necessarily the first node in the document that matches the expression. */
    public double ANY_UNORDERED_NODE_TYPE;
    /** 
A result containing a single boolean value. This is useful for example, in an XPath expression using the <code>not()</code> function. */
    public double BOOLEAN_TYPE;
    /** 
A result node-set containing the first node in the document that matches the expression. */
    public double FIRST_ORDERED_NODE_TYPE;
    /** 
A result containing a single number. This is useful for example, in an XPath expression using the <code>count()</code> function. */
    public double NUMBER_TYPE;
    /** 
A result node-set containing all the nodes matching the expression. The nodes in the result set are in the same order that they appear in the document. */
    public double ORDERED_NODE_ITERATOR_TYPE;
    /** 
A result node-set containing snapshots of all the nodes matching the expression. The nodes in the result set are in the same order that they appear in the document. */
    public double ORDERED_NODE_SNAPSHOT_TYPE;
    /** 
A result containing a single string. */
    public double STRING_TYPE;
    /** 
A result node-set containing all the nodes matching the expression. The nodes may not necessarily be in the same order that they appear in the document. */
    public double UNORDERED_NODE_ITERATOR_TYPE;
    /** 
A result node-set containing snapshots of all the nodes matching the expression. The nodes may not necessarily be in the same order that they appear in the document. */
    public double UNORDERED_NODE_SNAPSHOT_TYPE;
    public static XPathResult prototype;
    public XPathResult(){}
}

