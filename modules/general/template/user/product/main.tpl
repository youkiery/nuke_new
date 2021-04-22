<!-- BEGIN: main -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css">

<script src="/modules/core/js/vhttp.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/shim.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.full.min.js"></script>

<style>
  .error {
    color: red;
    font-size: 1.2em;
    font-weight: bold;
  }

  a.btn-default {
    color: #444
  }

  .rows::after {
    content: "";
    clear: both;
    display: table;
  }

  .col-2, .col-3, .col-4, .col-6, .col-8, .col-9 {
    float: left;
  }

  .col-2 { width: 16.66%; }
  .col-3 { width: 25%; }
  .col-4 { width: 33.33%; }
  .col-6 { width: 50%; }
  .col-8 { width: 66.66%; }
  .col-9 { width: 75%; }

  .upload {
    background: #eee;
    height: 100px;
    width: 100px;
    font-size: 50px;
    border-radius: 10%;
    line-height: 100px;
    color: green;
  }

  .suggest {
    z-index: 10;
  }
</style>

<div id="msgshow"></div>

{modal}

<!-- <div class="form-group">
  <ul class="nav nav-tabs">
    <li class="active"><a href="/{nv}/product"> Quản lý sản phẩm </a></li>
    <li><a href="/{nv}/product?sub=tag"> Quản lý tag </a></li>
    <li><a href="/{nv}/product?sub=expire"> Quản lý hạn sử dụng </a></li>
    <li><a href="/{nv}/product?sub=location"> Tìm kiếm vị trí </a></li>
  </ul>
</div> -->

<div style="float: right">
  <button class="btn btn-danger" onclick="removeItem()">
    Xóa hàng loạt
  </button>
  <button class="btn btn-info" onclick="$('#update-modal').modal('show')">
    Cập nhật
  </button>
  <button class="btn btn-success" onclick="insertNewItem()">
    Thêm
  </button>
</div>

<a href="/general/product-floor" class="btn btn-info"> Danh sách tầng </a>
<div style="clear: right;" class="form-group"></div>

<div style="clear: both;"></div>

<!-- <div class="form-group">
  <form class="form-inline">
    <input type="hidden" name="nv" value="{nv}">
    <input type="hidden" name="op" value="{op}">
    <div class="form-group">
      <input type="text" class="form-control" name="keyword" value="{keyword}"
        placeholder="Tìm kiếm theo tên hàng, mã hàng,...">
    </div>
    <div class="form-group">
      <div class="relative">
        <input type="text" class="form-control" id="tag" name="tag" value="{tag}"
          placeholder="VD: dây dắt, vòng cổ, xích inox, cổ xanh đỏ đen,...">
        <div class="suggest" id="tag-suggest"> </div>
      </div>
    </div>
    <div class="form-group">
      <select class="form-control" name="limit">
        <option value="10" {check10}> 10 </option>
        <option value="20" {check20}> 20 </option>
        <option value="50" {check50}> 50 </option>
        <option value="100" {check100}> 100 </option>
        <option value="200" {check200}> 200 </option>
      </select>
      <button class="btn btn-info">
        <span class="glyphicon glyphicon-search"></span>
      </button>
    </div>
  </form>
</div> -->

<!-- <div class="form-group rows">
  <div class="relative col-4">
    <input type="text" class="form-control" id="product-insert-input" placeholder="Thêm mặt hàng">
    <input type="hidden" id="product-insert-input-val">
    <div class="suggest" id="product-insert-input-suggest"></div>
  </div>
  <div class="col-2">
    <div class="input-group">
      <input type="text" class="form-control" id="product-insert-input-low" placeholder="Giới hạn">
      <div class="input-group-btn">
        <button class="btn btn-success" onclick="insertProduct()">
          <span class="glyphicon glyphicon-plus"></span>
        </button>
      </div>
    </div>
  </div>
</div> -->

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vremind-6.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vimage.js"></script>
<script>
  var global = {
    parent: 0,
    image: '',
    page: 1,
    limit: 100,
    file: {},
    statistic: {},
    data: [],
    item: JSON.parse('{item}')
  }

  $(document).ready(() => {
    $("#insert-box-content").hide()
    vremind.install('#item-parent', '#item-parent-suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', { action: 'parent-suggest', keyword: input }).then(data => {
          resolve(data['html'])
        })
        // resolve('Không có kết quả')
      })
    }, 300, 300)

    vremind.install('#product-insert-input', '#product-insert-input-suggest', (input) => {
      return new Promise((resolve) => {
        vhttp.checkelse('', { action: 'product-suggest', keyword: input }).then(data => {
          resolve(data['html'])
        })
      })
    }, 500, 500)
    vremind.install('#tag', '#tag-suggest', (input) => {
      return new Promise(resolve => {
        html = ''
        tags = searchtag(convert(input))
        tags.forEach(tag => {
          html += `
          <div class="suggest-item" onclick="selectTag('`+ tag + `', '#tag')"> 
              `+ tag + `
            </div>`
        });
        resolve(html)
      })
    }, 500, 500)
    vremind.install('#statistic-tag', '#statistic-tag-suggest', (input) => {
      return new Promise(resolve => {
        html = ''
        tags = searchtag(convert(input))
        tags.forEach(tag => {
          html += `
            <div class="suggest-item" onclick="selectTag('`+ tag + `', '#statistic-tag')"> 
              `+ tag + `
            </div>`
        });
        resolve(html)
      })
    }, 500, 500)
    installFile('insert')
    installCheckbox('product')
  })

  function insertNewItem() {
    $('#item-modal').modal('show')
    $("#item-code").val(''),
    $("#item-name").val(''),
    $("#item-price").val(0),
    $("#item-value").val(0),
    $("#item-down").val(0),
    $("#item-up").val(0),
    $("#item-position").val(''),
    $('#item-image-file').val(null)
    $('#item-image').attr('src', '')
    $('#item-image').hide()
    global.parent = 0
    global.image = ''
  }

  function selectParent(name, id) {
    $('#item-parent').val(name)
    global.parent = id
  }

  function selectImage(id) {
    files = $('#'+id+'-file')
    file = files[0].files[0]
    if (file) {
      global.image = file
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = (e) => {
        $('#'+ id).attr('src', e.target["result"])
        $('#'+ id).show()
      }
    }
  }

  function insertItemSubmit() {
    data = {
      code: $("#item-code").val(),
      name: $("#item-name").val(),
      price: $("#item-price").val(),
      parent: global.parent,
      value: $("#item-value").val(),
      down: $("#item-down").val(),
      up: $("#item-up").val(),
      position: $("#item-position").val(),
      image: global.image
    }
    if (!data['name'].length) return 0
    if (!data['price'].length) data['price'] = 0
    if (!data['value'].length) data['value'] = 0
    if (!data['down'].length) data['down'] = 0
    if (!data['up'].length) data['up'] = 0

    var fd = new FormData();    
    fd.append('code', $("#item-code").val());
    fd.append('name', $("#item-name").val());
    fd.append('price', $("#item-price").val());
    fd.append('parent', global.parent);
    fd.append('value', $("#item-value").val());
    fd.append('down', $("#item-down").val());
    fd.append('up', $("#item-up").val());
    fd.append('position', $("#item-position").val());
    fd.append('action', 'insert-item')
    fd.append('image', $('#item-image-file')[0].files[0])

    $.ajax({
      url: '',
      data: fd,
      processData: false,
      contentType: false,
      type: 'POST',
      success: function(data){
        $('#content').html(response.html)
        $('#insert-item').modal('hide')
      }
    });

    // vhttp.checkelse('', {
    //   action: 'insert-item',
    //   data: data
    // }).then(response => {
    //   $('#content').html(response.html)
    //   $('#insert-item').modal('hide')
    // })
  }

  function updateItem(id) {
    vhttp.checkelse('', {
      action: 'get-item',
      id: id 
    }).then(data => {
      $("#item-code").val(data['code']),
      $("#item-name").val(data['name']),
      $("#item-price").val(data['price']),
      $("#item-value").val(data['value']),
      $("#item-down").val(data['down']),
      $("#item-up").val(data['up']),
      $("#item-position").val(data['position']),
      $('#item-image').attr('src', data['image'])
      if (!data['image'].length) $('#item-image').hide()
      $('#item-image-file').val(null)
      global.parent = 0
      global.image = ''
      $("#item-update-modal").modal('show')
    })
  }

  function updateItemSubmit() {
    data = {
      code: $("#item-update-code").val(),
      name: $("#item-update-name").val(),
      price: $("#item-update-price").val(),
      parent: global.parent,
      value: $("#item-update-value").val(),
      down: $("#item-update-down").val(),
      up: $("#item-update-up").val(),
      position: $("#item-update-position").val(),
      image: global.image
    }
    if (!data['name'].length) return 0
    if (!data['price'].length) data['price'] = 0
    if (!data['value'].length) data['value'] = 0
    if (!data['down'].length) data['down'] = 0
    if (!data['up'].length) data['up'] = 0

    var fd = new FormData();    
    fd.append('code', $("#item-update-code").val());
    fd.append('name', $("#item-update-name").val());
    fd.append('price', $("#item-update-price").val());
    fd.append('parent', global.parent);
    fd.append('value', $("#item-update-value").val());
    fd.append('down', $("#item-update-down").val());
    fd.append('up', $("#item-update-up").val());
    fd.append('position', $("#item-update-position").val());
    if ($('#item-update-image').attr('src').length < 100) image = $('#item-update-image').attr('src') 
    else if ($('#item-update-image-file')[0].files[0]) image = $('#item-update-image-file')[0].files[0]
    else image = ''
    fd.append('image', image)
    fd.append('id', global.id)
    fd.append('action', 'update-item')

    $.ajax({
      url: '',
      data: fd,
      processData: false,
      contentType: false,
      type: 'POST',
      success: function(data){
        $('#content').html(response.html)
        $('#item-update-modal').modal('hide')
      }
    });
  }

  function selectTag(tag, selector) {
    $(selector).val(tag)
  }

  function searchtag(keyword) {
    data = []
    for (const key in global['tags']) {
      if (global['tags'].hasOwnProperty(key)) {
        if (key.search(keyword) >= 0) {
          data.push(global['tags'][key])
        }
      }
    }
    return data
  }

  function selectProduct(name, id) {
    $("#product-insert-input").val(name)
    $("#product-insert-input-val").val(id)
  }

  function insertProduct() {
    if (!$("#product-insert-input-val").val()) alert_msg('Chọn mặt hàng trước khi thêm')
    else vhttp.checkelse('', { action: 'insert-product', keyword: $("#product-insert-input").val(), id: $("#product-insert-input-val").val(), low: $("#product-insert-low").val() }).then(data => {
      $("#product-insert-input").val('')
      $("#product-insert-input-val").val('0')
      $('#content').html(data['html'])
      $('#product-insert-input-suggest').html(data['html2'])
      installCheckbox('product')
    })
  }

  function insertItem() {
    $("#item-code").val('')
    $("#item-name").val('')
    $("#item-modal").modal('show')
  }

  // function insertItemSubmit() {
  //   vhttp.checkelse('', { action: 'insert-item', name: $("#item-name").val(), code: $("#item-code").val() }).then(data => {
  //     $('#content').html(data['html'])
  //     $("#item-modal").modal('show')
  //     installCheckbox('product')
  //   })
  // }

  function installFile(name) {
    global['file'][name] = {
      input: $("#" + name + "-file"),
      selected: null
    }
    global['file'][name]['input'].change((e) => {
      global['file'][name]['selected'] = e
    })
  }

  function process(name) {
    $("#" + name + "-notify").text('Đang xử lý')

    if (!global['file'][name]['selected']) alert_msg('Chọn file excel trước')
    else processExcel(name)
  }

  function excel() {
    window.open('/general/excel')
  }

  function processExcel(name) {
    var reader = new FileReader();
    var rABS = !!reader.readAsBinaryString;
    var file = global['file'][name]['selected'].currentTarget.files[0]
    if (rABS) reader.readAsBinaryString(file);
    else reader.readAsArrayBuffer(file);

    reader.onload = (e) => {
      try {
        var data = e.target.result;
        if (!rABS) data = new Uint8Array(data);
        var wb = XLSX.read(data, { type: rABS ? 'binary' : 'array' });
        var object = XLSX.utils.sheet_to_row_object_array(wb.Sheets[wb.SheetNames[0]])
        console.log(object);
        $("#" + name + "-notify").hide()
        global['data'] = []
        global['file'][name]['selected'] = null

        // kiểm tra cấu trúc dữ liệu
        first = object[0]
        if (first.hasOwnProperty('code') && first.hasOwnProperty('name') && first.hasOwnProperty('n1') && first.hasOwnProperty('n2')) {
          // tách dữ liệu
          list = {}
          length = object.length
          for (let index = 0; index < length; index++) {
            hundred = Math.floor(index / 100)
            unit = index - hundred * 100
            if (!list[hundred]) list[hundred] = {}
            list[hundred][unit] = object[index]
            delete object[index]
          }

          // gửi dữ liệu tuần tự
          console.log(hundred);

          for (let index = 0; index <= hundred; index++) {
            vhttp.checkelse('', { action: 'update', data: list[index], check: Number($("#insert-check").prop('checked')) }).then(data => {
              if (index == 0) window.location.reload()
              index--
            })
          }

        }
        else {
          errorText(name + "-notify", 'Không đúng cấu trúc file Excel hoặc file quá lớn')
        }
      } catch (error) {
        console.log(error);

        errorText(name + "-notify", 'Có lỗi xảy ra')
      }
    }
  }

  function insertSubmit() {
    data = []
    list = []
    $(".check-insert:checked").each((index, item) => {
      val = item.getAttribute('rel')
      data.push(global['data'][val])
      list.push(val)
    })

    vhttp.checkelse('', { action: 'insert', data: data }).then(data => {
      // xóa data list trong global[data]
      global['data'] = global['data'].filter((item, index) => {
        return list.indexOf(index.toString()) < 0 // giữ lại những index không có trong list
      })

      goPage2('insert', global['page'])
      installCheckbox('insert')
    })
  }

  function parseTag() {
    html = ''
    global['tag'].forEach((item, index) => {
      html += `
          <button class="btn btn-info btn-xs" onclick="removeTag(`+ index + `)">
            `+ item + `
          </button>`
    });
    $("#product-tag-list").html(html)
  }

  function insertTag() {
    tag = trim($("#product-tag").val())
    if (tag.length) {
      // kiểm tra có phải danh sách không
      list = tag.split(', ')
      if (list.length > 0) {
        list.forEach(item => {
          if (checkTag(item)) global['tag'].push(item)
        })
      }
      else if (checkTag(item)) global['tag'].push(item)
      $("#product-tag").val('')
      parseTag()
    }
  }

  function getProductData() {
    return {
      id: global['id'],
      code: $("#product-code").val(),
      name: $("#product-name").val(),
      low: $("#product-low").val(),
      pos: $("#product-pos").val(),
      tag: global['tag']
    }
  }

  function editProductSubmit() {
    vhttp.checkelse('', { action: 'edit-product', data: getProductData() }).then(data => {
      $("#content").html(data['html'])
      $("#product-modal").modal('hide')
    })
  }

  function checkTag(name) {
    check = true
    global['tag'].forEach((item) => {
      if (item === name) check = false
    })
    return check
  }

  function removeTag(id) {
    global['tag'] = global['tag'].filter((item, index) => {
      return index !== id
    })
    parseTag()
  }

  function statisticContent() {
    vhttp.checkelse('', { action: 'statistic', tag: trim($("#statistic-tag").val()).split(', '), keyword: $("#statistic-keyword").val() }).then(data => {
      $("#statistic-content").html(data['html'])
    })
  }

  function checkSelectedItem() {
    list = []
    $(".check-product:checked").each((index, item) => {
      val = item.getAttribute('rel')
      list.push(val)
    })
    return list
  }

  function removeItem() {
    list = checkSelectedItem()

    vhttp.checkelse('', { action: 'remove', list: list }).then(data => {
      $("#content").html(data['html'])
      installCheckbox('product')
    })
  }

  function installCheckbox(name) {
    $(".check-" + name + "-all").change((e) => {
      $(".check-" + name).prop('checked', e.currentTarget.checked)
    })
  }

  function errorText(id, text) {
    $("#" + id).text(text)
    $("#" + id).show()
    $("#" + id).fadeOut(2000)
  }

  function convert(str) {
    str = str.toLowerCase();
    str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
    str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
    str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
    str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
    str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
    str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
    str = str.replace(/đ/g, "d");
    str = str.trim();
    return str;
  }
</script>
<!-- END: main -->