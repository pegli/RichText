

var RichText = require('com.obscure.RichText');

var win = Ti.UI.createWindow({ backgroundColor:'#ccc', layout: 'vertical' });

var font = {
  fontFamily: 'AmericanTypewriter',
  fontSize: 14,
};

win.add(Ti.UI.createLabel({
  height: 24,
  backgroundColor: '#fcc',
  font: font,
  text: "reference font"
}));

var view = RichText.createRichTextView({                                       
  width: 200,
  height: Ti.UI.SIZE,
  font: font,
  html: "<h2>Important message!</h2><p>hello, <b>world</b>! I'm <i>really</i> happy to see you.</p>",
});
win.add(view);

var bgview = RichText.createRichTextView({
   width: 200,
   height: Ti.UI.SIZE,
   color: 'yellow',
   backgroundColor: 'blue',
   font: {
     fontFamily: 'Copperplate',
     fontSize: 36
   },
   html: "<p>para 1</p><p>para 2</p>",
});
win.add(bgview);

win.open();

setTimeout(function() {
  view.html = "<h1>bye bye!</h1>";
}, 5000);
