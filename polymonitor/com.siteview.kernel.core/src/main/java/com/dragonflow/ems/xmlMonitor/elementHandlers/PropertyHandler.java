//   Date: 2005-3-8 13:55:28

 
// Source File Name:   PropertyHandler.java

package com.dragonflow.ems.xmlMonitor.elementHandlers;

import java.util.Vector;
import org.xml.sax.Attributes;

public interface PropertyHandler
{

    public abstract void handleProperty(Attributes attributes, Vector vector);

    public static final String STATE_OPTIONS = "stateOptions";
    public static final String DEF_VALUE = "value";
    public static final String NAME = "name";
    public static final String LABEL = "label";
    public static final String DESCRIPTION = "description";
    public static final String IS_ADVANCED = "isAdvanced";
    public static final String IS_EDITABLE = "isEditable";
    public static final String IS_THRESHOLD = "isThreshold";
    public static final String TRUE = "true";
}