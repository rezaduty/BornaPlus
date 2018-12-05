/**
 * @license Copyright (c) 2003-2018, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	
	// %REMOVE_START%
	// The configuration options below are needed when running CKEditor from source files.
	config.plugins = 'dialogui,dialog,about,a11yhelp,basicstyles,blockquote,notification,button,toolbar,clipboard,panel,floatpanel,menu,contextmenu,resize,elementspath,enterkey,entities,popup,filetools,filebrowser,floatingspace,listblock,richcombo,format,horizontalrule,htmlwriter,wysiwygarea,image,indent,indentlist,fakeobjects,link,list,magicline,maximize,pastetext,pastefromword,removeformat,showborders,sourcearea,specialchar,menubutton,scayt,stylescombo,tab,table,tabletools,tableselection,undo,lineutils,widgetselection,widget,notificationaggregator,uploadwidget,uploadimage,wsc,simage,imageuploader,imagerotate,imageCustomUploader,imageresizerowandcolumn,imageresize,image2,imageresponsive,imagepaste,imgupload,zamanager,imgbrowse,imagebrowser,zsuploader,textwatcher,autocomplete,textmatch,xml,ajax,panelbutton,emoji,save-to-pdf,texzilla,balloonpanel,a11ychecker,ccmsacdc,dialogadvtab,allmedias,allowsave,autolink,autoembed,autocorrect,bgimage,balloontoolbar,basewidget,bbcode,bidi,base64image,backgrounds,btbutton,bt_table,colordialog,glyphicons,btgrid,bootstrapTable,bootstrapVisibility,brclear,cavacnote,bootstrapTabs,chart,ckawesome,ckeditor_fa,footnotes,ckwebspeech,cleanuploader,cloudservices,closedialogoutside,codesnippet,pbckcode,codesnippetgeshi,codeTag,codemirror,pre,colorbutton,computedfont,btquicktable,computedstyles,autosave,ccmsconfighelper,copyformatting,templates,niftytimers,confighelper,cssanim,custimage,crossreference,deselect,devtools,div,divarea,docprops,docfont,detail,imagebase,easyimage,easykeymap,enhancedcolorbuttton,emojione,eqneditor,extraformattributes,fastimage,uploadcare,dropdownmenumanager,fixed,flash,floating-tools,FMathEditor,font,forms,wlpheix,googleDocPastePlugin,googlesearch,googlethisterm,ckeditor-gwf-plugin,googledocs,gg,xmas,hkemoji,htmlbuttons,html5validation,html5video,Audio,iframe,imgur,iframedialog,glossary,indentblock,inlinecancel,format_buttons,label,closebtn,insertpre,smiley,inserthtml4x,internallink,find,justify,language,textselection,symbol,layoutmanager,letterspacing,leaflet,lineheight,hkurlsplit,liststyle,liveedit,locationmap,lite,loremipsum,inserthtmlfile,lightbox,markdown,mathedit,autoplaceholder,MathEx,oembed,mediabrowser,embedbase,embed,mentions,tliyoutube2,tliyoutube,mediaembed,media,maxheight,mrmonkey,noabp,nbsp,numericinput,newpage,onchange,openlink,OpenStreet,osem_googlemaps,pagebreak,pastecode,pastefromexcel,pasteFromGoogleDoc,pastebase64,performx,niftyimages,placeholder,placeholder_select,print,preview,qrc,prism,textindent,quicktable,quran,ccmssourcedialog,removespan,resizewithwindow,replaceTagNameByBsquochoai,save,scribens,selectall,selectallcontextmenu,sharedspace,embedsemantic,SPImage,showblocks,showprotected,savemarkdown,html5audio,SimpleImage,simple-image-browser,simpleImageUpload,SimpleLink,simplebutton,simple-ruler,sketchfab,slideshow,soundPlayer,sourcedialog,spacingsliders,spoiler,staticspace,smallerselection,stat,strinsert,stylesheetparser,stylesheetparser-fixed,backup,syntaxhighlight,ckeditortablecellsselection,contents,tableresize,tableresizerowandcolumn,toc,tablesorter,tabletoolstoolbar,tangy-gps,tangy-input,tangy-checkbox,tangy-location,tabbedimagebrowser,textIdent,textsignature,texttransform,token,xdsoft_translater,tweetabletext,uicolor,linkayt,video,videoembed,uploadfile,videosnapshot,wenzgmap,widgetcontextmenu,wordcount,yaqr,youtube,xmltemplates,videodetector,zoom,Text2Speech,toolbarswitch,mathjax,autogrow,page2images';
	config.skin = 'office2013';
	// %REMOVE_END%

	// Define changes to default configuration here.
	// For complete reference see:
	// http://docs.ckeditor.com/#!/api/CKEDITOR.config

	// The toolbar groups arrangement, optimized for two toolbar rows.
	config.toolbarGroups = [
		{ name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
		{ name: 'links' },
		{ name: 'insert' },
		{ name: 'forms' },
		{ name: 'tools' },
		{ name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'others' },
		'/',
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
		{ name: 'styles' },
		{ name: 'colors' },
		{ name: 'about' }
	];

	// Remove some buttons provided by the standard plugins, which are
	// not needed in the Standard(s) toolbar.
	config.removeButtons = 'Underline,Subscript,Superscript';

	// Set the most common block elements.
	config.format_tags = 'p;h1;h2;h3;pre';

	// Simplify the dialog windows.
	config.removeDialogTabs = 'image:advanced;link:advanced';
};
