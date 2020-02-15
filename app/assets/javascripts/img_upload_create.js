$(document).on('turbolinks:load',function(){
  var dropzone = $('.dropzone-area');
  var dropzone2 = $('.dropzone-area2');
  var input_area = $('.input_area');
  var preview = $('#preview');
  var preview2 = $('#preview2');
  var images = [];
  var inputs  =[];

  dropzone.css({
    'display': 'block'
  })
  dropzone2.css({
    'display': 'none'
  })
  
  // ファイルを入れたら発火
  $("#create_product_img .dropzone-container, #create_product_img .dropzone-container2").on('change', 'input[type= "file"].upload-image', function(event) {
    // inputタグへの入力をinputsに格納
    var file = $(this).prop('files')[0];
    inputs.push($(this));

    // 写真プレビュー用のフレームと、選択した画像を読み込むためのオブジェクトを作成
    var img = $(`<div class= "img_view"><img class="img_view"></div>`);
    var reader = new FileReader();

    // 読み込みが完了したら、写真用フレームにボタンと表示用のsrcをはめ込む(画像ファイルのData URIスキームは event.target.result から取得)
    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn delete">削除</div></div>');
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
    }

    // File オブジェクトを読み込みを実行。プレビュー用のフレームを配列に格納。
    reader.readAsDataURL(file);
    images.push(img);


    if(images.length >= 5) {
      dropzone2.css({
        display: 'block'
      })
      // dropzone.css({
      //   display: 'none'
      // })

      // 配列よりフレームを取り出し、はめ込み、プレビューに表示
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
        dropzone2.css({
          'width': `calc(100% - (135px * ${images.length - 5}))`
        })
      })

      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      dropzone2.css({
        'display': 'none'
      })

        $('#preview').empty();
        // 配列よりフレームを取り出し、はめ込み、プレビューに表示
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        dropzone.css({
          'width': `calc(100% - (20% * ${images.length}))`
        })
      }
      if(images.length == 4) {
        dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }

    if(images.length == 10) {
      dropzone2.css({
        'display': 'none'
      })
      return;
    }

    // input_areaに新しくinputタグを作成
    var new_image = $(`<input multiple= "multiple" name="product_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
    input_area.prepend(new_image);
  });

  //  画像の削除
  $("#create_product_img .dropzone-container, #create_product_img .dropzone-container2").on('click', '.delete', function() {
    var target_image = $(this).parent().parent();
    $.each(inputs, function(index, input){
      // プレビューのとinputタグを一緒に削除
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        inputs.splice(num, 1);

        if(inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({
            'data-image': 0
          })
        }
      }
    });

    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    });

    $.each(inputs, function(index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    if (images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      dropzone2.css({
        'width': `calc(100% - (135px * ${images.length - 5}))`
      })
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
      if(images.length == 8) {
        dropzone2.find('i').replaceWith('<p>ココをクリックしてください</p>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (135px * ${images.length}))`
      })
    }
    if(images.length == 4) {
      dropzone2.css({
        'display': 'none'
      })
    }
    if(images.length == 3) {
      dropzone.find('i').replaceWith('<p>ココをクリックしてください</p>')
    }
  })
});