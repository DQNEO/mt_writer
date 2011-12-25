var render = function(){

    var BLOG_NAME = $('#header-name').text();
    var entryTitle = $('#title').text() + " - " + BLOG_NAME;

    //再描画
    $('#entry-title').text(entryTitle);
    document.title = entryTitle;
};

$(function(){
    render();
});

