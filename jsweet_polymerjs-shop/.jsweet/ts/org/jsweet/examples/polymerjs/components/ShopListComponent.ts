/* Generated from Java with JSweet 1.2.0-SNAPSHOT - http://www.jsweet.org */
namespace org.jsweet.examples.polymerjs.components {
    import Base = polymer.Base;

    import PropObjectType = polymer.PropObjectType;

    export interface ShopCategoryDataI {
        refresh();
    }

    export class ShopListComponent implements Base {
        static __static_initialized : boolean = false;
        static __static_initialize() { if(!ShopListComponent.__static_initialized) { ShopListComponent.__static_initialized = true; ShopListComponent.__static_initializer_0(); } }

        public constructor() {
            this.is = "shop-list";
            console.log("created " + this.is);
            this.observers[0] = "_categoryChanged(category, visible)";
        }

        static __static_initializer_0() {
            Polymer(<Base>ShopListComponent.prototype);
            console.log("registered Shop Home component");
        }

        public category : ShopListComponent.CategoryData;

        public route : Object = <Object>new Object();

        public routeData : Object = <Object>new Object();

        public failure : boolean;

        public visible : boolean;

        public observers : string[] = [];

        public offline : PropObjectType = <any>Object.defineProperty({
            type: Boolean,
            observer: "_offlineChanged"
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public attached() {
            this.observers[0] = "_categoryChanged(category, visible)";
        }

        public _offlineChanged(offline : boolean) {
            if(!offline) {
                this._tryReconnect();
            }
        }

        public _tryReconnect() {
            let shopCategoryDt : ShopCategoryDataI = this.findInnerElement<any>("categoryData");
            shopCategoryDt.refresh();
        }

        public _categoryChanged(cate : ShopListComponent.CategoryData, isvisible : boolean) {
            if(isvisible) {
                if(cate != null) {
                    this.fire("show-invalid-url-warning");
                } else {
                    this.debounce("change-section", (() => {
                        let obj : Object = <Object>new Object();
                        obj["category"] = cate.name;
                        obj["title"] = cate.title;
                        this.fire("change-section", obj);
                    }), 1);
                }
            }
        }

        public _getListItems(items : Array<any>) : Array<any> {
            let tempItems : Array<any> = <any>(new Array());
            for(let i : number = 0; i < 9; i++) {
                tempItems.push(<Object>new Object());
            }
            if(items != null) {
                tempItems = items;
            }
            return tempItems;
        }

        public _getItemHref(item : Object) : string {
            let tempStr : string = "";
            if(item["name"] != null && item["name"] !== "") {
                tempStr = "/detail/" + this.category.name + "/" + item["name"];
            } else {
                tempStr = null;
            }
            return tempStr;
        }

        public _getPluralizedQuantity(quantity : number) : string {
            if(quantity === 0) {
                return "";
            }
            let pluralizedQ : string = quantity === 1?"item":"items";
            return "(" + quantity + " " + pluralizedQ + ")";
        }

        findInnerElement<T>(id : string) : T {
            return <T>(this.$)[id];
        }
    }
    ShopListComponent["__class"] = "org.jsweet.examples.polymerjs.components.ShopListComponent";
    ShopListComponent["__interfaces"] = ["def.polymer.polymer.Base"];



    export namespace ShopListComponent {

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
        CategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopListComponent.CategoryData";

    }

}


org.jsweet.examples.polymerjs.components.ShopListComponent.__static_initialize();
