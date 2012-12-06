
var RichText = require('com.obscure.RichText');

var tabGroup = Titanium.UI.createTabGroup();

var win1 = Titanium.UI.createWindow({  
    title:'CSS Styles',
    backgroundColor:'#fff'
});

var tab1 = Titanium.UI.createTab({  
    title:'CSS',
    window:win1
});

var scroll1 = Ti.UI.createScrollView({
  height: '100%',
  width: '100%',
  contentHeight: 'auto'
});
var view1 = RichText.createRichTextView({
  height: Ti.UI.SIZE,
  html: 'loading...'
});
scroll1.add(view1);
win1.add(scroll1);

win1.addEventListener('open', function() {
  var f = Ti.Filesystem.getFile('styles.html');
  if (f.exists()) {
    var b = f.read();
    view1.html = b.text;
  }
});

var win2 = Titanium.UI.createWindow({  
    title:'Images',
    backgroundColor:'#fff'
});
var tab2 = Titanium.UI.createTab({  
    title:'Images',
    window:win2
});

var scroll2 = Ti.UI.createScrollView({
  height: '100%',
  width: '100%',
  contentHeight: 'auto'
});
var view2 = RichText.createRichTextView({
  height: Ti.UI.SIZE,
  html: 'loading...'
});
scroll2.add(view2);
win2.add(scroll2);

win2.addEventListener('open', function() {
  var f = Ti.Filesystem.getFile('Image.html');
  if (f.exists()) {
    var b = f.read();
    view2.html = b.text;
  }
});



tabGroup.addTab(tab1);  
tabGroup.addTab(tab2);  

tabGroup.open();
