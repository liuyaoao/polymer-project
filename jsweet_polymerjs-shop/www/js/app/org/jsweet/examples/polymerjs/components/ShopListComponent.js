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
                    var ShopListComponent = (function () {
                        function ShopListComponent() {
                            this.route = new Object();
                            this.routeData = new Object();
                            this.observers = [];
                            this.offline = Object.defineProperty({
                                type: Boolean,
                                observer: "_offlineChanged"
                            }, '__interfaces', { configurable: true, value: ["def.polymer.polymer.PropObjectType"] });
                            this.is = "shop-list";
                            console.log("created " + this.is);
                            this.observers[0] = "_categoryChanged(category, visible)";
                        }
                        ShopListComponent.__static_initialize = function () { if (!ShopListComponent.__static_initialized) {
                            ShopListComponent.__static_initialized = true;
                            ShopListComponent.__static_initializer_0();
                        } };
                        ShopListComponent.__static_initializer_0 = function () {
                            Polymer(ShopListComponent.prototype);
                            console.log("registered Shop Home component");
                        };
                        ShopListComponent.prototype.attached = function () {
                            this.observers[0] = "_categoryChanged(category, visible)";
                        };
                        ShopListComponent.prototype._offlineChanged = function (offline) {
                            if (!offline) {
                                this._tryReconnect();
                            }
                        };
                        ShopListComponent.prototype._tryReconnect = function () {
                            var shopCategoryDt = this.findInnerElement("categoryData");
                            shopCategoryDt.refresh();
                        };
                        ShopListComponent.prototype._categoryChanged = function (cate, isvisible) {
                            var _this = this;
                            if (isvisible) {
                                if (cate != null) {
                                    this.fire("show-invalid-url-warning");
                                }
                                else {
                                    this.debounce("change-section", (function () {
                                        var obj = new Object();
                                        obj["category"] = cate.name;
                                        obj["title"] = cate.title;
                                        _this.fire("change-section", obj);
                                    }), 1);
                                }
                            }
                        };
                        ShopListComponent.prototype._getListItems = function (items) {
                            var tempItems = (new Array());
                            for (var i = 0; i < 9; i++) {
                                tempItems.push(new Object());
                            }
                            if (items != null) {
                                tempItems = items;
                            }
                            return tempItems;
                        };
                        ShopListComponent.prototype._getItemHref = function (item) {
                            var tempStr = "";
                            if (item["name"] != null && item["name"] !== "") {
                                tempStr = "/detail/" + this.category.name + "/" + item["name"];
                            }
                            else {
                                tempStr = null;
                            }
                            return tempStr;
                        };
                        ShopListComponent.prototype._getPluralizedQuantity = function (quantity) {
                            if (quantity === 0) {
                                return "";
                            }
                            var pluralizedQ = quantity === 1 ? "item" : "items";
                            return "(" + quantity + " " + pluralizedQ + ")";
                        };
                        ShopListComponent.prototype.findInnerElement = function (id) {
                            return (this.$)[id];
                        };
                        ShopListComponent.__static_initialized = false;
                        return ShopListComponent;
                    }());
                    components.ShopListComponent = ShopListComponent;
                    ShopListComponent["__class"] = "org.jsweet.examples.polymerjs.components.ShopListComponent";
                    ShopListComponent["__interfaces"] = ["def.polymer.polymer.Base"];
                    var ShopListComponent;
                    (function (ShopListComponent) {
                        var CategoryData = (function () {
                            function CategoryData(__parent) {
                                this.__parent = __parent;
                                this.price = 0;
                            }
                            return CategoryData;
                        }());
                        ShopListComponent.CategoryData = CategoryData;
                        CategoryData["__class"] = "org.jsweet.examples.polymerjs.components.ShopListComponent.CategoryData";
                    })(ShopListComponent = components.ShopListComponent || (components.ShopListComponent = {}));
                })(components = polymerjs.components || (polymerjs.components = {}));
            })(polymerjs = examples.polymerjs || (examples.polymerjs = {}));
        })(examples = jsweet.examples || (jsweet.examples = {}));
    })(jsweet = org.jsweet || (org.jsweet = {}));
})(org || (org = {}));
org.jsweet.examples.polymerjs.components.ShopListComponent.__static_initialize();
