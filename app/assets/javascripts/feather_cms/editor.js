$(document).ready(function(){

  var opts = { 
    container: 'epiceditor',
    basePath: '/assets/feather_cms',
    focusOnLoad: true, 
    file: { defaultContent: '' }
  };

  window.editor = new EpicEditor(opts); //.load();

  window.editor.load(function(){
    window.editor.importFile(null, $('#page_content').val());
  });

  $('#page_form').submit(function(){
    content = window.editor.exportFile(null, 'html');
    $('#page_content').val(content);
  });

});

