/*
Originla base : https://github.com/troolee/gridstack.js
credit to : (c) 2014-2017 Pavel Reznikov, Dylan Weiss
Modified for polymer support
Polymer Addition : Vinod Louis
*/

(function (scope, _) {

    var Utils = {
        is_intercepted: function (a, b) {
            return !(a.x + a.width <= b.x || b.x + b.width <= a.x || a.y + a.height <= b.y || b.y + b.height <= a.y);
        }
    };

    var id_seq = 0;

    var GridStackEngine = function (width, onchange) {
        this.width = width;

        this.nodes = [];
        this.onchange = onchange || function () {};
    };

    GridStackEngine.prototype._fix_collisions = function (node) {
        this.nodes = _.sortBy(this.nodes, function (n) { return -(n.x + n.y * this.width); }, this);

        while (true) {
            var collision_node = _.find(this.nodes, function (n) {
                return n != node && Utils.is_intercepted(n, node);
            }, this);
            if (typeof collision_node == 'undefined') {
                return;
            }
            this.move_node(collision_node, collision_node.x, node.y + node.height,
                collision_node.width, collision_node.height, true);
        }
    };

    GridStackEngine.prototype._pack_nodes = function () {
        this.nodes = _.sortBy(this.nodes, function (n) { return n.x + n.y * this.width; }, this);

        _.each(this.nodes, function (n, i) {
            while (n.y > 0) {
                var new_y = n.y - 1;
                var can_be_moved = i == 0;

                if (i > 0) {
                    var collision_node = _.chain(this.nodes)
                        .first(i)
                        .find(function (bn) {
                            return Utils.is_intercepted({x: n.x, y: new_y, width: n.width, height: n.height}, bn);
                        })
                        .value();
                    can_be_moved = typeof collision_node == 'undefined';
                }

                if (!can_be_moved) {
                    break;
                }
                n.y = new_y;
            }
        }, this);
    };

    GridStackEngine.prototype._prepare_node = function (node, moving) {
        node = _.defaults(node || {}, {width: 1, height: 1, x: 0, y: 0 });

        node.x = parseInt('' + node.x);
        node.y = parseInt('' + node.y);
        node.width = parseInt('' + node.width);
        node.height = parseInt('' + node.height);

        if (node.width > this.width) {
            node.width = this.width;
        }
        else if (node.width < 1) {
            node.width = 1;
        }

        if (node.height < 1) {
            node.height = 1;
        }

        if (node.x < 0) {
            node.x = 0;
        }

        if (node.x + node.width > this.width) {
            if (moving) {
                node.x = this.width - node.width;
            }
            else {
                node.width = this.width - node.x;
            }
        }

        if (node.y < 0) {
            node.y = 0;
        }

        return node;
    };

    GridStackEngine.prototype._notify = function () {
        this.onchange(this.nodes);
    };

    GridStackEngine.prototype.add_node = function(node) {
        node = this._prepare_node(node);

        if (typeof node.max_width != 'undefined') node.width = Math.min(node.width, node.max_width);
        if (typeof node.max_height != 'undefined') node.height = Math.min(node.height, node.max_height);
        if (typeof node.min_width != 'undefined') node.width = Math.max(node.width, node.min_width);
        if (typeof node.min_height != 'undefined') node.height = Math.max(node.height, node.min_height);

        node._id = ++id_seq;
        this.nodes.push(node);
        this._fix_collisions(node);
        this._pack_nodes();
        this._notify();
        return node;
    };

    GridStackEngine.prototype.remove_node = function (node) {
        node._id = null;
        this.nodes = _.without(this.nodes, node);
        this._pack_nodes();
        this._notify(node);
    };

    GridStackEngine.prototype.move_node = function (node, x, y, width, height, no_pack) {
        if (typeof x == 'undefined') x = node.x;
        if (typeof y == 'undefined') y = node.y;
        if (typeof width == 'undefined') width = node.width;
        if (typeof height == 'undefined') height = node.height;

        if (typeof node.max_width != 'undefined') width = Math.min(width, node.max_width);
        if (typeof node.max_height != 'undefined') height = Math.min(height, node.max_height);
        if (typeof node.min_width != 'undefined') width = Math.max(width, node.min_width);
        if (typeof node.min_height != 'undefined') height = Math.max(height, node.min_height);

        if (node.x == x && node.y == y && node.width == width && node.height == height) {
            return node;
        }

        var moving = node.x != x;

        node.x = x;
        node.y = y;
        node.width = width;
        node.height = height;

        node = this._prepare_node(node, moving);

        this._fix_collisions(node);
        if (!no_pack) {
            this._pack_nodes();
            this._notify();
        }
        return node;
    };

    GridStackEngine.prototype.get_grid_height = function () {
        return _.reduce(this.nodes, function (memo, n) { return Math.max(memo, n.y + n.height); }, 0);
    };

    var GridStack = function (el, opts) {
        var self = this;

        this.container = $(el);

        this.opts = _.defaults(opts || {}, {
            width: 12,
            item_class: 'grid-stack-item',
            placeholder_class: 'grid-stack-placeholder',
            handle: '.grid-stack-item-content',
            cell_height: 60,
            vertical_margin: 20
        });

        this.grid = new GridStackEngine(this.opts.width, function (nodes) {
            _.each(nodes, function (n) {
                n.el
                    .attr('data-gs-x', n.x)
                    .attr('data-gs-y', n.y)
                    .attr('data-gs-width', n.width)
                    .attr('data-gs-height', n.height);
            });
        });

        this.container.find('.' + this.opts.item_class).each(function (index, el) {
            self._prepare_element(el);
        });

        this.placeholder = $('<div class="' + this.opts.placeholder_class + ' ' + this.opts.item_class + '"><div class="placeholder-content" /></div>').hide();
        this.container.append(this.placeholder);
        this.container.height((this.grid.get_grid_height()) * (this.opts.cell_height + this.opts.vertical_margin) - this.opts.vertical_margin);
    };

    GridStack.prototype._update_container_height = function () {
        this.container.height(this.grid.get_grid_height() * (this.opts.cell_height + this.opts.vertical_margin) - this.opts.vertical_margin);
    };

    GridStack.prototype._prepare_element = function (el) {
        var self = this;
        el = $(el);

        var node = self.grid.add_node({
            x: el.attr('data-gs-x'),
            y: el.attr('data-gs-y'),
            width: el.attr('data-gs-width'),
            height: el.attr('data-gs-height'),
            max_width: el.attr('data-gs-max-width'),
            min_width: el.attr('data-gs-min-width'),
            max_height: el.attr('data-gs-max-height'),
            min_height: el.attr('data-gs-min-height'),
            el: el
        });
        el.data('_gridstack_node', node);

        var cell_width, cell_height = this.opts.cell_height + this.opts.vertical_margin / 2;

        var on_start_moving = function (event, ui) {
            var o = $(this);
            cell_width = Math.ceil(o.outerWidth() / o.attr('data-gs-width'));
            self.placeholder
                .attr('data-gs-x', o.attr('data-gs-x'))
                .attr('data-gs-y', o.attr('data-gs-y'))
                .attr('data-gs-width', o.attr('data-gs-width'))
                .attr('data-gs-height', o.attr('data-gs-height'))
                .show();
            node.el = self.placeholder;
        };

        var on_end_moving = function (event, ui) {
            var o = $(this);
            node.el = o;
            self.placeholder.hide();
            o
                .attr('data-gs-x', node.x)
                .attr('data-gs-y', node.y)
                .attr('data-gs-width', node.width)
                .attr('data-gs-height', node.height)
                .removeAttr('style');
            self._update_container_height();
        };

        el.draggable({
            handle: this.opts.handle,
            scroll: true,
            appendTo: 'parent',
            start: on_start_moving,
            stop: on_end_moving,
            drag: function (event, ui) {
                var x = Math.round(ui.position.left / cell_width),
                    y = Math.floor(ui.position.top / cell_height);
                self.grid.move_node(node, x, y);
                self._update_container_height();
            }
        });
        if (!el.attr('data-gs-no-resize')) {
            el.resizable({
                autoHide: true,
                handles: 'se',
                minHeight: this.opts.cell_height - 10,
                minWidth: 70,

                start: on_start_moving,
                stop: on_end_moving,
                resize: function (event, ui) {
                    var width = Math.round(ui.size.width / cell_width),
                        height = Math.round(ui.size.height / cell_height);
                    self.grid.move_node(node, node.x, node.y, width, height);
                    self._update_container_height();
                }
            });
        }
    };

    GridStack.prototype.add_widget = function (el, x, y, width, height) {
        el = $(el);
        if (typeof x != 'undefined') el.attr('data-gs-x', x);
        if (typeof y != 'undefined') el.attr('data-gs-y', y);
        if (typeof width != 'undefined') el.attr('data-gs-width', width);
        if (typeof height != 'undefined') el.attr('data-gs-height', height);
        this.container.append(el);
        this._prepare_element(el);
    };

    GridStack.prototype.remove_widget = function (el) {
        var node = $(el).data('_gridstack_node');
        this.grid.remove_node(node);
        el.remove();
    };

    scope.GridStackUI = GridStack;

    $.fn.gridstack = function (opts) {
        return this.each(function () {
            if (!$(this).data('_gridstack')) {
                $(this).data('_gridstack', new GridStack(this, opts));
            }
        });
    };

})(window, _);
