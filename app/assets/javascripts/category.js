  $(function(){
    const kodomo = document.getElementById("kodomo");
    const mago = document.getElementById("mago");
    kodomo.style.display ="none";
    mago.style.display ="none";
    // $("#mago").remove();
    // $("#kodomo").remove();

    $('#c_parents').on('change', function(e){
      var p = document.getElementById("c_parents").value;
      if( p != ""){
        // kodomo.style.display ="block";
        $.ajax({
        type: 'GET',
        url: '/products/cate_children',
        dataType: 'json',
        data: {parent: p}
      })

      .done(function(child){ 
        kodomo.style.display ="block";
        child.forEach(function(child){
        var c_html = "";
        var c_html = ($("<option>").val($(child).attr('id')).text($(child).attr('layer')));
        $("#kodomo").append(c_html);
        })
    })
  }else if(p == ""){
    kodomo.style.display ="none";
    mago.style.display ="none";
    $("#mago").remove();
    $("#kodomo").remove();
  }
})
$('#kodomo').on('change', function(e){
  
  var id = document.getElementById("kodomo").value;
  if( id != "---"){
    mago.style.display ="block";
$.ajax({
    type: 'GET',
    url: '/products/grand_children',
    dataType: 'json',
    data: {child_id: id}
  })
  .done(function(grand_child){ 
    mago.style.display ="block";
    grand_child.forEach(function(grand_child){
    var g_html = "";
    var g_html = ($("<option>").val($(grand_child).attr('id')).text($(grand_child).attr('layer')));
    $("#mago").append(g_html);
    })
    $('#kodomo').on('change', function(e){
      $("#mago").remove();
    });
  });
}else if(id == "---"){
  mago.style.display ="none";
  $("#mago").remove();
}})
});
