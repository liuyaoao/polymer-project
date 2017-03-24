package org.jsweet.examples.polymerjs.components;

import static def.polymer.Globals.Polymer;
import static jsweet.dom.Globals.console;
import jsweet.lang.Object;
import def.polymer.polymer.Base;
import def.polymer.polymer.PropObjectType;
import jsweet.dom.HTMLElement;
import jsweet.lang.Interface;

public class ShopHomeComponent extends Base {

	public ShopHomeComponent() {
		this.is = "shop-home";
		console.log("created " + is);
	}

	class CategoryData {
		public String name;
		public String title;
		public String category;
		public double price;
		public String description;
		public String image;
		public String largeImage;
		public String placeholder;
	};

	static {
		Polymer((Base)ShopHomeComponent.prototype);
		console.log("registered Shop Home component");
	}

	public PropObjectType visible = new PropObjectType() {
		{
			type= Boolean.class;
			value = false;
	    observer= "_visibleChanged";
		}
	};
	public CategoryData[] categories = {};

	public void _visibleChanged(Boolean visible){
		if (visible) {
			Object obj = new Object();
			obj.$set("title","Home");
      this.fire("change-section", obj);
    }
	}

}
