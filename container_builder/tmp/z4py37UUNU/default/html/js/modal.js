/* ============================================
 License for Application
 ============================================

 This license is governed by United States copyright law, and with respect to matters
 of tort, contract, and other causes of action it is governed by North Carolina law,
 without regard to North Carolina choice of law provisions.  The forum for any dispute
 resolution shall be in Wake County, North Carolina.

 Redistribution and use in source and binary forms, with or without modification, are
 permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list
 of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.

 3. The name of the author may not be used to endorse or promote products derived from
 this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

NOTE: This code has been modified from the original
 */

function modal_set_up(buttonID, modalID) {
  // To keep tab focus when exiting the modal

  // Remove invalid characters from ID
  modalID  = modalID.replace(/( |\?|\/|\|_|[()])/g, "");
  buttonID = buttonID.replace(/( |\?|\/|\|_|[()])/g, "");

  var that = this;
  that.$refocus = null;

  var $button = $("[id='" + buttonID + "']");
  var $modal  = $('#' + modalID);

  // Clicking the button opens the modal and saves tab focus
  $button.on('click', function() {
    showModal($modal);
    that.$refocus = ($(this));
    return false;
  });

  // Pressing enter on the button opens the modal and saves tab focus
  $button.on('keydown', function(event) {
    var keycode = event.charCode || event.keyCode;
    if (keycode == 13) {
      showModal($modal);
      that.$refocus = ($(this));
      return false;
    }
  });

  // Changes certain keys whilst the modal is open
  $modal.on('keydown', function(event) {
    keyHandeler($(this), event);
  });

  // Closing the modal closes the modal and resumes tab focus
  $('.modalCloseButton').on('click', function() {
    hideModal($modal, that.$refocus);
  });
}

function keyHandeler($obj, evt) {
  // Close on esc key
  // Key the tab contained to the modal only
  // Allow enter and space key for forms and closing modal
  // Disable other key presses
  var keycode = evt.charCode || evt.keyCode;
  var $focused        = $(':focus')[0];
  var $focusable      = $obj.find(":focusable");
  var $currentFocus   = $.inArray($focused, $focusable);

  if (keycode == 27) {
    $('.modalCloseButton').click();
    return false;
  } else if (keycode == 9 && $focusable.length > 1) {
    if (evt.shiftKey) {
      if ($currentFocus == 0) {
        $focusable.get($focusable.length -1).focus();
      }
    } else {
      if ($currentFocus == $focusable.length - 1) {
        $focusable.eq(0).focus();
      }
    }
  } else if (keycode == 13 || keycode == 32) {
      return true;
  } else {
      evt.preventDefault();
  }
}

function mouseHandler($obj) {
  // Disable scroll wheel and touchscreen scrolling
  $obj.on('mousewheel touchmove', function(){
    return false;
  });
}

function showModal($modelID) {
  $modelID.modal();
  mouseHandler($('.modal-backdrop'));
  mouseHandler($modelID);

  $modelID.on('shown.bs.modal', function (e) {
    $(".start_dialog").focus(); //tab focus to start at heading
    $('body').attr('aria-hidden', 'true');
  });
}

function hideModal($modelObj, $re) {
  $modelObj.on('hidden.bs.modal', function (e) {
    $('body').attr('aria-hidden', 'false');
  });
  $re.focus(); //return to current tab focus
}
