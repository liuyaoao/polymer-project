package org.jsweet.examples.polymerjs.components;

import static jsweet.util.StringTypes.load;


import def.polymer.polymer.Base;
import def.polymer.polymer.PropObjectType;
import static def.polymer.Globals.Polymer;
import static jsweet.util.StringTypes.error;
import static jsweet.dom.Globals.console;

import jsweet.dom.Event;
import jsweet.dom.ErrorEvent;
import jsweet.dom.EventListener;
import jsweet.dom.XMLHttpRequest;
import jsweet.lang.Array;
import jsweet.lang.Object;
import static jsweet.util.StringTypes.abort;
import jsweet.lang.Function;
import static jsweet.lang.JSON.parse;

//class CategoryData {
//	public String name;
//	public String title;
//	public String image;
//	public String placeholder;
//	public JSON items;
//};

public class ShopCategoryData extends Base {

	public ShopCategoryData() {
		this.is = "shop-category-data";
		console.log("created " + is);
	};
	
	class CategoryData extends Object{
		public String name;
		public String title;
		public String category;
		public double price;
		public String description;
		public String image;
		public String largeImage;
		public String placeholder;
	};

	public String categoryName;
    public String itemName;
    
    public CategoryData[]  categoriesList = {};
    
    public PropObjectType categories = new PropObjectType() {
		{
			type= Array.class;
			value= categoriesList;
			readOnly= true;
	        notify= true;
		}
	};
	public PropObjectType category = new PropObjectType() {
		{
			type= Object.class;
			computed="_computeCategory(categoryName)";
	        notify= true;
		}
	};
	public PropObjectType item = new PropObjectType() {
		{
			type= Object.class;
			computed="_computeItem(category.items, itemName)";
	        notify= true;
		}
	};
	public PropObjectType failure = new PropObjectType() {
		{
			type= Boolean.class;
			readOnly= true;
	        notify= true;
		}
	};
	public int attempts = 0;
	public String dataUrl = "";
	
	static {
		Polymer((Base)ShopCategoryData.prototype);
		console.log("registered Shop Category Data component");
	}
	@Override
	public void ready() {
		CategoryData[]  cate = {};
		categoriesList = cate;
	}
	@Override
	public void attached() {
		this.iniCategoryData();
	}

	public void iniCategoryData(){
		// Empty the array
		this.splice("categoriesList", 0, categoriesList.length);

		CategoryData categoryData = new CategoryData() {
			{
				name="mens_outerwear";
				title="Men's Outerwear";
				image="/jsweetpolymershop/images/mens_outerwear.jpg";
				placeholder="data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAXAABAQEAAAAAAAAAAAAAAAAAAAIEAQEAAAAAAAAAAAAAAAAAAAACEAAAAwYHAQAAAAAAAAAAAAAAERMBAhIyYhQhkaEDIwUVNREBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A3dkr5e8tfpwuneJITOzIcmQpit037Bw4mnCVNOpAAQv/2Q==";
			}
		};
		categoriesList[0]=categoryData;
		categoriesList[1] = new CategoryData() {
	        {
	            name= "ladies_outerwear";
	            title= "Ladies Outerwear";
	            image= "/jsweetpolymershop/images/ladies_outerwear.jpg";
	            placeholder= "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAWQABAQAAAAAAAAAAAAAAAAAAAAEBAQEAAAAAAAAAAAAAAAAAAAIDEAABAwMFAQAAAAAAAAAAAAARAAEygRIDIlITMwUVEQEBAAAAAAAAAAAAAAAAAAAAQf/aAAwDAQACEQMRAD8Avqn5meQ0kwk1UyclmLtNj7L4PQoioFf/2Q==";
	          }
		};
		categoriesList[2] = new CategoryData() {
	        {
	          name= "mens_tshirts";
	          title= "Men\"s T-Shirts";
	          image= "/jsweetpolymershop/images/mens_tshirts.jpg";
	          placeholder= "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAWwABAQEAAAAAAAAAAAAAAAAAAAMEAQEAAAAAAAAAAAAAAAAAAAAAEAABAwEJAAAAAAAAAAAAAAARAAESEyFhodEygjMUBREAAwAAAAAAAAAAAAAAAAAAAEFC/9oADAMBAAIRAxEAPwDb7kupZU1MTGnvOCgxpvzEXTyRElCmf//Z";
	        }
		};
		categoriesList[3] = new CategoryData() {
	        {
	          name= "ladies_tshirts";
	          title= "Ladies T-Shirts";
	          image= "/jsweetpolymershop/images/ladies_tshirts.jpg";
	          placeholder= "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAXwABAQEAAAAAAAAAAAAAAAAAAAMFAQEBAAAAAAAAAAAAAAAAAAABAhAAAQIDCQAAAAAAAAAAAAAAEQABITETYZECEjJCAzMVEQACAwAAAAAAAAAAAAAAAAAAATFBgf/aAAwDAQACEQMRAD8AzeADAZiFc5J7BC9Scek3VrtooilSNaf/2Q==";
	        }
		};
	};

    public CategoryData _getCategoryObject(String categoryName) {
    	CategoryData tempDt=null;
        for (int i = 0; i < categoriesList.length; ++i) {
          if (categoriesList[i].name == categoryName) {
        	  tempDt = categoriesList[i];
        	  break;
          }
        }
       return tempDt;
    };
    public CategoryData _computeCategory(String categoryName) {
    	CategoryData categoryObj = this._getCategoryObject(categoryName);
        this._fetchItems(categoryObj, 1);
        return categoryObj;
    }
    public CategoryData _computeItem(CategoryData[] items,String itemName) {
    	CategoryData item=null;
        for (int i = 0; i<items.length; ++i) {
        	item = items[i];
          if (item.name == itemName) {
            return item;
          }
        }
        return item;
    }
    public void _fetchItems(CategoryData category, int attempts) {
        this.failure.value = false;
        
        // Only fetch the items of a category if it has not been previously set.
        if (category == null || category.$get("items") == null) {
          return;
        }
        String url = "/jsweetpolymershop/data/" + category.name + ".json";
        this.dataUrl = url;
        this._getResource(url,attempts);
      }

	public void _getResource(String url, int attempts) {
		this.attempts = attempts;
		XMLHttpRequest xhr = new XMLHttpRequest();
		xhr.onload = this::onLoad;
        xhr.addEventListener(load, xhr.onload);
        xhr.addEventListener("error", event ->{
        	this.onErrorcall(event);
        });
        xhr.open("GET", url);
        xhr.send();
	}
	public Boolean onLoad(Event event){
		this.$set("category.items", parse((String)event.target.$get("responseText")));
		return true;
	}
	public Boolean onErrorcall(Event event){
		if (attempts > 1) {
			String[] parems = {"url","attempts"};
			Function func = new Function(parems);
            this.debounce("_getResource", func, 200);
	     } else {
	    	 this.failure.value = true;
	     }
		return true;
	}
    public void refresh(boolean b) {
    	if (this.categoryName != "") {
           this._fetchItems(this._getCategoryObject(this.categoryName), 3);
         }
	};

}
