package jsweet.dom;
public class TextRange extends jsweet.lang.Object {
    public double boundingHeight;
    public double boundingLeft;
    public double boundingTop;
    public double boundingWidth;
    public String htmlText;
    public double offsetLeft;
    public double offsetTop;
    public String text;
    native public void collapse(Boolean start);
    native public double compareEndPoints(String how, TextRange sourceRange);
    native public TextRange duplicate();
    native public Boolean execCommand(String cmdID, Boolean showUI, Object value);
    native public Boolean execCommandShowHelp(String cmdID);
    native public Boolean expand(String Unit);
    native public Boolean findText(String string, double count, double flags);
    native public String getBookmark();
    native public ClientRect getBoundingClientRect();
    native public ClientRectList getClientRects();
    native public Boolean inRange(TextRange range);
    native public Boolean isEqual(TextRange range);
    native public double move(String unit, double count);
    native public double moveEnd(String unit, double count);
    native public double moveStart(String unit, double count);
    native public Boolean moveToBookmark(String bookmark);
    native public void moveToElementText(Element element);
    native public void moveToPoint(double x, double y);
    native public Element parentElement();
    native public void pasteHTML(String html);
    native public Boolean queryCommandEnabled(String cmdID);
    native public Boolean queryCommandIndeterm(String cmdID);
    native public Boolean queryCommandState(String cmdID);
    native public Boolean queryCommandSupported(String cmdID);
    native public String queryCommandText(String cmdID);
    native public Object queryCommandValue(String cmdID);
    native public void scrollIntoView(Boolean fStart);
    native public void select();
    native public void setEndPoint(String how, TextRange SourceRange);
    public static TextRange prototype;
    public TextRange(){}
    native public void collapse();
    native public Boolean execCommand(String cmdID, Boolean showUI);
    native public Boolean execCommand(String cmdID);
    native public Boolean findText(String string, double count);
    native public Boolean findText(String string);
    native public double move(String unit);
    native public double moveEnd(String unit);
    native public double moveStart(String unit);
    native public void scrollIntoView();
}

