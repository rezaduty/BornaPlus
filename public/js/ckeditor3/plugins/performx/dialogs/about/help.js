﻿CKEDITOR.dialog.add("helpDialog",function(b){return{title:"Help",minWidth:"400",minHeight:"300",contents:[{id:"main",elements:[{id:"about",type:"html",html:'<style type="text/css">#help-wrapper{width: 400px;height: 350px;overflow:auto;}#help-wrapper *{white-space:normal;}#help-wrapper p{margin-bottom:10px;}#help-wrapper ol{margin-bottom:10px;list-style-type: decimal;padding-left: 30px;}#help-wrapper ul{margin-bottom:10px;list-style-type: disc;padding-left: 30px;}#help-wrapper li{margin-bottom:5px;}#help-wrapper h1{font-size:16px;font-weight:bold;margin-bottom:20px;color:#840004;}#help-wrapper a{color:#840004;}</style><div id="help-wrapper"></div>'}]}],
buttons:[CKEDITOR.dialog.okButton],onShow:function(){var a;switch(window.pxHelpMode){case 1:a="<h1>Editor content template</h1><ol><li>Select one of the included editor content templates from the <strong>Template</strong> drop-down list.</li><li>A preview of the structure will display on the right-hand side of the panel.</li><li>If you tick the <strong>Overwrite current contents in the editor</strong> check box, the selected template will overwrite all the existing content in the editor.</li><li>If you leave the <strong>Overwrite current contents in the editor</strong> check box blank, the selected template content will be inserted at the current cursor position.</li><li>Click <strong>OK</strong> to insert the selected template content.</li></ol><p>Note that the look and feel of the content (colour, font, spacing etc.) is controlled by your site specifications, not by the selected template.</p>";
break;case 2:a="<h1>Table library</h1><ol><li>Select one of the available tables from the <strong>Table</strong> drop-down list.&nbsp;A preview of the table will display on the right-hand side of the panel.</li><li>Type the number of rows you want for your table (in addition to the header row) in the <strong>Rows</strong> field.&nbsp;Click <strong>OK</strong> to insert the selected table.</li><li>The selected table will be inserted at the current cursor position.</li></ol><p>Note that the look and feel of the table (borders, shading etc.) is controlled by your site specifications, not by the selected table.</p>";
break;case 3:a="<h1>Accessibility checker</h1><p>This accessibility checker performs a mechanical check on elements in the editor. Elements checked include images, tables, heading levels and use of bold and italic.</p> <p>The checker is <strong>not</strong> able to:</p><ul><li>Check the correctness, appropriateness, or accessibility of text values used in &lt;alt&gt;, &lt;summary&gt;, &lt;caption&gt; and other fields</li><li>Check the accessibility of other page elements controlled by your site specifications</li><li>Check the accessibility of the look and feel of your page (e.g. colour contrast)</li><li>Repair any accessibility issues identified.</li></ul>";
break;default:a="<p>Oops! Cannot find relevant help text.</p>"}jQuery("#help-wrapper").html(a)}}});
