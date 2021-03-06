<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">

<style>
  .red {
    background: pink;
  }
  .yellow {
    background: lightyellow;
  }
</style>

{modal}

<div id="msgshow"></div>

<div class="row">
  <div class="col-sm-8">
    <div class="relative">
      Hàng hóa
      <input type="text" class="form-control" id="insert-name" placeholder="Tìm kiếm hàng hóa">
      <div class="suggest" id="insert-name-suggest"></div>
    </div>
    <p> Đang chọn: <span id="selected-item-name"> Chưa chọn </span> </p>
    <input type="hidden" id="selected-item-id" value="">
  </div>
  <div class="col-sm-8">
    Số lượng
    <input type="text" class="form-control" id="insert-number" placeholder="Số lượng">
  </div>
  <div class="col-sm-8">
    Hạn sử dụng
    <input type="text" class="form-control" id="insert-date" value="{today}">
  </div>
</div>
<div class="form-group text-center">
  <button class="btn btn-info" onclick="insert()"> Thêm hạn sử dụng </button>
  <button class="btn btn-warning" onclick="statisticModal()"> Thống kê </button>
  <!-- <button class="btn btn-info" onclick="excel()"> Thêm bằng excel </button> -->
</div>
<form class="form-group">
  <label class="form-inline">
    <input type="text" class="form-control" name="keyword" id="filter-keyword" placeholder="Từ khóa tìm kiếm">
    Số dòng một trang: <input type="text" class="form-control" name="limit" id="filter-limit" value="10">
    <select class="form-control" name="type" id="filter-type">
      <option value="0" {type0}> Thời gian thêm </option>
      <option value="1" {type1}> Hạn sử dụng tăng dần </option>
      <option value="2" {type2}> Hạn sử dụng giảm dần </option>
    </select>
    <button class="btn btn-info">
      Hiển thị
    </button>
  </label>
</form>

<div id="msgshow"></div>

<div id="content">
  {content}
</div>
<!-- <button class="btn btn-info" onclick="updateNumber()">
  Cập nhật số lượng theo mã
</button> -->

<script src="/modules/core/js/vhttp.js"></script>
<!-- <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jszip.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/xlsx.js"></script> -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  var global = {
    id: 0,
    page: 1,
    item: JSON.parse('{item}'),
    items: JSON.parse('{items}'),
    selected: {
      id: 0, name: ''
    }
  }
  var gals = ''
  var parse = []
  var selectFile = null

  $(document).ready(() => {
    installSuggest('insert-name', 'insert-name-suggest', 'selected-item-id')
    global['items'].forEach(item => {
      installSuggest('item-' + item, 'item-' + item + "-suggest", 'item-id-' + item)
    })
    $("#insert-date, .date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
    installCheckAll()
  })

  function statisticModal() {
    $('#statistic-modal').modal('show')
  }

  function statistic() {
    vhttp.checkelse('', {action: 'statistic', time: $('#statistic-time').val()}).then(data => {
      $('#statistic-content').html(data['html'])
    })
  }

  function convert(str) {
    str = str.toLowerCase().trim();
    str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
    str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
    str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
    str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
    str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
    str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
    str = str.replace(/đ/g, "d");
    return str;
  }

  function insert() {
    id = $("#selected-item-id").val()
    vhttp.checkelse('', { action: 'insert', id: id, name: $("#insert-name").val(), number: $("#insert-number").val(), date: $("#insert-date").val(), filter: checkFilter() }).then(data => {
      $("#content").html(data['html'])
      $("#selected-item-id").val(0)
      installCheckAll()
      if (data['item']) global['item'].push(data['item'])
      data['list'].forEach(item => {
        installSuggest('item-' + item, 'item-' + item + "-suggest", 'item-id-' + item)
      })
      $(".date").datepicker({
        format: 'dd/mm/yyyy',
        changeMonth: true,
        changeYear: true
      })
    })
  }

  function update(id) {
    $.post(
      '',
      { action: 'update', name: $("#item-" + id).val(), number: $("#item-number-" + id).val(), date: $("#item-date-" + id).val(), id: id, rid: $("#item-id-" + id).val() },
      (response, status) => {
        checkResult(response, status).then(data => {

        }, () => { })
      }
    )
  }

  function remove(id) {
    $.post(
      '',
      { action: 'remove', id: id, filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          installCheckAll()
          global['item'] = global['item'].filter((item, index) => {
            return item['id'] != id
          })
          data['list'].forEach(item => {
            installSuggest('item-' + item, 'item-' + item + "-suggest", 'item-id-' + item)
          })
          $(".date").datepicker({
            format: 'dd/mm/yyyy',
            changeMonth: true,
            changeYear: true
          })
        }, () => { })
      }
    )
  }

  function checkFilter() {
    page = global['page']
    limit = $("#filter-limit").val()
    if (Number(page) < 0) {
      page = 1
    }
    if (Number(limit) < 10) {
      limit = 10
    }
    return {
      page: page,
      limit: limit,
      type: $("#filter-type").val(),
      keyword: $("#filter-keyword").val()
    }
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      '',
      { action: 'filter', filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $('#content').html(data['html'])
          installCheckAll()
        }, () => { })
      }
    )
  }

  function selectItem(id, name, input, hidden) {
    global['selected'] = {
      id: id,
      name: name
    }
    $("#" + input).val(name)
    $("#" + hidden).val(id)
    if (input == 'insert-name') $("#selected-item-name").text(name)
  }

  function installCheckAll() {
    $("#item-check-all").change((e) => {
      checked = e.currentTarget.checked
      $(".event-checkbox").each((index, item) => {
        item.checked = checked
      })
    })
  }

  function updateNumber() {
    list = []
    $('.event-checkbox:checked').each((index, item) => {
      list.push(item.getAttribute('id').replace('item-check-', ''))
    })
    if (list.length) {
      $.post(
        '',
        { action: 'get-update-number', list: list },
        (response, status) => {
          checkResult(response, status).then(data => {
            $('#number-content').html(data['html'])
            $("#modal-number").modal('show')
            installCheckAll()
          }, () => { })
        }
      )
    }
  }

  function done(id) {
    global['id'] = id
    $("#done-modal").modal('show')
  }

  function doneSubmit() {
    $.post(
      '',
      {action: 'done', id: global['id']},
      (response, status) => {
        checkResult(response, status).then(data => {
          $('#statistic-content').html(data['html'])
          $("#done-modal").modal('hide')
        }, () => {}) 
      }
    )
  }

  function updateNumberSubmit() {
    list = {}
    $(".number").each((index, item) => {
      list[item.getAttribute('id').replace('number-', '')] = item.value
    })
    $.post(
      '',
      { action: 'update-number', list: list, filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $('#content').html(data['html'])
          $("#modal-number").modal('hide')
          installCheckAll()
        }, () => { })
      }
    )
  }

  function installSuggest(input, suggest, hidden) {
    var inputObj = $("#" + input)
    var suggestObj = $("#" + suggest)
    inputObj.keyup(e => {
      key = convert(e.currentTarget.value)

      list = global['item'].filter(item => {
        return item['key'].search(key) >= 0
      })
      html = ''
      if (list.length) {
        list.forEach(item => {
          html += `
            <div class="suggest-item" onclick="selectItem(`+ item['id'] + `, '` + item['name'] + `', '` + input + `', '` + hidden + `')">
              `+ item['name'] + `
            </div>
          `
        })
      }
      else {
        html = 'Không có kết quả'
      }
      suggestObj.html(html)
    })
    inputObj.focus(() => {
      suggestObj.show()
    })
    inputObj.blur(() => {
      setTimeout(() => {
        suggestObj.hide()
      }, 200);
    })
  }

  // function excel() {
  //   $("#modal-excel").modal('show')
  // }

  // var ExcelToJSON = function () {
  //   this.parseExcel = function (file) {
  //     reset()
  //     var reader = new FileReader();

  //     reader.onload = function (e) {
  //       var data = e.target.result;
  //       var workbook = XLSX.read(data, {
  //         type: 'binary'
  //       });

  //       // workbook.SheetNames.forEach(function(sheetName) {
  //       // Here is your object
  //       var XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[workbook.SheetNames[0]]);
  //       pars = JSON.stringify(XL_row_object);

  //       if (pars.length > 10) {
  //         gals = convertobj(XL_row_object)
  //         posted()
  //       }
  //       // })
  //       document.getElementById('file').value = null;
  //     };

  //     reader.onerror = function (ex) {
  //       showNotice("Tệp excel chọn bị lỗi, không thể trích xuất dữ liệu")
  //       console.log(ex);
  //     };

  //     if (file) {
  //       reader.readAsBinaryString(file);
  //     }
  //   };
  // };
  // var js = new ExcelToJSON()

  // function tick(e) {
  //   selectFile = e.target.files[0]
  //   js.parseExcel(selectFile)
  //   reset()
  // }

  // function refresh() {
  //   js.parseExcel(selectFile)
  // }

  function reset() {
    $("#notice").html('')
    $("#error").html('')
  }

  function showNotice(text) {
    $("#error").text(text)
    $("#error").show()
    setTimeout(() => {
      $("#error").fadeOut(1000)
    }, 1000);
  }

  function posted() {
    vhttp.checkelse('', { action: 'check', data: gals, filter: checkFilter() }).then(data => {
      $("#content").html(data['html'])
      $("#notice").html(data['notify'])
      if (data['error']) {
        $("#error").html(data['error'])
      }
    })
  }
</script>
<!-- END: main -->