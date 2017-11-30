$(document).ready(function() {
  $('.hidden_following').css('display','none');
});

function set_following_questions_trigger ( selector, test_function ) {
  // when the page loads, show the following_questions whose condition is already true (where there's already data in the page)
  selector.each( function () {
    var $this = $(this);
    var following_id = get_following_id( $this );

    if ( following_id == undefined ) { return; }
    var following = $( '#' + following_id );

    if ( test_function( $this ) ) {
      following.show();
    }
  });

  // and set it up to hide or show when the form element changes
  selector.on( 'change', function () {

    var $this = $(this);
    var following_id = get_following_id( $this );

    if ( following_id == undefined ) { return; }
    var following = $( '#' + following_id );

    if ( test_function( $this ) ) {
      following.show(400);
    }
    else {
      // clear the checkboxes and text fields and selects that are children of the following div
      following.hide(400, function () {
          $('#' + following_id + ' input').each( function () {
              var $this = $(this);
              if ( $this.attr('type') == 'checkbox' || $this.attr('type') == 'radio') {
                  $this.prop('checked', false);
              }
              else if ( $this.attr('type') == 'text') {
                  $this.val('');
              }
          });
          $('#' + following_id + ' textarea').each( function () {
            $(this).val('');
          });
          $('#' + following_id + ' select').each( function () {
            $(this).val('');
          });
      });
    }
  });
}

// get the id of the div holding the following questions. returns undefined if there isn't one, or it can't be determined.
function get_following_id ( element ) {
  var following_id;

  if ( element.is('select') ) {
    following_id = element.attr('name').replace('slot.', '') + '_following';
  }
  else {
    following_id = element.attr('id').replace(/\.\d+/, '_following').replace('slot.', '');
  }

  if ( following_id == '' || $('#' + following_id ).length == 0 ) {
    return undefined;
  }

  return following_id;
}
