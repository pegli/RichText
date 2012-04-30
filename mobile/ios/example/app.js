

var RichText = require('com.obscure.RichText');

var win = Ti.UI.createWindow({ backgroundColor:'white' });

var view = RichText.createRichTextView({                                       
  width: 200,
  height: 60,
  backgroundColor: 'red',
  html: 'hello, <b>world</b>!',
});
win.add(view);

win.open();