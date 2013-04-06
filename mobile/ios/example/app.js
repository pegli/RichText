var RichText = require('com.obscure.RichText');

var win = Ti.UI.createWindow({
	backgroundColor : '#ccc',
	layout : 'vertical'
});
var testData = [ 
	{title: 'About this module', file:"About.html"}, 
	{title: 'READ ME', file:"README.html"}, 
	{title: 'iOS6', file:"iOS6.html"}, 
	{title: 'CSS Styles', file:"styles.html"},
	{title: 'Line Height', file:"LineHeight.html"}, 
	{title: 'Text Alignment', file:"Alignment.html"}, 
	{title: 'Image Handling', file:"Image.html"}, 
	{title: 'Video', file:"Video.html"}, 
	{title: 'Space and Newline Handling', file:"APOD.html"}, 
	{title: 'Extremely long HTML document', file:"WarAndPeace.html"}, 
	{title: 'Custom Fonts', file:"CustomFont.html"}, 
	{title: 'Custom Subviews', file:"Subviews.html"}, 
	{title: 'Nested Lists', file:"ListTest.html"}, 
	{title: 'Arabic Text', file:"ArabicTest.html"}, 
	{title: 'Multiple Languages Support', file:"Languages.html"}, 
	{title: 'Text Boxes', file:"TextBoxes.html"}, 
	{title: 'Emoji Test', file:"EmojiTest.html"}, 
	{title: 'Known CoreText Issues', file:"CoreTextIssues.html"}, 
	{title: 'Font Sizes', file:"FontSizes.html"}
];
var table = Ti.UI.createTableView({
	data: testData
});
table.addEventListener("click", openWin);
win.add(table);


function openWin(e) {
	var content = readFile(e.row.file);
	
	var win = Ti.UI.createWindow({backgroundColor : '#FFF'});
	var scrollView = Ti.UI.createScrollView({
	    left:0,right:0,top:0,
	    contentHeight:'auto',
	    contentWidth:"100%",
	    showVerticalScrollIndicator: true,
	    showHorizontalScrollIndicator: false
	});
	var richTextView = RichText.createRichTextView({ // <-- this is the module view
		top:10,
		left:10,
		right:10,
		height : Ti.UI.SIZE,
		html : content
	});
	richTextView.addEventListener("click", function(e){
		Ti.API.info(e);
	});
	scrollView.add(richTextView);
	win.add(scrollView);
	navGroup.open(win);
}

function readFile(filename){
	var html = Ti.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, filename);
	return html.read().text;
}

//navgroup
var window = Ti.UI.createWindow();
var navGroup = Ti.UI.iPhone.createNavigationGroup({ window : win });
window.add(navGroup);
window.open();
