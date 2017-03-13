package jsweet.dom;
/** <div> <p><strong>Deprecated</strong><br></br>This feature has been removed from the Web standards. Though some browsers may still support it, it is in the process of being dropped. Do not use it in old or new projects. Pages or Web apps using it may break at any time.</p> </div> <p>Provides event properties that are specific to modifications to the Document Object Model (DOM) hierarchy and nodes.</p> <p><strong>Note</strong>&nbsp;&nbsp;Mutation Events (W3C DOM Level 3 Events) have been deprecated in favor of Mutation Observers (W3C DOM4)</p>  */
public class MutationEvent extends Event {
    public double attrChange;
    public String attrName;
    public String newValue;
    public String prevValue;
    public Node relatedNode;
    native public void initMutationEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Node relatedNodeArg, String prevValueArg, String newValueArg, String attrNameArg, double attrChangeArg);
    public double ADDITION;
    public double MODIFICATION;
    public double REMOVAL;
    public static MutationEvent prototype;
    public MutationEvent(){}
}

