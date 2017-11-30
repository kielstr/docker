$(document).ready(function() {
  var box_inputs     = $(".choice_v li input");

  $(".choice_v li input").on('load', update_text(box_inputs));

  function show_text($this) {
    $this.parent().removeClass('text-hidden');
    $this.parent().addClass('text-show');
    $this.attr('tabindex', '10');
  }

  function hide_text($this) {
    $this.parent().removeClass('text-show');
    $this.parent().addClass('text-hidden');
    $this.attr('tabindex', '-1');
    $this.val('');
  }

  function toggle_text($box, $text) {
    if ($box.is(":checked")){
      show_text($text);
    } else {
      hide_text($text);
    }
  }

  function update_text($box) {
    $box.each(function(){
    var look_down = $(this).parent().next().find("input[type='text']");
      if (look_down) {
        toggle_text($(this), look_down);
      }
    });
  }

 $(".choice_v li input").on('change click keydown', function(){
    box_inputs.each(function(){
    var look_down = $(this).parent().next().find("input[type='text']");
    if (look_down) {
      toggle_text($(this), look_down);
    }
  });
 });

});
