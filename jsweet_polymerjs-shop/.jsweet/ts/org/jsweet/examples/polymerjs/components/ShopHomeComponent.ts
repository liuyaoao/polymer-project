/* Generated from Java with JSweet 1.2.0-SNAPSHOT - http://www.jsweet.org */
namespace org.jsweet.examples.polymerjs.components {
    import Base = polymer.Base;

    import PropObjectType = polymer.PropObjectType;

    export class ShopHomeComponent implements Base {
        static __static_initialized : boolean = false;
        static __static_initialize() { if(!ShopHomeComponent.__static_initialized) { ShopHomeComponent.__static_initialized = true; ShopHomeComponent.__static_initializer_0(); } }

        public constructor() {
            this.is = "shop-home";
            console.log("created " + this.is);
        }

        static __static_initializer_0() {
            Polymer(<Base>ShopHomeComponent.prototype);
            console.log("registered Shop Home component");
        }

        public visible : PropObjectType = <any>Object.defineProperty({
            type: Boolean,
            value: false,
            observer: "_visibleChanged"
        }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });

        public categories : ShopHomeComponent.CategoryData[] = [];

        public _visibleChanged(visible : boolean) {
            if(visible) {
                let obj : Object = <Object>new Object();
                obj["title"] = "Home";
                this.fire("change-section", obj);
            }
        }
    }
    ShopHomeComponent["__class"] = "org.jsweet.examples.polymerjs.components.ShopHomeComponent";
    ShopHomeComponent["__interfaces"] = ["def.polymer.polymer.Base"];



    export namespace ShopHomeComponent {

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
        CategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopHomeComponent.CategoryData";

    }

}


org.jsweet.examples.polymerjs.components.ShopHomeComponent.__static_initialize();
