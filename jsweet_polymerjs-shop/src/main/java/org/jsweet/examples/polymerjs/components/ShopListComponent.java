package org.jsweet.examples.polymerjs.components;


import static def.polymer.Globals.Polymer;
import static jsweet.dom.Globals.console;
//import static jsweet.dom.Globals.localStorage;
import static jsweet.util.Globals.function;
import static jsweet.util.Globals.array;

import static jsweet.util.Globals.object;


import def.polymer.polymer.Base;
import def.polymer.polymer.PropObjectType;
//import def.polymer_ts.Polymer.*;
//import def.polymer_ts.polymer.FireOptions;
import jsweet.dom.HTMLElement;
import jsweet.lang.Function;
import jsweet.lang.Object;
import jsweet.lang.Array;
import jsweet.lang.Interface;

interface ShopCategoryDataI{
	void refresh();
}
public class ShopListComponent extends Base {

	public ShopListComponent() {
		this.is = "shop-list";
//		this.push("observers", "_categoryChanged(category, visible)");
		console.log("created " + is);
		this.observers[0] = "_categoryChanged(category, visible)";
	}

	static {
		Polymer((Base)ShopListComponent.prototype);
		console.log("registered Shop Home component");
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
	
	public CategoryData category;
	public Object route = new Object();
	public Object routeData = new Object();
	public Boolean failure;
	public Boolean visible;
	public String[] observers = {};
	public PropObjectType offline = new PropObjectType() {
		{
			type= Boolean.class;
			// value = false;
			observer= "_offlineChanged";
		}
	};

	@Override
	public void attached() {
		this.observers[0]= "_categoryChanged(category, visible)";
	}


	public void _offlineChanged(Boolean offline){
		if (!offline) {
			_tryReconnect();
		}
	}
	public void _tryReconnect() {
		ShopCategoryDataI shopCategoryDt = this.findInnerElement("categoryData");
		shopCategoryDt.refresh();
//		this.$.categoryData.refresh();
	}
	public void _categoryChanged(CategoryData cate, Boolean isvisible) {
		if (isvisible) {
			if (cate!=null) {
				this.fire("show-invalid-url-warning");
			} else {
//				this.debounce(jobName, callback);
				this.debounce("change-section", function(() -> {
					// Notify the category and the page's title
					Object obj = new Object();
					obj.$set("category", cate.name);
					obj.$set("title", cate.title);
					this.fire("change-section", obj);
				}),1);
			}
		}
	}
	
	public Array _getListItems(Array items) {
		// Return placeholder items when the items haven't loaded yet.
		Array tempItems = new Array();
		for(int i=0;i<9;i++){
			tempItems.push(new Object());
		}
		if(items != null){
			tempItems = items;
		}
		return tempItems;
	}
	public String _getItemHref(Object item) {
		// By returning null when `itemId` is undefined, the href attribute won't be set and
		// the link will be disabled.
		String tempStr = "";
		if(item.$get("name") != null && item.$get("name") != ""){
			tempStr = "/detail"+"/"+ this.category.name+"/"+item.$get("name");
		}else{
			tempStr = null;
		}
		return tempStr;
	}
	public String _getPluralizedQuantity(int quantity) {
		if (quantity==0) {
			return "";
		}
		String pluralizedQ = quantity == 1 ? "item" : "items";
		return  "(" + quantity + " " + pluralizedQ + ")";
	}
	protected <T> T findInnerElement(String id) {
		return (T) object($).$get(id);
	}

}
