<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

{modal}

<style>
  .excel {
    background: lightskyblue;
    color: white;
    font-size: 0.8em;
    border-radius: 20px;
    padding: 5px;
  }

  .rows::after {
    content: "";
    clear: both;
    display: table;
  }

  .col-6 {
    float: left;
  }

  .col-6 {
    width: 50%;
  }


  a.btn-default {
    color: #333;
  }

  select.form-control {
    padding: 0px;
  }

  .suggest {
    z-index: 10;
  }

  .suggest-box {
    width: 100%;
    margin-bottom: 0px;
  }

  .suggest-box:hover {
    background: lightgreen;
  }

  .red {
    background: pink;
  }

  .sl {
    float: left;
    width: calc(100% - 10px);
  }

  .sr {
    float: right;
    width: 10px;
  }

  .sr:hover {
    color: red;
  }

  .green {
    background: green;
    color: white
  }

  .item {
    border-top: 1px solid lightgray;
    padding: 5px;
  }
</style>

<div id="msgshow"></div>

<div class="form-group">
  <button class="btn btn-info right" onclick="reportModal()">
    Thống kê
  </button>
  <button class="btn btn-success right" onclick="importModal()">
    Thêm phiếu nhập
  </button>
  <button class="btn btn-success right" onclick="exportModal()">
    Thêm phiếu xuất
  </button>
</div>

<ul class="nav nav-tabs">
  <li class="active"><a data-toggle="tab" href="#material-tab"> Vật tư, hóa chất </a></li>
  <li><a data-toggle="tab" href="#source-tab"> Nguồn cung </a></li>
  <li><a data-toggle="tab" href="#import-tab"> Phiếu nhập </a></li>
  <li><a data-toggle="tab" href="#export-tab"> Phiếu xuất </a></li>
  <li><a data-toggle="tab" href="#excel"> Xuất Excel </a></li>
</ul>

<div class="tab-content">
  <div id="material-tab" class="tab-pane fade in active">
    <div class="rows form-group">
      <div class="col-6">
        <label for="material-keyword"></label>
        <form class="input-group" onsubmit="return filter(event, 'material')">
          <input type="text" class="form-control" id="material-keyword" placeholder="Tìm kiếm vật tư theo tên">
          <div class="input-group-btn"> <button class="btn btn-info"> Tìm kiếm </button> </div>
        </form>
      </div>
    </div>

    <div id="material">
      {content}
    </div>
  </div>
  <div id="import-tab" class="tab-pane fade">
    <div class="rows form-group">
      <div class="col-6">
        <label for="import-keyword"></label>
        <form class="input-group" onsubmit="return filter(event, 'import')">
          <input type="text" class="form-control" id="import-keyword" placeholder="Tìm kiếm vật tư theo tên">
          <div class="input-group-btn"> <button class="btn btn-info"> Tìm kiếm </button> </div>
        </form>
      </div>
    </div>

    <div id="import">
      {import_content}
    </div>
  </div>

  <div id="export-tab" class="tab-pane fade">
    <div class="rows form-group">
      <div class="col-6">
        <label for="export-keyword"></label>
        <form class="input-group" onsubmit="return filter(event, 'export')">
          <input type="text" class="form-control" id="export-keyword" placeholder="Tìm kiếm vật tư theo tên">
          <div class="input-group-btn"> <button class="btn btn-info"> Tìm kiếm </button> </div>
        </form>
      </div>
    </div>

    <div id="export">
      {export_content}
    </div>
  </div>
  <div id="source-tab" class="tab-pane fade">
    <div class="rows form-group">
      <div class="col-6">
        <label for="source-keyword"></label>
        <form class="input-group" onsubmit="return filter(event, 'source')">
          <input type="text" class="form-control" id="source-keyword" placeholder="Tìm kiếm vật tư theo tên">
          <div class="input-group-btn"> <button class="btn btn-info"> Tìm kiếm </button> </div>
        </form>
      </div>
    </div>

    <div id="source">
      {source_content}
    </div>
  </div>
  <div id="excel" class="tab-pane fade">
    <label class="row" style="width: 100%;">
      <div class="col-sm-6">Ngày bắt đầu</div>
      <div class="col-sm-12">
        <input type="text" value="{last_week}" class="date form-control" id="excelf">
      </div>
    </label>
    <label class="row" style="width: 100%;">
      <div class="col-sm-6">Ngày kết thúc </div>
      <div class="col-sm-12">
        <input type="text" value="{today}" class="date form-control" id="excelt">
      </div>
    </label>

    <div class="relative">
      <input type="text" class="form-control" id="excel-filter" placeholder="Tìm kiếm, chạm vật tư để thêm">
      <div class="suggest" id="excel-filter-suggest"> </div>
    </div>

    <div
      style="border: 1px solid light gray; border-radius: 10px; padding: 10px; overflow-y: scroll; overflow-x: hidden; height: 200px; display: none;"
      id="excel-item"> </div>
    <div id="excel-list" style="margin: 5px;"></div>
    <p style="text-align:center; color: gray; display: none;" id="excel-tap"> Chạm vật tư để xóa </p>

    <!-- khách hàng, địa chỉ, email, điện thoại, chỉ hộ, nơi lấy mẫu, mục đích, nơi nhận, người phụ trách -->
    <!-- <label style="width: 30%"> <input type="checkbox" class="po" id="index" checked readonly> STT </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="type" checked readonly> Loại hóa chất </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="export" checked readonly> Xuất </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="import" checked readonly> Nhập </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="exporttime" checked readonly> Ngày xuất </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="importtime" checked readonly> Ngày nhập </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="remain" checked readonly> Tồn kho </label> -->
    <div class="text-center">
      <button class="btn btn-info" onclick="download()">
        Xuất ra Excel
      </button>
    </div>
  </div>
</div>

<script src="/modules/core/js/vremind-7.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {
    excel: [],
    page: {
      report: 1,
      material: 1,
      import: 1,
      export: 1,
      source: 1
    },
    selected: {
      'import': [],
      'export': [],
    },
    report_action: {
      'm1': 'report',
      'm2': 'report_limit',
      'm3': 'report_expire'
    },
    'ia': 0,
    'index': 0,
    'name': '',
    'today': '{today}',
    report: {},
    type: []
  }
  var insertLine = {
    'import': () => {
      global.ia++
      $(`
        <tbody class="import" ia="` + global.ia + `">
          <tr>
            <td>
              <div class="relative">
                <div class="input-group">
                  <input type="text" class="form-control btn-edit" id="import-type-`+ global.ia + `">
                  <input type="hidden" class="form-control" id="import-type-val-`+ global.ia + `">
                  <div class="input-group-btn">
                    <button class="btn btn-success btn-edit" onclick="materialModal('import', `+ global.ia + `)">
                      <span class="glyphicon glyphicon-plus"></span>
                    </button>
                  </div>
                </div>
                <div class="suggest" id="import-type-suggest-`+ global.ia + `"></div>
              </div>
            </td>
            <td> <input class="form-control date-`+ global.ia + `" id="import-date-` + global.ia + `" value="` + global['today'] + `"> </td>
            <td> 
              <div class="relative">
                <div class="input-group">
                  <input type="text" class="form-control" id="import-source-`+ global.ia + `">
                  <input type="hidden" class="form-control" id="import-source-val-`+ global.ia + `">
                  <div class="input-group-btn">
                    <button class="btn btn-success" onclick="insertSource('import', `+ global.ia + `)">
                      <span class="glyphicon glyphicon-plus"></span>
                    </button>
                  </div>
                </div>
                <div class="suggest" id="import-source-suggest-`+ global.ia + `"></div>
              </div>
            </td>
            <td> <input class="form-control" id="import-number-`+ global.ia + `" value="0"> </td>
            <td> <input class="form-control date-`+ global.ia + `" id="import-expire-` + global.ia + `" value="` + global['today'] + `"> </td>
            <td> <input class="form-control" id="import-note-`+ global.ia + `"> </td>
            <td>
              <button class="btn btn-danger btn-xs btn-edit" onclick="removeRow(`+ global.ia + `)">
                xóa
              </button>
            </td>
          </tr>
        </tbody>
      `).insertAfter('#import-insert-modal-content')
      vremind.install('#import-type-' + global.ia, '#import-type-suggest-' + global.ia, ((input, ia) => {
        return new Promise(resolve => {
          vhttp.checkelse('', {
            action: 'material-suggest',
            keyword: input,
            ia: ia
          }).then((resp) => {
            resolve(resp.html)
          })
        })
      }), 300, 300, 0, global.ia)
      vremind.install('#import-source-' + global.ia, '#import-source-suggest-' + global.ia, ((input, ia) => {
        return new Promise(resolve => {
          vhttp.checkelse('', {
            action: 'source-suggest',
            keyword: input,
            ia: ia
          }).then((resp) => {
            resolve(resp.html)
          })
        })
      }), 300, 300, 0, global.ia)
      $(".date-" + global.ia).datepicker({
        format: 'dd/mm/yyyy',
        changeMonth: true,
        changeYear: true
      });
    },
    'export': (id) => {
      vhttp.checkelse('', {
        action: 'get-detail',
        id: id
      }).then(resp => {
        resp.list.forEach((detail) => {
          global.ia++
          if (!$('[index=' + detail['id'] + ']').length) {
            $(`
              <tbody class="export" index="`+ detail['id'] + `" ia="` + global.ia + `">
                <tr>
                  <td>
                    `+ detail['name'] + `
                  </td>
                  <td> <input class="form-control date-`+ global.ia + `" id="export-date-` + global.ia + `" value="` + global['today'] + `"> </td>
                  <td> `+ detail['source'] + ` </td>
                  <td> <span id="export-remain-`+ global.ia + `"> ` + detail['number'] + ` </span> </td>
                  <td> <input class="form-control" id="export-number-`+ global.ia + `" value="` + 0 + `"> </td>
                  <td> `+ detail['expire'] + ` </td>
                  <td> <input class="form-control" id="export-note-`+ global.ia + `"> </td>
                  <td>
                    <button class="btn btn-danger btn-xs btn-edit" onclick="removeRow(`+ global.ia + `)">
                      xóa
                    </button>
                  </td>
                </tr>
              </tbody>
            `).insertAfter('#export-insert-modal-content')
            $(".date-" + global.ia).datepicker({
              format: 'dd/mm/yyyy',
              changeMonth: true,
              changeYear: true
            });
          }
        })
      })
    }
  }

  var getLine = {
    'import': () => {
      data = []
      msg = ''
      $(".import").each((index, item) => {
        ia = trim(item.getAttribute('ia'))
        temp = {
          item: $('#import-type-' + ia).val(),
          itemid: $('#import-type-val-' + ia).val(),
          date: $('#import-date-' + ia).val(),
          source: $('#import-source-' + ia).val(),
          sourceid: $('#import-source-val-' + ia).val(),
          number: $('#import-number-' + ia).val(),
          expire: $('#import-expire-' + ia).val(),
          note: $('#import-note-' + ia).val()
        }
        if (!(temp.item.length || temp.itemid.length)) return msg = 'Chưa chọn hóa chất'
        if (!(temp.source.length || temp.sourceid.length)) return msg = 'Chưa chọn nguồn cung'
        if (temp['number'] <= 0) return msg = 'Số lượng nhỏ hơn 1'
        data.push(temp)
      })
      if (msg.length) return msg
      if (!data.length) return 'Chưa nhập mục nào'
      return data
    },
    'export': () => {
      data = []
      msg = ''
      $(".export").each((index, item) => {
        ia = trim(item.getAttribute('ia'))
        id = trim(item.getAttribute('index'))
        temp = {
          id: id,
          number: $("#export-number-" + ia).val(),
          note: $("#export-note-" + ia).val()
        }
        if (temp['number'] == 0) return msg = 'Hãy nhập số lượng`'
        data.push(temp)
      })
      if (msg.length) return msg
      if (!data.length) return 'Chưa nhập mục nào'
      return data
    }
  }

  function excelId() {
    var list = []
    global.excel.forEach(item => {
      list.push(item.id)
    })
    return list.join(',')
  }

  $(document).ready(() => {
    $(".date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });

    vremind.install('#excel-filter', '#excel-filter-suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', {
          action: 'excel-suggest',
          keyword: input,
          id: excelId()
        }).then((resp) => {
          resolve(resp.html)
        })
      })
    }, 300, 300)

    vremind.install('#export-item-finder', '#export-item-finder-suggest', (input => {
      return new Promise(resolve => {
        vhttp.checkelse('', {
          action: 'item-suggest',
          keyword: input,
        }).then((resp) => {
          resolve(resp.html)
        })
      })
    }), 300, 300)
    vremind.install('#report-type', '#report-type-suggest', (input => {
      return new Promise(resolve => {
        vhttp.checkelse('', {
          action: 'report-suggest',
          keyword: input,
        }).then((resp) => {
          var list = resp.list
          var html = ''

          list.forEach(item => {
            html += `
              <label class="suggest-box"">
                `+ item.name + `
                <input class="suggest_box" id="report-`+ item.id + `" type="checkbox" style="float: right;" ` + ((global.report[item.id] && global.report[item.id].status) ? 'checked' : '') + ` onchange="changeSelect(` + item.id + `, '` + item.name + `')">
              </label>`
          })
          resolve(html)
        })
      })
    }), 300, 300, 1)
    vremind.install('#report-source', '#report-source-suggest', (input => {
      return new Promise(resolve => {
        vhttp.checkelse('', {
          action: 'report-source-suggest',
          keyword: input,
        }).then((resp) => {
          resolve(resp.html)
        })
      })
    }), 300, 300)
    $(".date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function filter(e, func = 'material') {
    e.preventDefault()
    goPage(1, func)
    return false
  }

  function goPage(page = 1, func = 'material') {
    vhttp.checkelse(
      '', {
      action: 'filter',
      keyword: $('#' + func + '-keyword').val(),
      page: page,
      func: func
    }
    ).then(resp => {
      global[func] = page
      $('#' + func).html(resp['html'])
    })
  }

  function changeSelect(id, name) {
    global.report[id] = {
      name: name,
      status: $('#report-' + id).prop('checked')
    }
    var list = []
    for (const key in global.report) {
      if (Object.hasOwnProperty.call(global.report, key)) {
        list.push(global.report[key].name)
      }
    }
    $('#report-type-text').text(list.join(', '))
  }

  function clearReportType() {
    global['report'] = {}
    $('.suggest_box').prop('checked', false)
    $('#report-type-text').text('')
  }

  function clearReportSource() {
    $('#report-source').val('')
    $('#report-source-val').val('0')
  }

  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////

  function reportModal() {
    $('#report-modal').modal('show')
  }

  function pickSuggest(index, name) {
    $('#report-source').val(name)
    $('#report-source-val').val(index)
  }

  function removeSource(id) {
    global.id = id
    $('#remove-source-modal').modal('show')
  }

  function removeSourceSubmit() {
    vhttp.checkelse('', {
      action: 'remove-source',
      id: global.id
    }).then(resp => {
      $('#source').html(resp.html)
      $('#remove-source-modal').modal('hide')
    })
  }

  function updateSourceSubmit() {
    vhttp.checkelse('', {
      action: 'update-source',
      id: global.id,
      data: {
        name: $('#source-name').val(),
        note: $('#source-note').val(),
      }
    }).then(resp => {
      $('#source').html(resp.html)
      $('#source-modal').modal('hide')
    })
  }

  function updateSource(id) {
    global.id = id
    vhttp.checkelse('', {
      action: 'get-source',
      id: id
    }).then(resp => {
      $('#source-insert').hide()
      $('#source-update').show()
      $('#source-name').val(resp.data.name)
      $('#source-note').val(resp.data.note)
      $('#source-modal').modal('show')
    })
  }

  function materialModal(name, ia) {
    global['name'] = name
    global.ia = ia
    $('.insert').show()
    $('.update').hide()
    $("#material-name").val('')
    $("#material-unit").val('')
    $("#material-number").val('')
    $("#material-description").val('')
    $("#material-modal").modal('show')
  }

  function importModal() {
    $("#import-button").show()
    $("#edit-import-button").hide()
    global.ia = 0
    $('.import').remove()
    $('.btn-edit').prop('disabled', false)
    insertLine['import']()
    $("#import-modal-insert").modal('show')
  }

  function updateImport(id) {
    vhttp.checkelse('', {
      action: 'get-import',
      id: id
    }).then(resp => {
      $("#import-button").hide()
      $("#edit-import-button").show()

      global.ia = 0
      global.id = id
      $('.import').remove()
      insertLine['import']()
      $('#import-type-' + global.ia).val(resp.data.item)
      $('#import-type-val-' + global.ia).val(resp.data.itemid)
      $('#import-source-' + global.ia).val(resp.data.source)
      $('#import-source-val-' + global.ia).val(resp.data.sourceid)
      $('#import-date-' + global.ia).val(resp.data.date)
      $('#import-note-' + global.ia).val(resp.data.note)
      $('#import-expire-' + global.ia).val(resp.data.expire)
      $('#import-number-' + global.ia).val(resp.data.number)
      $('.btn-edit').prop('disabled', true)
      $("#import-modal-insert").modal('show')
    })
  }

  function updateExport(id) {
    vhttp.checkelse('', {
      action: 'get-export',
      id: id
    }).then(resp => {
      $("#export-button").hide()
      $("#edit-export-button").show()

      global.ia = 0
      global.id = id
      $('.export').remove()
      parseExport(resp.data.id)
      $('#export-name-1').text(resp.data.item)
      $('#export-source-1').text(resp.data.source)
      $('#export-remain-1').text(resp.data.remain)
      $('#export-date-1').text(resp.data.date)
      $('#export-expire-1').text(resp.data.expire)
      $('#export-note-1').val(resp.data.note)
      $('#export-number-1').val(resp.data.number)
      $('.btn-edit').prop('disabled', true)
      $("#export-modal-insert").modal('show')
    })
  }

  function parseExport(id) {
    global.ia++
    $(`
      <tbody class="export" index="`+ id + `" ia="` + global.ia + `">
        <tr>
          <td id="export-name-`+ global.ia + `"> </td>
          <td id="export-date-` + global.ia + `"> </td>
          <td id="export-source-`+ global.ia + `"> </td>
          <td> <span id="export-remain-`+ global.ia + `">  </span> </td>
          <td> <input class="form-control" id="export-number-`+ global.ia + `"> </td>
          <td id="export-expire-`+ global.ia + `">  </td>
          <td> <input class="form-control" id="export-note-`+ global.ia + `"> </td>
          <td>
            <button class="btn btn-danger btn-xs btn-edit" onclick="removeRow(`+ global.ia + `)">
              xóa
            </button>
          </td>
        </tr>
      </tbody>
    `).insertAfter('#export-insert-modal-content')
    $(".date-" + global.ia).datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  }

  function exportModal() {
    global.ia = 0
    $("#export-button").show()
    $("#edit-export-button").hide()
    $('.export').remove()
    $('.btn-edit').prop('disabled', false)
    $("#export-modal-insert").modal('show')
  }

  function checkMaterialData() {
    name = $("#material-name").val()
    unit = $("#material-unit").val()
    description = $("#material-description").val()

    if (!name.length) alert_msg('Nhập tên trước khi thêm')

    return {
      name: name,
      unit: unit,
      description: description
    }
  }

  function insertSource(name, index) {
    $('#source-insert').show()
    $('#source-update').hide()

    global['name'] = name
    global['index'] = index
    $('#source-name').val('')
    $('#source-note').val('')
    $('#source-modal').modal('show')
  }

  function updateItem(id) {
    global['id'] = id
    vhttp.checkelse('', { action: 'get-item', id: id }).then(data => {
      $('#material-name').val(data['data']['name'])
      $('#material-unit').val(data['data']['unit'])
      $('#material-description').val(data['data']['description'])
      $('.insert').hide()
      $('.update').show()
      $('#material-modal').modal('show')
    })
  }

  function removeItem(id) {
    global['id'] = id
    $('#remove-modal').modal('show')
  }

  function removeItemSubmit() {
    vhttp.checkelse('', { action: 'remove-item', id: global['id'] }).then(data => {
      $('#material').html(data['html'])
      $('#remove-modal').modal('hide')
    })
  }

  function selectItem(name, id, ia) {
    $("#import-type-val-" + ia).val(id)
    $("#import-type-" + ia).val(name)
  }

  function selectSource(name, id, ia) {
    $("#import-source-val-" + ia).val(id)
    $("#import-source-" + ia).val(name)
  }

  function removeRow(ia) {
    $('tbody[ia=' + ia + ']').remove()
  }

  function parseTime(time) {
    datetime = new Date(time * 1000)
    var date = datetime.getDate()
    var month = datetime.getMonth() + 1
    var year = datetime.getFullYear()
    return (date < 10 ? '0' : '') + date + '/' + (month < 10 ? '0' : '') + month + '/' + year
  }

  function checkReportData() {
    data = {
      date: $('#report-date').val(),
      type: $('#report-type-val').val(),
      source: $('#report-source-val').val(),
      tick: $('#report-tick > .active').attr('id')
    }
    if (data['tick'] == 0 && data['type'] <= 0) return 'Chưa chọn hóa chất'
    return data
  }

  var checkReportDataFunction = {
    'm1': () => {
      list = []
      for (const key in global['report']) {
        if (global['report'].hasOwnProperty(key)) {
          if (global['report'][key]) list.push(key)
        }
      }

      data = {
        tick: 'm1',
        date: $('#report-date').val(),
        list: list,
        source: $('#report-source-val').val()
      }
      return data
    },
    'm2': () => {
      data = {
        keyword: $('#report-m2-name').val(),
        limit: $('#report-m2-limit').val(),
        tick: 'm2'
      }
      return data
    },
    'm3': () => {
      data = {
        keyword: $('#report-m3-name').val(),
        expire: $('#report-m3-expire').val(),
        tick: 'm3'
      }
      return data
    }
  }

  var checkReportData = () => {
    tick = $('#report-tick > .active').attr('id')
    return checkReportDataFunction[tick]()
  }

  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////

  function reportSubmit() {
    sdata = checkReportData()
    if (typeof (sdata) == 'string') alert_msg(sdata)
    else {
      vhttp.checkelse('', {
        action: global['report_action'][sdata['tick']],
        data: sdata
      }).then(data => {
        $('#' + global['report_action'][sdata['tick']].replace('_', '-') + '-content').html(data['html'])
      })
    }
  }

  function insertSourceSubmit() {
    if (!$('#source-name').val().length) alert_msg('Nhập tên nguồn trước')
    else vhttp.checkelse('', { action: 'insert-source', name: $('#source-name').val(), note: trim($('#source-note').val()) }).then(data => {
      $('#' + global['name'] + '-source-' + global['index']).val($('#source-name').val())
      $('#' + global['name'] + '-source-val-' + global['index']).val(data['id'])
      $('#source-modal').modal('hide')
    })
  }

  function insertMaterial() {
    sdata = checkMaterialData()
    vhttp.checkelse('', { action: 'insert-material', data: sdata }).then(data => {
      if (data['notify']) alert_msg(data['notify'])
      else {
        alert_msg('Đã thêm')
        $("#" + global['name'] + "-type-val-" + global.ia).val(data.id)
        $("#" + global['name'] + "-type-" + global.ia).val(data.name)
        $("#material").html(data['html'])
        $("#material-modal").modal('hide')
      }
    })
  }

  function updateMaterial() {
    sdata = checkMaterialData()
    vhttp.checkelse('', { action: 'update-material', data: sdata, id: global['id'] }).then(data => {
      if (data['notify']) alert_msg(data['notify'])
      else {
        alert_msg('Đã cập nhật')
        $("#material").html(data['html'])
        $("#material-modal").modal('hide')
      }
    })
  }

  function removeExport(id) {
    global.id = id
    $('#export-remove-modal').modal('show')
  }

  function exportRemoveSubmit() {
    vhttp.checkelse(
      '',
      { action: 'remove-export', id: global.id }
    ).then(data => {
      alert_msg('Đã xóa toa xuất')
      $("#material").html(data['html'])
      $("#export").html(data['html2'])
      $('#export-remove-modal').modal('hide')
    })
  }

  function removeImport(id) {
    global.id = id
    $('#import-remove-modal').modal('show')
  }

  function importRemoveSubmit() {
    vhttp.checkelse(
      '',
      { action: 'remove-import', id: global.id }
    ).then(data => {
      alert_msg('Đã xóa toa nhập')
      $("#material").html(data['html'])
      $("#import").html(data['html2'])
      $('#import-remove-modal').modal('hide')
    })
  }

  function exportSubmit() {
    sdata = getLine['export']()
    if (typeof (sdata) !== 'object') alert_msg(sdata)
    else {
      vhttp.checkelse(
        '',
        { action: 'insert-export', data: sdata, time: $('#export-item-time').val() }
      ).then(data => {
        alert_msg('Đã thêm toa xuất')
        $("#material").html(data['html'])
        $("#export").html(data['html2'])
        $('#export-modal-insert').modal('hide')
        $('.export').remove()
      })
    }
  }

  function importSubmit() {
    sdata = getLine['import']()
    if (typeof (sdata) !== 'object') alert_msg(sdata)
    else {
      vhttp.checkelse(
        '',
        { action: 'insert-import', data: sdata }
      ).then(data => {
        alert_msg('Đã thêm toa nhập')
        $("#material").html(data['html'])
        $("#import").html(data['html2'])
        $("#source").html(data['html3'])
        $('#import-modal-insert').modal('hide')
        $('.import').remove()
      })
    }
  }

  function updateImportSubmit() {
    sdata = getLine['import']()
    if (typeof (sdata) !== 'object') alert_msg(sdata)
    else {
      vhttp.checkelse(
        '',
        { action: 'update-import', data: sdata, time: $('#import-item-time').val(), id: global.id }
      ).then(data => {
        alert_msg('Đã cập nhật toa nhập')
        $("#material").html(data['html'])
        $("#import").html(data['html2'])
        $('#import-modal-insert').modal('hide')
      })
    }
  }

  function updateExportSubmit() {
    sdata = getLine['export']()
    if (typeof (sdata) !== 'object') alert_msg(sdata)
    else {
      vhttp.checkelse(
        '',
        { action: 'update-export', data: sdata, time: $('#export-item-time').val(), id: global.id }
      ).then(data => {
        alert_msg('Đã cập nhật toa nhập')
        $("#material").html(data['html'])
        $("#export").html(data['html2'])
        $('#export-modal-insert').modal('hide')
      })
    }
  }

  // function checkExcel() {
  //   var list = []
  //   $('.po').each((index, checkbox) => {
  //     if (checkbox.checked) {
  //       list.push(checkbox.getAttribute('id'))
  //     }
  //   })
  //   return list
  // }

  function detailItem(id) {
    vhttp.checkelse('', {
      action: 'detail',
      id: id
    }).then(resp => {
      $('#detail-content').html(resp.html)
      $('#detail-modal').modal('show')
    })
  }

  // function excelFilter(e) {
  //   e.preventDefault()
  //   vhttp.checkelse('', {
  //     action: 'excel-filter',
  //     key: $('#excel-filter').val()
  //   }).then(resp => {
  //     $('#excel-item').html(resp.html)
  //     $('#excel-item').show()
  //   })
  //   return false
  // }

  function excelInsert(id, name) {
    global.excel.push({
      id: id,
      name: name
    })
    $('#excel-' + id).remove()
    $('#excel-tap').show()
    excelReload()
  }

  function excelClear() {
    global.excel = []
    excelReload()
  }

  function excelRemove(id) {
    global.excel = global.excel.filter(item => {
      return item.id !== id
    })
    excelReload()
  }

  function excelReload() {
    var html = []
    global.excel.forEach(excel => {
      html.push("<span class='excel' onclick='excelRemove(" + excel.id + ")' id='item-" + excel.id + "'> " + excel.name + "</span>")
    })
    $('#excel-list').html((html.length ? 'Danh sách vật tư: ' + html.join(', ') : ''))
  }

  function checkMaterial() {
    var list = []
    global.excel.forEach(item => {
      // console.log(list, item.id, list.indexOf(item.id));
      if (list.indexOf(item.id) < 0) list.push(item.id)
    });
    return list.join(',')
  }

  function download() {
    var link = '/manage/material/?excel=1&excelf=' + $('#excelf').val().replace(/\//g, '-') + '&excelt=' + $('#excelt').val().replace(/\//g, '-') + '&material=' + checkMaterial()
    // var link = '/manage/material/?excel=1&excelf=' + $('#excelf').val().replace(/\//g, '-') + '&excelt=' + $('#excelt').val().replace(/\//g, '-') + '&data=' + (checkExcel().join(','))
    window.open(link)
  }
</script>
<!-- END: main -->