var TextBlocks = {
  init: function(){
    var select = $('#textblock-select');
    var toolbar_buttons = select.parent().find('.jstElements');
    if(select.parent() != toolbar_buttons) {
      toolbar_buttons.find('button:last').after(select);
    }
    select.show();
  },

  insert: function(e){
    var value = $(this).val();
    if(value == '') return;

    console.log(value);
    var fieldId = $('#textblock-select').parent().next('div.jstEditor').find('textarea').attr('id');

    var field = document.getElementById(fieldId);
    var field_ = $(field);

    var caretPos = field.selectionStart;
    var caretEnd = field.selectionEnd;
    var textAreaTxt = field_.val();
    field_.val(
      textAreaTxt.substring(0, caretPos) +
      value +
      textAreaTxt.substring(caretEnd)
    );

    field_.focus();
    field.selectionStart = caretPos + value.length
    field.selectionEnd = caretPos + value.length

    $(this).val('');
  }

}

$(document).ready(TextBlocks.init);
$(document).on("change", "#textblock-select", TextBlocks.insert);
