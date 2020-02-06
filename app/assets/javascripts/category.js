$(function(){
  const child_js = document.getElementById("child_js");
  const grandchild_js = document.getElementById("grandchild_js");
  const size = document.getElementById("size");
  const brand = document.getElementById("brands");
  child_js.style.display ="none";
  grandchild_js.style.display ="none";
  size.style.display ="none";
  brand.style.display ="none";

  $('#c_parents').on('change', function(e){
    var c_parents = document.getElementById("c_parents").value;
    if( c_parents != ""){
      $.ajax({
        type: 'GET',
        url: '/products/cate_children',
        dataType: 'json',
        data: {parent: c_parents}
      })

      .done(function(child){ 
        child_js.style.display = "block";
        child.forEach(function(child){
          var child_html = "";
          var child_html = ($("<option>").val($(child).attr('id')).text($(child).attr('name')));
          $("#child_js").append(child_html);
        })
      })
    }else if(c_parents == ""){
      child_js.style.display ="none";
      grandchild_js.style.display ="none";
      $("#grandchild_js").remove();
      $("#child_js").remove();
    }
  })

  $('#child_js').on('change', function(e){
    var id = document.getElementById("child_js").value;
    if( id != "---"){
      grandchild_js.style.display ="block";
      $.ajax({
        type: 'GET',
        url: '/products/cate_children',
        dataType: 'json',
        data: {parent: id}
      })
      .done(function(grand_child){ 
        grandchild_js.style.display ="block";
        size.style.display ="block";
        brand.style.display ="block";
        grand_child.forEach(function(grand_child){
          var grandchild_html = "";
          var grandchild_html = ($("<option>").val($(grand_child).attr('id')).text($(grand_child).attr('name')));
          $("#grandchild_js").append(grandchild_html);
        })
        $('#child_js').on('change', function(e){
          $("#grandchild_js").remove();
        });
      });
    }else if(id == "---"){
      grandchild_js.style.display ="none";
      $("#grandchild_js").remove();
    }
  })
});
