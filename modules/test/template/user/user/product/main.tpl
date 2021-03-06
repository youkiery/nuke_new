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

  .col-1, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-10, .col-11, .col-12 {
    float: left;
  }

  .col-1 {width: 8.33%;}
  .col-2 {width: 16.66%;}
  .col-3 {width: 25%;}
  .col-4 {width: 33.33%;}
  .col-5 {width: 41.66%;}
  .col-6 {width: 50%;}
  .col-7 {width: 58.33%;}
  .col-8 {width: 66.66%;}
  .col-9 {width: 75%;}
  .col-10 {width: 83.33%;}
  .col-11 {width: 91.66%;}
  .col-12 {width: 100%;}

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

<div class="rows form-group">
  <form>
    <input type="hidden" name="nv" value="{nv}">
    <input type="hidden" name="op" value="{op}">
    <div class="col-3">
      <input type="text" class="form-control" name="keyword" value="{keyword}"
        placeholder="Tìm kiếm theo tên hàng, mã hàng,...">
    </div>
    <div class="col-2">
      <div class="relative">
        <input type="text" class="form-control" id="tag" name="tag" value="{tag}"
          placeholder="VD: dây dắt, vòng cổ, xích inox, cổ xanh đỏ đen,...">
        <div class="suggest" id="tag-suggest"> </div>
      </div>
    </div>
    <div class="col-2">
      <select class="form-control" name="limit">
        <option value="10" {check10}> 10 </option>
        <option value="20" {check20}> 20 </option>
        <option value="50" {check50}> 50 </option>
        <option value="100" {check100}> 100 </option>
        <option value="200" {check200}> 200 </option>
      </select>
    </div>
    <div class="col-2">
      <button class="btn btn-info">
        <span class="glyphicon glyphicon-search"></span>
      </button>
    </div>
  </form>
  <div class="col-3" style="text-align: right;">
    <button class="btn btn-success" onclick="insertItem()">
      Thêm hàng hóa
    </button>
  </div>
</div>

<div class="form-group rows">
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
  <div class="col-6" style="text-align: right;">
    <button class="btn btn-danger" onclick="removeItem()">
      Xóa
    </button>
    <button class="btn btn-info" onclick="$('#insert-modal').modal('show')">
      Cập nhật
    </button>
  </div>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vremind-6.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script>
  var global = {
    page: 1,
    limit: 100,
    file: {},
    tag: {},
    statistic: {},
    list: JSON.parse('{list}'),
    tags: JSON.parse('{tags}'),
    data: [],
    // allow: ['SHOP', 'SHOP>>Balo, giỏ xách', 'SHOP>>Bình xịt', 'SHOP>>Cát vệ sinh', 'SHOP>>Dầu tắm', 'SHOP>>Đồ chơi', 'SHOP>>Đồ chơi - vật dụng', 'SHOP>>Giỏ-nệm-ổ', 'SHOP>>Khay vệ sinh', 'SHOP>>Nhà, chuồng', 'SHOP>>Thuốc bán', 'SHOP>>Thuốc bán>>thuốc sát trung', 'SHOP>>Tô - chén', 'SHOP>>Vòng-cổ-khớp', 'SHOP>>Xích-dắt-yếm']
    allow: ["SHOP", "SHOP>>Balo, giỏ xách", "SHOP>>Bình xịt", "SHOP>>Cát vệ sinh", "SHOP>>Dầu tắm", "SHOP>>Đồ chơi", "SHOP>>Đồ chơi - vật dụng", "SHOP>>Giỏ-nệm-ổ", "SHOP>>Khay vệ sinh", "SHOP>>Nhà, chuồng", "SHOP>>Thức ăn", "SHOP>>Thuốc bán", "SHOP>>Thuốc bán>>thuốc sát trung", "SHOP>>Tô - chén", "SHOP>>Vòng-cổ-khớp", "SHOP>>Xích-dắt-yếm"]
  }

  $(document).ready(() => {
    $("#insert-box-content").hide()
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
    else  vhttp.checkelse('', { action: 'insert-product', keyword: $("#product-insert-input").val(), id: $("#product-insert-input-val").val(), low: $("#product-insert-low").val() }).then(data => {
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

  function insertItemSubmit() {
    vhttp.checkelse('', { action: 'insert-item', name: $("#item-name").val(), code: $("#item-code").val() }).then(data => {
      $('#content').html(data['html'])
      $("#item-modal").modal('show')
      installCheckbox('product')
    })
  }

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
    window.open('{excelurl}')
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

  function editProduct(id) {
    vhttp.checkelse('', { action: 'get-product', id: id }).then(data => {
      global['id'] = id
      $("#product-code").val(data['code'])
      $("#product-name").val(data['name'])
      $("#product-low").val(data['low'])
      $("#product-pos").val(data['pos'])
      if (!data['tag'].length) global['tag'] = []
      else global['tag'] = data['tag']
      parseTag()
      $("#product-modal").modal('show')
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