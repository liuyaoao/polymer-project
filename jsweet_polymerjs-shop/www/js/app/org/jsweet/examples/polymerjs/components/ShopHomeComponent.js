/* Generated from Java with JSweet 1.2.0-SNAPSHOT - http://www.jsweet.org */
var org;
(function (org) {
    var jsweet;
    (function (jsweet) {
        var examples;
        (function (examples) {
            var polymerjs;
            (function (polymerjs) {
                var components;
                (function (components) {
                    var ShopHomeComponent = (function () {
                        function ShopHomeComponent() {
                            this.visible = Object.defineProperty({
                                type: Boolean,
                                value: false,
                                observer: "_visibleChanged"
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.categories = [];
                            this.is = "shop-home";
                            console.log("created " + this.is);
                        }
                        ShopHomeComponent.__static_initialize = function () { if (!ShopHomeComponent.__static_initialized) {
                            ShopHomeComponent.__static_initialized = true;
                            ShopHomeComponent.__static_initializer_0();
                        } };
                        ShopHomeComponent.__static_initializer_0 = function () {
                            Polymer(ShopHomeComponent.prototype);
                            console.log("registered Shop Home component");
                        };
                        ShopHomeComponent.prototype._visibleChanged = function (visible) {
                            if (visible) {
                                var obj = new Object();
                                obj["title"] = "Home";
                                this.fire("change-section", obj);
                            }
                        };
                        ShopHomeComponent.__static_initialized = false;
                        return ShopHomeComponent;
                    }());
                    components.ShopHomeComponent = ShopHomeComponent;
                    ShopHomeComponent["__class"] = "org.jsweet.examples.polymerjs.components.ShopHomeComponent";
                    ShopHomeComponent["__interfaces"] = ["def.polymer.polymer.Base"];
                    var ShopHomeComponent;
                    (function (ShopHomeComponent) {
                        var CategoryData = (function () {
                            function CategoryData(__parent) {
                                this.__parent = __parent;
                                this.price = 0;
                            }
                            return CategoryData;
                        }());
                        ShopHomeComponent.CategoryData = CategoryData;
                        CategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopHomeComponent.CategoryData";
                    })(ShopHomeComponent = components.ShopHomeComponent || (components.ShopHomeComponent = {}));
                })(components = polymerjs.components || (polymerjs.components = {}));
            })(polymerjs = examples.polymerjs || (examples.polymerjs = {}));
        })(examples = jsweet.examples || (jsweet.examples = {}));
    })(jsweet = org.jsweet || (org.jsweet = {}));
})(org || (org = {}));
org.jsweet.examples.polymerjs.components.ShopHomeComponent.__static_initialize();
