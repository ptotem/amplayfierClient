(function() {
  window.Switch = (function() {
    function Switch(input) {
      if ('checkbox' !== input.type) {
        throw new Error('You can\'t make Switch out of non-checkbox input');
      }
      this.input = $(input);
      this.input.css({
        display: 'none'
      });
      this.el = $("<div class=\"ios-switch\">\n  <div class=\"on-background background-fill\"></div>\n  <div class=\"state-background background-fill\"></div>\n  <div class=\"handle\"></div>\n<div>");
      this.el.insertBefore(this.input);
      if (this.input.is(':checked')) {
        this.turnOn();
      }
    }

    Switch.prototype.toggle = function() {
      if (this.el.hasClass('on')) {
        this.turnOff();
      } else {
        this.turnOn();
      }
      return this.input.trigger('onchange');
    };

    Switch.prototype.turnOn = function() {
      this.el.addClass('on');
      this.el.removeClass('off');
      return this.input.prop('checked', true);
    };

    Switch.prototype.turnOff = function() {
      this.el.removeClass('on');
      this.el.addClass('off');
      return this.input.prop('checked', false);
    };

    return Switch;

  })();

}).call(this);
