/* Generated from Java with JSweet 1.2.0-SNAPSHOT - http://www.jsweet.org */
namespace org.jsweet.examples.polymerjs.components {
    import Base = polymer.Base;

    import PropObjectType = polymer.PropObjectType;

    export class ShopCategoryData implements Base {
        static __static_initialized : boolean = false;
        static __static_initialize() { if(!ShopCategoryData.__static_initialized) { ShopCategoryData.__static_initialized = true; ShopCategoryData.__static_initializer_0(); } }

        public constructor() {
            this.is = "shop-category-data";
            console.log("created " + this.is);
        }

        public categoryName : string;

        public itemName : string;

        public categoriesList : ShopCategoryData.CategoryData[] = [];

        public categories : PropObjectType = <any>Object.defineProperty({
            type: Array,
            value: this.categoriesList,
            readOnly: true,
            notify: true
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public category : PropObjectType = <any>Object.defineProperty({
            type: Object,
            computed: "_computeCategory(categoryName)",
            notify: true
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public item : PropObjectType = <any>Object.defineProperty({
            type: Object,
            computed: "_computeItem(category.items, itemName)",
            notify: true
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public failure : PropObjectType = <any>Object.defineProperty({
            type: Boolean,
            readOnly: true,
            notify: true
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public attempts : number = 0;

        public dataUrl : string = "";

        static __static_initializer_0() {
            Polymer(<Base>ShopCategoryData.prototype);
            console.log("registered Shop Category Data component");
        }

        public ready() {
            let cate : ShopCategoryData.CategoryData[] = [];
            this.categoriesList = cate;
        }

        public attached() {
            this.iniCategoryData();
        }

        public iniCategoryData() {
            this.splice("categoriesList", 0, this.categoriesList.length);
            let categoryData : ShopCategoryData.CategoryData = ((target:ShopCategoryData.CategoryData) => {
                target['name'] = "mens_outerwear";
                target['title'] = "Men\'s Outerwear";
                target['image'] = "/jsweetpolymershop/images/mens_outerwear.jpg";
                target['placeholder'] = "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAXAABAQEAAAAAAAAAAAAAAAAAAAIEAQEAAAAAAAAAAAAAAAAAAAACEAAAAwYHAQAAAAAAAAAAAAAAERMBAhIyYhQhkaEDIwUVNREBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A3dkr5e8tfpwuneJITOzIcmQpit037Bw4mnCVNOpAAQv/2Q==";
                return target;

            })(new ShopCategoryData.CategoryData());
            this.categoriesList[0] = categoryData;
            this.categoriesList[1] = ((target:ShopCategoryData.CategoryData) => {
                target['name'] = "ladies_outerwear";
                target['title'] = "Ladies Outerwear";
                target['image'] = "/jsweetpolymershop/images/ladies_outerwear.jpg";
                target['placeholder'] = "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAWQABAQAAAAAAAAAAAAAAAAAAAAEBAQEAAAAAAAAAAAAAAAAAAAIDEAABAwMFAQAAAAAAAAAAAAARAAEygRIDIlITMwUVEQEBAAAAAAAAAAAAAAAAAAAAQf/aAAwDAQACEQMRAD8Avqn5meQ0kwk1UyclmLtNj7L4PQoioFf/2Q==";
                return target;

            })(new ShopCategoryData.CategoryData());
            this.categoriesList[2] = ((target:ShopCategoryData.CategoryData) => {
                target['name'] = "mens_tshirts";
                target['title'] = "Men\"s T-Shirts";
                target['image'] = "/jsweetpolymershop/images/mens_tshirts.jpg";
                target['placeholder'] = "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAWwABAQEAAAAAAAAAAAAAAAAAAAMEAQEAAAAAAAAAAAAAAAAAAAAAEAABAwEJAAAAAAAAAAAAAAARAAESEyFhodEygjMUBREAAwAAAAAAAAAAAAAAAAAAAEFC/9oADAMBAAIRAxEAPwDb7kupZU1MTGnvOCgxpvzEXTyRElCmf//Z";
                return target;

            })(new ShopCategoryData.CategoryData());
            this.categoriesList[3] = ((target:ShopCategoryData.CategoryData) => {
                target['name'] = "ladies_tshirts";
                target['title'] = "Ladies T-Shirts";
                target['image'] = "/jsweetpolymershop/images/ladies_tshirts.jpg";
                target['placeholder'] = "data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAAeAAD/7gAOQWRvYmUAZMAAAAAB/9sAhAAQCwsLDAsQDAwQFw8NDxcbFBAQFBsfFxcXFxcfHhcaGhoaFx4eIyUnJSMeLy8zMy8vQEBAQEBAQEBAQEBAQEBAAREPDxETERUSEhUUERQRFBoUFhYUGiYaGhwaGiYwIx4eHh4jMCsuJycnLis1NTAwNTVAQD9AQEBAQEBAQEBAQED/wAARCAADAA4DASIAAhEBAxEB/8QAXwABAQEAAAAAAAAAAAAAAAAAAAMFAQEBAAAAAAAAAAAAAAAAAAABAhAAAQIDCQAAAAAAAAAAAAAAEQABITETYZECEjJCAzMVEQACAwAAAAAAAAAAAAAAAAAAATFBgf/aAAwDAQACEQMRAD8AzeADAZiFc5J7BC9Scek3VrtooilSNaf/2Q==";
                return target;

            })(new ShopCategoryData.CategoryData());
        }

        public _getCategoryObject(categoryName : string) : ShopCategoryData.CategoryData {
            let tempDt : ShopCategoryData.CategoryData = null;
            for(let i : number = 0; i < this.categoriesList.length; ++i) {
                if(this.categoriesList[i].name === categoryName) {
                    tempDt = this.categoriesList[i];
                    break;
                }
            }
            return tempDt;
        }

        public _computeCategory(categoryName : string) : ShopCategoryData.CategoryData {
            let categoryObj : ShopCategoryData.CategoryData = this._getCategoryObject(categoryName);
            this._fetchItems(categoryObj, 1);
            return categoryObj;
        }

        public _computeItem(items : ShopCategoryData.CategoryData[], itemName : string) : ShopCategoryData.CategoryData {
            let item : ShopCategoryData.CategoryData = null;
            for(let i : number = 0; i < items.length; ++i) {
                item = items[i];
                if(item.name === itemName) {
                    return item;
                }
            }
            return item;
        }

        public _fetchItems(category : ShopCategoryData.CategoryData, attempts : number) {
            this.failure.value = false;
            if(category == null || category["items"] == null) {
                return;
            }
            let url : string = "/jsweetpolymershop/data/" + category.name + ".json";
            this.dataUrl = url;
            this._getResource(url, attempts);
        }

        public _getResource(url : string, attempts : number) {
            this.attempts = attempts;
            let xhr : XMLHttpRequest = new XMLHttpRequest();
            xhr.onload = (event) => { return this.onLoad(event) };
            xhr.addEventListener("load", xhr.onload);
            xhr.addEventListener("error", (event) => {
                this.onErrorcall(event);
            });
            xhr.open("GET", url);
            xhr.send();
        }

        public onLoad(event : Event) : boolean {
            this["category.items"] = JSON.parse(<string>event.target["responseText"]);
            return true;
        }

        public onErrorcall(event : Event) : boolean {
            if(this.attempts > 1) {
                let parems : string[] = ["url", "attempts"];
                let func : Function = new Function(parems);
                this.debounce("_getResource", func, 200);
            } else {
                this.failure.value = true;
            }
            return true;
        }

        public refresh(b : boolean) {
            if(this.categoryName !== "") {
                this._fetchItems(this._getCategoryObject(this.categoryName), 3);
            }
        }
    }
    ShopCategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopCategoryData";
    ShopCategoryData["__interfaces"] = ["def.polymer.polymer.Base"];



    export namespace ShopCategoryData {

        export class CategoryData {
            public __parent: any;
            public name : string;

            public title : string;

            public category : string;

            public price : number;

            public description : string;

            public image : string;

            public largeImage : string;

            public placeholder : string;

            constructor(__parent: any) {
                this.__parent = __parent;
                this.price = 0;
            }
        }
        CategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopCategoryData.CategoryData";

    }

}


org.jsweet.examples.polymerjs.components.ShopCategoryData.__static_initialize();
