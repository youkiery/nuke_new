<!-- BEGIN: main -->
<style>
  .right {
    overflow: auto;
  }
  .right-click {
    float: left;
    overflow: hidden;
    height: 20px;
    width: 80%;
  }
  .right2-click {
    float: left;
    overflow: hidden;
    height: 38px;
    width: 80%;
  }
  .bordered {
    border: 1px solid gray;
    border-radius: 10px;
    padding: 5px;
    margin: 5px;
  }
  .float-button {
    z-index: 10;
    position: fixed;
  }
  .marker {
    font-size: 1.5em;
    font-weight: bold;
    text-align: center;
    color: red;
  }
  .select {
    background: rgb(223, 223, 223);
    border: 2px solid deepskyblue;
  }
  .modal-lg {
    width: 90%;
  }
  .tableFixHead {
    overflow-y: auto;
  }
  .tableFixHead th {
    position: sticky;
    top: 0;
  }
  table  {
    border-collapse: collapse;
    width: 100%;
  }
  th {
    background: #eee;
  }
  td, th {
    padding: 5px;
  }
</style>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<div class="msgshow" id="msgshow"></div>

<div id="modal-print" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <button class="btn btn-info" onclick="save()">
          <span class="glyphicon glyphicon-floppy-disk"></span>
        </button>
        <button class="btn btn-info" onclick="printXSubmit()">
          <span class="glyphicon glyphicon-print"></span>
        </button>
        <button class="btn btn-info" onclick="save(1)">
          <span class="glyphicon glyphicon-download"></span>
        </button>
        <button class="btn btn-info" onclick="reloadAll()">
          <span class="glyphicon glyphicon-refresh"></span>
        </button>

        <table class="table table-bordered tableFixHead">
          <thead>
            <tr>
              <th> STT </th>
              <th class="text-center" style="width: 10%"> Mã thu phí </th>
              <th class="text-center" style="width: 20%"> Nội Dung Thu </th>
              <th class="text-center" style="width: 10%"> Xác định một serotype </th>
              <th class="text-center" style="width: 10%"> Số lượng mẫu xét nghiệm </th>
              <th class="text-center" style="width: 25%"> Thu giá dịch vụ theo Thông tư 283/2016/TT-BTC ngày 14/11/2016 & Quyết định số 29 & 29a/QĐ -TYV5 ngày 30/12/2016 </th>
              <th class="text-center" style="width: 10%"> Thành tiền </th>
              <th class="text-center" style="width: 10%">  Số và ngày thông báo kết quả xét nghiệm </th>
              <th></th>
            </tr>
          </thead>
          <tbody id="print-content"></tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<ul class="nav nav-tabs">
  <!-- BEGIN: user -->
  <li><a href="/{module_name}/#home"> Danh sách </a></li>
  <!-- END: user -->
  <!-- BEGIN: super_user -->
  <li><a href="/{module_name}/#menu1"> Thêm văn bản </a></li>
  <!-- END: super_user -->
  <li><a href="/{module_name}/#menu2"> Xuất ra excel </a></li>
  <!-- BEGIN: secretary -->
  <li class="active"><a href="#"> Kế toán </a></li>
  <!-- END: secretary -->
  <!-- BEGIN: printx -->
  <li><a href="/{module_name}/#menu4"> Văn thư </a></li>
  <!-- END: printx -->
</ul>
  <!-- BEGIN: secretary2 -->
  <div class="tab-pane active">
    <form onsubmit="filterE(event)">
      <div class="row form-group">
        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter-keyword" placeholder="Số thông báo" autocomplete="off">
        </div>
        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter-xcode" placeholder="Số ĐKXN" autocomplete="off">
        </div>
        <div class="col-sm-4">
          <select class="form-control" id="sfilter-limit">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="75">75</option>
            <option value="100">100</option>
          </select>
        </div>
        <div class="col-sm-4">
          <select class="form-control" id="sfilter-pay">
            <option value="0">
              Toàn bộ
            </option>
            <option value="1">
              Chưa trả
            </option>
            <option value="2">
              Đã trả
            </option>
          </select>
        </div>
        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter-unit" placeholder="Đơn vị">
        </div>
        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter-exam" placeholder="Kết quả xét nghiệm">
        </div>
      </div>
      <div class="form-group row">
        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter-owner" placeholder="Chủ hộ">
        </div>

        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter-sample" placeholder="Loại động vật">
        </div>

        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter-from" value="{last_week}">
        </div>

        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter-end" value="{today}">
        </div>
      </div>

      <div class="text-center">
        <button class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
      </div>
    </form>

    <button class="btn btn-info" style="float: right;" onclick="print()">
      In thông báo
    </button>
    <button class="btn btn-info" style="float: right;" onclick="selectAllRow(this)">
      Chọn tất cả
    </button>
    <button class="btn btn-info" style="float: right;" onclick="selectRow(this)">
      <span class="glyphicon glyphicon-unchecked" id="select-row"></span>
    </button>
    <button class="btn btn-info select-button" style="float: right;" onclick="changePay(1)" disabled>
      Thanh toán
    </button>
    <button class="btn btn-warning select-button" style="float: right;" onclick="changePay(0)" disabled>
      Chưa thanh toán
    </button>

    <div style="clear: both;"></div>

    <div id="secretary-list">
      {secretary}
    </div>
    <button class="btn btn-info float-button" style="top: 10px; right: 50px;" onclick="previewSecretary()">
      <span class="glyphicon glyphicon-print"></span>
    </button>
    <button class="btn btn-info float-button" style="top: 10px; right: 10px;" onclick="toggleSecretary()">
      <span class="glyphicon glyphicon-eye-close"></span>
    </button>
    <button class="btn btn-success float-button" style="top: 45px; right: 10px;" onclick="submitSecretary()">
      Lưu
    </button>
    <div id="secretary"></div>
  </div>
  <!-- END: secretary2 -->
<script>
  var style = '.table-bordered {border-collapse: collapse;}.table-wider td, .table-wider th {padding: 10px;}table {width: 100%;}table td {padding: 5px;}.no-bordertop {border-top: 1px solid white; }.no-borderleft {border-left: 1px solid white; }.c20, .c25, .c30, .c35, .c40, .c45, .c50, .c80 {display: inline-block;}.c20 {width: 19%;}.c25 {width: 24%;}.c30 {width: 29%;}.c35 {width: 34%;}.c40 {width: 39%;}.c45 {width: 44%;}.c50 {width: 49%;}.c80 {width: 79%;}.p11 {font-size: 11pt}.p12 {font-size: 12pt}.p13 {font-size: 13pt}.p14 {font-size: 14pt}.p15 {font-size: 15pt}.p16 {font-size: 16pt}.text-center, .cell-center {text-align: center;}.cell-center {vertical-align: inherit;} p {margin: 5px 0px;}'
  var profile = ['@page { size: A4 portrait; margin: 20mm 10mm 10mm 25mm; }', '@page { size: A4 landscape; margin: 20mm 10mm 10mm 25mm;}']
  var secretary = $("#secretary")
  var secretaryList = $("#secretary-list")
  var toggle = 1

  var sfilterKeyword = $("#sfilter-keyword")
  var sfilterXcode = $("#sfilter-xcode")
  var sfilterLimit = $("#sfilter-limit")
  var sfilterUnit = $("#sfilter-unit")
  var sfilterExam = $("#sfilter-exam")
  var sfilterSample = $("#sfilter-sample")
  var sfilterPay = $("#sfilter-pay")
  var sfilterOwner = $("#sfilter-owner")
  var sfilterFrom = $("#sfilter-from")
  var sfilterEnd = $("#sfilter-end")
  var remindv2 = JSON.parse('{remindv2}')
  var global = {
    select_data: JSON.parse('{select}'),
    select: false,
    signer: JSON.parse('{signer}'),
    page: 1,
    save: 0,
    saving: 0
  }
  const formatter = new Intl.NumberFormat('vi-VI', {
    style: 'currency',
    currency: 'VND'
  })
  // const formatter = new Intl.NumberFormat('vi-VI', {
  //   style: 'currency',
  //   currency: 'VND'
  // })

  $(this).ready(() => {
    installSelect()
  })

  $("#sfilter-from, #sfilter-end").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function add(id) {
    var time = new Date().getTime()
    var html = `
      <div id="`+ id +`-`+ time+`">
        <label style="width: 100%;">
          Nội dung thu
          <div class="input-group">
            <input class="form-control print-result-`+ id +`" type="text" index="`+ time+`"  rel="`+ id +`">
            <div class="input-group-btn">
              <button class="btn btn-danger" onclick="remove(`+ id +`, `+ time+`)"> Xóa </button>
            </div>
          </div>
        </label>
        <label style="width: 24%; float: left; margin-right: 2px;">
          Giá
          <input class="form-control price print-price-`+ id +`" type="text" index="`+ time+`"  rel="`+ id +`" value="0">
        </label>
        <label style="width: 24%; float: left; margin-right: 2px;">
          serotype
          <input class="form-control print-serotype-`+ id +`" type="text" index="`+ time+`"  rel="`+ id +`">
        </label>
        <label style="width: 24%; float: left; margin-right: 2px;">
          Số lượng
          <input class="form-control number print-number-`+ id +`" type="number" index="`+ time+`"  rel="`+ id +`" value="1">
        </label>
        <label style="width: 24%; float: left; margin-right: 2px;">
          Thành tiền
          <input class="form-control print-total-`+ id +`" type="text" index="`+ time+`"  rel="`+ id +`" value="0" readonly>
        </label>
        <div style="clear: both;"></div>
      </div>
    <hr>
    `
    $("#l-" + id).before(html)
  }

  function remove(id, index) {
    $("#" + id + "-" + index).remove()
    
    if (document.getElementById(id).children.length == 1) {
      add(id)
    }
  }

  function checkData() {
    var data = {}
    var datetime = {}
    global['select'].forEach(id => {
      data[id] = {
        data: [],
        datetime: $("#datetime-" + id).val(),
      }
      $(".print-result-" + id).each((index, item) => {
        var index = item.getAttribute('index')
        code = $(".print-cashcode-" + id + '[index='+ index +']')[0]
        data[id]['data'].push({
          result: $(".print-result-" + id + '[index='+ index +']').val(),
          code: trim(code.children[code.selectedIndex].innerText),
          number: $(".print-number-" + id + '[index='+ index +']').val(),
          serotype: $(".print-serotype-" + id + '[index='+ index +']').val()
        })
      })
    })
    return data
  }

  function parseCurrency(number) {
    if (number = Number(number)) {
      return formatter.format(number).replace(/ ₫/g, "").replace(/\./g, ",");
    }
    return 0
  }

  function installPrice() {
    $(".price, .number").keyup((e) => {
      var current = e.currentTarget
      var id = current.getAttribute('rel')
      var index = current.getAttribute('index')
      
      var number = $(".print-number-" + id + "[index="+ index +"]").val()
      var price = $(".print-price-" + id + "[index="+ index +"]").val().replace(/,/g, '')
      
      $(".print-price-" + id + "[index="+ index +"]").val(parseCurrency(price))
      $(".print-total-" + id + "[index="+ index +"]").val(parseCurrency(Number(number) * Number(price)))
    })
    $(".cashcode").change((e) => {
      var current = e.currentTarget
      var val = current.value.replace(',', '')
      var id = current.getAttribute('rel')
      var index = current.getAttribute('index')
      if (index == 1) {
        code = $(".print-cashcode-" + id + "[index=1]")[0]
        html = pickCashCode(trim(code.children[code.selectedIndex].innerText), global['select_data'])['html']
        
        $(".print-number-" + id).each((index, item) => {
          var index = item.getAttribute('index')
          var number = $(".print-number-" + id + "[index="+ index +"]").val()
          $(".print-cashcode-" + id + "[index="+ index +"]").html(html)
          $(".print-price-" + id + "[index="+ index +"]").val(parseCurrency(val))
          $(".print-price-" + id + "[index="+ index +"]").val(parseCurrency(val))
          $(".print-total-" + id + "[index="+ index +"]").val(parseCurrency(Number(number) * Number(val)))
        })
      }
      else {
        var number = $(".print-number-" + id + "[index="+ index +"]").val()
        
        $(".print-price-" + id + "[index="+ index +"]").val(parseCurrency(val))
        $(".print-total-" + id + "[index="+ index +"]").val(parseCurrency(Number(number) * Number(val)))
      }
    })
    // $(".cashcode").change((e) => {
    //   var current = e.currentTarget
    //   var val = current.value
    //   var id = current.getAttribute('rel')
    //   $(".print-number-" + id).each((index, item) => {
    //     var index = item.getAttribute('index')
    //     var number = $(".print-number-" + id + "[index="+ index +"]").val()
    //     $(".print-price-" + id + "[index="+ index +"]").val(parseCurrency(val))
    //     $(".print-total-" + id + "[index="+ index +"]").val(parseCurrency(Number(number) * Number(val)))
    //   })
    // })
  }

  function reload(id, index) {
    $.post(
      global['url'],
      {action: 'reload', id: id, index: index},
      (response, status) => {
        checkResult(response, status).then(data => {
          $(".print-" + id).each((index, item) => {
            if (index) {
              item.remove()
            }
          })
          $(".print-" + id).replaceWith(data['html'])
          installPrice()
        }, () => {})
      }
    )
  }

  function reloadAll() {
    $.post(
      global['url'],
      {action: 'reload-all', list: global['select']},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#print-content").html(data['html'])
          installPrice()
        }, () => {})
      }
    )
  }

  function print() {
    if (global['select']) {
      $.post(
        global['url'],
        {action: 'print', list: global['select']},
        (response, status) => {
          checkResult(response, status).then(data => {  
            $("#print-content").html(data['html'])
            installPrice()
            $("#modal-print").modal('show')
          }, () => {})
        }
      )
    }
  }

  function printXSubmit() {
    if (global['select']) {
      $.post(
        global['url'],
        {action: 'print-x', list: global['select']},
        (response, status) => {
          checkResult(response, status).then(data => {
            var winPrint = window.open('', '_blank', 'left=0,top=0,width=800,height=600');
            winPrint.focus()
            winPrint.document.write(data['html']);
            setTimeout(() => {
              winPrint.print()
              winPrint.close()
            }, 300)
          }, () => {})
        }
      )
    }
  }

  function save(type = 0) {
    if (global['select']) {
      data = checkData()
      perless = {}
      count = 0
      total = 0
      for (const key in data) {
        if (data.hasOwnProperty(key)) {
          const element = data[key];
          perless[key] = element
          total ++
          count ++
          if (count >= 10) {
            saveSubmit(perless, count, type)
            perless = {}
            count = 0
          }
        }
      }
      if (count >= 1) saveSubmit(perless, count, type)
      global['saving'] = 0
      global['save'] = total
    }
  }

  function saveSubmit(data, count, type = 0) {
    $.post(
      global['url'],
      {action: 'save', data: data},
      (response, status) => {
        checkResult(response, status).then(data => {  
          global['saving'] += count
          console.log(global['saving'] +'/'+ global['save']);
          
          if (global['saving'] == global['save']) {
            console.log('complete');
            alert_msg('Đã lưu')
            if (type == 1) {

              excelSubmit()
            }
          }
        }, () => {})
      }
    )
  }

  function excelSubmit() {
    $.post(
      global['url'],
      {action: 'excel', list: global['select']},
      (response, status) => {
        checkResult(response, status).then(data => {
          var winPrint = window.open('/excel/thong-bao-out-'+ data['time'] +'.xlsx');
        })
      }
    )
  }

  function selectRemindv2(name, type, value) {
    $("#"+ type +"-" + name).val(value)
  }

  function installRemindv2(name, type) {
    var timeout
    var input = $("#"+ type +"-" + name)
    var suggest = $("#"+ type +"-suggest-" + name)

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = paintext(input.val())
        var html = ''
        
        for (const index in remindv2[type]) {
          if (remindv2[type].hasOwnProperty(index)) {
            const element = paintext(remindv2[type][index]['name']);
            
            if (element.search(key) >= 0) {
              html += '<div class="suggest_item" onclick="selectRemindv2(\'' + name + '\', \'' + type + '\', \'' + remindv2[type][index]['name'] + '\')"><p class="right-click">' + remindv2[type][index]['name'] + '</p><button class="close right" data-dismiss="modal" onclick="removeRemindv2(\'' + name + '\', \'' + type + '\', ' + remindv2[type][index]['id']+')">&times;</button></div>'
            }
          }
        }
        suggest.html(html)
      }, 200);
    })
    input.focus(() => {
      suggest.show()
    })
    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 200);
    })
  }

  function installSelect() {
    $("tbody.selectable").click((e) => {
      var current = e.currentTarget
      colorSelected(current)
    })
  }

  function checkColor() {
    if (global['select']) {
      global['select'].forEach(id => {
        $("#" + id).each((index, item) => {
          if (!item.className == 'select') {
            id = item.getAttribute('id')
            item.className = ''
          }
          else {
            item.className = 'select'
          }
        })
      })
      $("#select-row").attr('class', 'glyphicon glyphicon-check')
    }
    else {
      $("#select-row").attr('class', 'glyphicon glyphicon-unchecked')
    }
  }

  function colorSelected(row) {
    if (global['select']) {
      if (row.className == 'select') {
        id = row.getAttribute('id')
        global['select'] = global['select'].filter((item) => {
          return item != id
        })
        row.className = ''
      }
      else {
        global['select'].push(row.getAttribute('id'))
        row.className = 'select'
      }
    }
  }

  function selectAllRow() {
    $.post(
      global['url'],
      {action: 'select-all', filter: getSecretaryFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {  
          global['select'] = JSON.parse(data['list'])
          checkColor()
        }, () => {})
      }
    )
  }

  function selectRow(button) {
    if (global['select']) {
      button.children[0].className = 'glyphicon glyphicon-unchecked'
      $(".select-button").prop('disabled', true)
      global['select'].forEach(item => {
        $("#" + item).attr('class', '')
      })
      global['select'] = false
    }
    else {
      button.children[0].className = 'glyphicon glyphicon-check'
      $(".select-button").prop('disabled', false)
      global['select'] = []
    }
  }

  function changePay(status) {
    if (global['select'].length) {
      $.post(
        global['url'],
        {action: 'change-pay', list: global['select'], type: status, filter: getSecretaryFilter()},
        (response, status) => {
          checkResult(response, status).then(data => {  
            secretaryList.html(data['html'])
            installSelect()
            global['select'] = []
          }, () => {})
        }
      )
    }    
  }

  function toggleSecretary() {
    if (toggle) {
      secretaryList.hide()
      secretary.show()
    }
    else {
      secretaryList.show()
      secretary.hide()
    }
    toggle = !toggle
  }

  function editSecret(id) {
    $.post(
      strHref,
      {action: 'editSecret', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          toggleSecretary()
          global_secretary = id
          global_ig = JSON.parse(data['ig'])
          // $("#smsample").html(parseField(JSON.parse(data['ig'])))
          secretary.html(data['html'])
          parseIgSecret(global_ig)
          installCash()
          $("#sdate").datepicker({
            format: 'dd/mm/yyyy',
            changeMonth: true,
            changeYear: true
          });
        }, () => {})
      }
    )
  }

  function parseIgSecret(data) {
    var html = ''
    var installer = []
    var index = 1
    for (const key in data) {
      if (data.hasOwnProperty(key)) {
        const element = data[key];
        select_data = pickCashCode(element['code'])
        html += `
          <div class="row form-group" style="width: 100%;">
            <button type="button" class="close" data-dismiss="modal" onclick="removeIgSecret('`+ key +`')">&times;</button>
            <label class="col-sm-6">
              Chỉ tiêu:
            </label>
            <div class="col-sm-9 relative">
              <input type="text" class="form-control exam-sx exam-sx-`+index+`" value="`+ key +`" id="examsx-`+ (index) +`" autocomplete="off">
              <div class="suggest" id="examsx-suggest-`+ (index) +`"> </div>
            </div>
            <div class="col-sm-3">
              <input type="number" class="form-control number-sx-`+index+`" id="number-sx`+ (index) +`" value="`+ element['number'] +`" autocomplete="off">
            </div>
            <div class="col-sm-3">
              <select class="form-control cash-sx cash-sx-`+index+`" id="cash-sx`+ (index) +`" index="`+ index +`">
                `+ select_data['html'] +`
              </select>
            </div>
            <label class="col-sm-2" id="price-sx`+ index +`" style="line-height: 28px">
              `+ select_data['val'] +`
            </label>
          </div>
        `
        installer.push({
          name: index,
          type: 'examsx'
        })

        index ++
      }
    }
    html += `
      <button class="btn btn-info" onclick="insertIgSecret()">
        Thêm
      </button>`
    $("#smsample").html(html)
    installer.forEach(item => {
      installRemindv2(item['name'], item['type'])
    })
    installRemindv2('0', 'reformer');
    installCash()
  }

  function installCash() {
    $(".cash-sx").change((e) => {
      current = e.currentTarget
      val = current.value
      index = current.getAttribute('index')
      $("#price-sx"+ index).html(val)
    })
  }

  function parseCurrency(number) {
    if (number = Number(number)) {
      return formatter.format(number).replace(/ ₫/g, "").replace(/\./g, ",");
    }
    return 0
  }

  function pickCashCode(name) {
    html = ''
    val = 0
    for (const key in global['select_data']) {
      if (global['select_data'].hasOwnProperty(key)) {
        xtra = ''
        if (name == key) {
          xtra = 'selected'
          val = global['select_data'][key]
        }
        html += `
          <option value="`+ global['select_data'][key] +`" `+ xtra +`>
            `+ key +`
          </option>`
      }
    }
    return {html: html, val: val}
  }

  function removeIgSecret(key) {
    var dat = {}
    $(".exam-sx").each((index, item) => {
      code = $("#cash-sx" + (index + 1))[0]
      dat[item.value] = {
        number: $("#number-sx" + (index + 1)).val(),
        code: trim(code.children[code.selectedIndex].innerText)
      }
    })
    global_ig = dat
    delete global_ig[key]
    if (!Object.keys(global_ig)) {
      global_ig = {'': ''}
    }
    parseIgSecret(global_ig)
  }

  function insertIgSecret() {
    var dat = {}
    $(".exam-sx").each((index, item) => {
      code = $("#cash-sx" + (index + 1))[0]
      
      dat[item.value] = {
        number: $("#number-sx" + (index + 1)).val(),
        code: trim(code.children[code.selectedIndex].innerText)
      }
    })
    dat[''] = {
      number: 1,
      code: ''
    }
    global_ig = dat
    parseIgSecret(global_ig)
  }

  function checkSecretary() {
    var temp = {}
    $(".exam-sx").each((index, item) => {
      var idp = item.getAttribute('class').replace('form-control exam-sx exam-sx-', '')
      code = $("#cash-sx" + idp)[0]
      temp[$(".exam-sx-" + idp).val()] = {
        number: $("#number-sx" + idp).val(),
        code: trim(code.children[code.selectedIndex].innerText)
      }
    })
    var data = {
      date: $('#sdate').val(),
      org: $('#sorg').val(),
      address: $('#saddress').val(),
      phone: $('#sphone').val(),
      fax: $('#sfax').val(),
      mail: $('#smail').val(),
      content: $('#scontent').val(),
      type: $('#stype').val(),
      sample: $('#ssample').val(),
      xcode: $('#sxcode1').val() + ',' + $('#sxcode2').val() +','+ $('#sxcode3').val(),
      mcode: $('#smcode').val(),
      reformer: $('#reformer-0').val(),
      pay: ($("#pay1").prop('checked') ? 1 : 0),
      ig: temp,
      owner: $("#sowner").val(),
      ownphone: $("#sownphone").val(),
      ownaddress: $("#sownaddress").val()
    }
    return data
  }

  function submitSecretary() {
    $.post(
      strHref,
      {action: 'secretary', id: global_secretary, data: checkSecretary()},
      (response, status) => {
        checkResult(response, status).then(data => {
          // console.log(data)
        }, () => {})
      }
    )
  }

  function previewSecretary() {
    data = checkSecretary()
    var html = `
      <div style="position: relative; text-align: center; width: fit-content; margin-left: 10pt;">
        CHI CỤC THÚ Y VÙNG <br>
        <b> Bộ phận một cửa - Phòng tổng hợp </b>
        <div class="position: absolute; top 50pt; left: 150pt; width: 100pt; height: 1pt; background: black;"></div>
      </div>
      <p style="float: right;">
        <i> Ngày (date0) tháng (date1) năm (date2) </i>
      </p>
      <div style="clear: right;"></div>
      <p class="text-center">
        <b> DỊCH VỤ VÀ PHÍ, LỆ PHÍ </b>
      </p>
      <p class="text-center"> <b> Đề nghị Phòng Kế toán thực hiện thu dịch vụ và các khoản khí, lệ phí sau: </b>  </p>
      <p>
        1. Tên tổ chức, cá nhân: (org)
      </p>
      <p>
        2. Địa chỉ giao dịch: (address)
      </p>
      <p style="float: left; margin: 0pt 0pt 0pt 20pt; width: 150pt;"> Điện thoại: (phone) </p>
      <p style="float: left; margin: 0pt 0pt 0pt 20pt; width: 70pt;"> Fax: (fax) </p>
      <p style="float: left; margin: 0pt 0pt 0pt 20pt;"> Email: (mail) </p>
      <div style="clear: left;"></div>
      <p>
        3. Nội dung công việc: (content)
      </p>
      <p>
        <i> Nội dung thu: </i>
      </p>
      <p> 4.1. Dịch vụ (theo TT.283-Bộ Tài chính và QĐ số 29 của Cơ quan) </p>
      <p> a) Lấy mẫu: <span style="width: 100pt;"> (type) </span>; &nbsp; - Loài động vật: (sample)</p>
      <p> b) Xét nghiệm: Số phiếu kết quả xét nghiệm: (xcode) </p>
      (xcontent)
      <p>
        Thông báo số: (mcode)/TYV5-TH, ngày (date)
      </p>
      <div class="text-center" style="float: right; margin-right: 100pt;">
        <b>Người đề nghị</b><br>
        <i> Ký, ghi rõ họ tên </i>
        <br><br><br><br><br>
        (reformer)
      </div>`
      var date = data['date'].split('/')
      var xcode = data['xcode'].split(',')
      html = html.replace('(date0)', date[0])
      html = html.replace('(date1)', date[1])
      html = html.replace('(date2)', date[2])
      html = html.replace('(org)', data['org'])
      html = html.replace('(address)', data['address'])
      html = html.replace('(phone)', data['phone'])
      html = html.replace('(fax)', data['fax'])
      html = html.replace('(mail)', data['mail'])
      html = html.replace('(type)', data['type'])
      html = html.replace('(sample)', data['sample'])
      html = html.replace('(content)', data['content'])
      html = html.replace('(mcode)', data['mcode'])
      html = html.replace('(xcode)', xcode.join('/'))
      html = html.replace('(date)', data['date'])
      html = html.replace('(reformer)', data['reformer'])
      var temp = ''
      for (const key in data['ig']) {
        if (data['ig'].hasOwnProperty(key)) {
          const element = data['ig'][key];
          temp += '<p><div style="width: 80%; display: inline-block;">&emsp;- Chỉ tiêu: '+key+'</div><span style="width: 20%;"> '+ element['code'] +' / ' + element['number'] + ' </span> </p>'
        }
      }
      html = html.replace('(xcontent)', temp)

      var html = '<style>' + style + profile[0] + '</style>' + html
      var winPrint = window.open('', '', 'left=0,top=0,width=800,height=600,toolbar=0,scrollbars=0,status=0');
      winPrint.focus()
      winPrint.document.write(html);
      winPrint.print()
      winPrint.close()
  }

  function getSecretaryFilter() {
    return {
      page: global['page'],
      keyword: sfilterKeyword.val(),
      xcode: sfilterXcode.val(),
      limit: sfilterLimit.val(),
      unit: sfilterUnit.val(),
      exam: sfilterExam.val(),
      sample: sfilterSample.val(),
      pay: sfilterPay.val(),
      from: sfilterFrom.val(),
      end: sfilterEnd.val(),
      owner: sfilterOwner.val()
    }
  }

  function filterE(e) {
    e.preventDefault()
    goPage(1)
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      strHref,
      {action: 'secretaryfilter', page: page, filter: getSecretaryFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          secretaryList.html(data['html'])
          installSelect()
        }, () => {})
      }
    )
  }

</script>
<!-- END: main -->