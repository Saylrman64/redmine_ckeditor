<h3>Fork of Redmine CK Editor plugin</h3>

<h5>Source:</h5>
<p>https://github.com/a-ono/redmine_ckeditor</p>

<h5>Version</h5>
<p>Based on 1.2.3</p>

<h5>Reason:</h5>
<p>After navigating to plugin settings of CK Editor, internal server error (500) occured. This was due to missing variable <i>ckeditor_javascripts</i> in the view template. This is a know problem - see https://github.com/a-ono/redmine_ckeditor/issues/308 for more details.</p>

<h5>Changes:</h5>
<ul>
<li><b>'app/views/settings/_ckeditor.html.erb'</b> - line 1 - missing variable <i>ckedittor_javascripts</i> was replaced by <i>RedmineCkeditor::Helper.instance_method(:ckeditor_javascripts).bind(self).call</i> as recomended in the issue 308 (https://github.com/a-ono/redmine_ckeditor/issues/308).</li>
<li><b>'lib/redmine_ckeditor/application_helper_patch.rb'</b> - method <i>format_activity_description</i> was wrapped in <i>def self.included(base)</i> and <i>base.class_eval do</i>. Before this fix this method was correctly redefined only if no other Application Helper patches were present. Because we have many Application Helper patches in Projectino and RedmineX solutions, this redefinition did not work correctly.</li>
<li><b>assets/ckeditor</b> - version of CK Editor (which is part of the plugin) was upgraded to 4.15.1 (it is the last v4 version). This version enables copy/paste functionality also in Chrome browser for Android.</li>
</ul>

<h5>Changes due to CK Editor upgrade to 4.15.1</h5>
<ul>
<li><b>'assets/ckeditor/config.js'</b> - line 7 - all required plugins added to the <i>config.options</i> object. Part of the CK Editor 4.15.1 is also <i>exportpdf</i> plugin, which is a premium (paid) feature. This means we need to disable the plugin. This can be (theoretically) done by the <i>removePlugins</i> object, however this configuration did not work and therefore <i>config.options</i> was used instead.</li>
</ul>

<h5>Changes for Redmine version 5.X.X support</h5>
<ul>
<li><b>'init.rb'</b> - lines 2 to 7 - this block of code replaced original <i>require 'redmine_ckeditor'</i> statement. This code ensures support of zeitwerk loader used in Redmine 5.X.X.</li>
<li><b>lib/redmine_ckeditor.rb</b> - lines 141 to 150 - paths to required modules were updated inorder to support loading by the zeitwerk loader used in Redmine 5.X.X.</li>
<li><b>lib/redmine_ckeditor/pdf_patch.rb</b> - line 2 and line 51 - name of this module was changed from <i>PDFPatch</i> to <i>PdfPatch</i> in order to respect Ruby naming conventions (this is also strictly required byt the zeitwerk loader used in Redmine 5.X.X).</li>
<li><b>lib/redmine_ckeditor/wiki_formatting/formatter.rb</b> - lines 27 to 37 - <i>ActionView::Base</i> object in Rails 6.X used in Redmine 5.X.X as default does not contain originally used <i>white_list_sanitizer</i> method which was deprecated. The original code was replaced by <i>if</i> statement which uses correct method depending on the Rails version.</li>
</ul>
