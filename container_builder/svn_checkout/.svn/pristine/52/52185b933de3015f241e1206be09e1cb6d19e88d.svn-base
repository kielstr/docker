
$(document).ready(function() {
    var action_checkboxes = $('input[id$=".1"]').not('input[id$="_assist.1"]').filter(function(){
        // filter out inputs that aren't in tables; they're covered in following_questions.js
        return $(this).parents("table").length;
    })

    action_checkboxes.each( function () {
        var following = $( '#' + get_following_id( $(this) ) );

        if ( $(this).attr('checked') ) {
            following.show();
        }
    });

    action_checkboxes.change( function () {
        var following_id = get_following_id( $(this) );
        var following = $( '#' + following_id );

        if ( $(this).attr('checked') ) {
            following.show(400);
        }
        else {
            // clear the checkboxes and text fields that are children of the following div
            following.hide(400, function () {
                // clear the inputs
                $('#' + following_id + ' input').each( function () {
                    if ( $(this).attr('type') == 'checkbox' ) {
                        $(this).attr('checked', '');
                    }
                    else if ( $(this).attr('type') == 'text' ) {
                        $(this).val('');
                    }
                });

                // clear the selects
                $('#' + following_id + ' select').each( function () {
                    $(this).val('0')
                });

                // hide all sub-divs that are following divs
                // TODO make this selector more efficient
                $('#' + following_id + ' div').each( function () {
                    if( $(this).attr('id').match(/_following$/) ) {
                        $(this).hide();
                    }
                });
            });
        }
    });

    function get_following_id ( checkbox ) {
        return checkbox.attr('id').replace('.1', '_following').replace('slot.', '');
    }

});

