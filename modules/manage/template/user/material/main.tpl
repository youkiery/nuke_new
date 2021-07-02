<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

{modal}

<style>
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
  <li class="active"><a data-toggle="tab" href="#material"> Vật tư, hóa chất </a></li>
  <li><a data-toggle="tab" href="#source"> Nguồn cung </a></li>
  <li><a data-toggle="tab" href="#import"> Phiếu nhập </a></li>
  <li><a data-toggle="tab" href="#export"> Phiếu xuất </a></li>
</ul>

<div class="tab-content">
  <div id="material" class="tab-pane fade in active">
    {content}
  </div>
  <div id="import" class="tab-pane fade">
    {import_content}
  </div>
  <div id="export" class="tab-pane fade">
    {export_content}
  </div>
  <div id="source" class="tab-pane fade">
    {source_content}
  </div>
</div>

<script src="/modules/core/js/vremind-7.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {
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
                  <input type="text" class="form-control" id="import-type-`+ global.ia + `">
                  <input type="hidden" class="form-control" id="import-type-val-`+ global.ia + `">
                  <div class="input-group-btn">
                    <button class="btn btn-success" onclick="materialModal('import', `+ global.ia + `)">
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
          global.ia ++
          if (!$('[index='+ detail['id'] +']').length) {
            $(`
              <tbody class="export" index="`+ detail['id'] + `" ia="` + global.ia + `">
                <tr>
                  <td>
                    `+ detail['name'] + `
                  </td>
                  <td> <input class="form-control date-`+ global.ia + `" id="export-date-` + global.ia + `" value="` + global['today'] + `"> </td>
                  <td> `+ detail['source'] +` </td>
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
          id: $('#import-type-val-' + ia).val(),
          date: $('#import-date-' + ia).val(),
          source: $('#import-source-val-' + ia).val(),
          number: $('#import-number-' + ia).val(),
          expire: $('#import-expire-' + ia).val(),
          note: $('#import-note-' + ia).val()
        }
        if (!temp['id']) return msg = 'Chưa chọn hóa chất'
        if (!temp['source']) return msg = 'Chưa chọn nguồn cung'
        if (temp['number'] <= 0) return msg = 'Số lượng nhỏ hơn 0'
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
          date: $("#export-date-" + ia).val(),
          number: $("#export-number-" + ia).val(),
          note: $("#export-note-" + ia).val()
        }
        if (temp['number'] <= 0) return msg = 'Số lượng đang âm'
        data.push(temp)
      })
      if (msg.length) return msg
      if (!data.length) return 'Chưa nhập mục nào'
      return data
    }
  }

  $(document).ready(() => {
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
                <input class="suggest_box" id="report-`+ item.id + `" type="checkbox" style="float: right;" ` + ((global.report[item.id] && global.report[item.id].status) ? 'checked' : '') + ` onchange="changeSelect(`+ item.id +`, '`+ item.name +`')">
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

  function goPage(page = 1, func = 'material') {
    vhttp.checkelse(
      '', {
        action: 'filter',
        page: page,
        func: func
      }
    ).then(resp => {
      global[func] = page
      $('#'+ func).html(resp['html'])
    })
  }

  function changeSelect(id, name) {
    global.report[id] = {
      name: name,
      status: $('#report-'+ id).prop('checked')
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
      resp.data.forEach(item => {        
        insertLine['import']()
        $('#import-type-'+ global.ia).val(item.item)
        $('#import-type-val-'+ global.ia).val(item.itemid)
        $('#import-source-'+ global.ia).val(item.source)
        $('#import-source-val-'+ global.ia).val(item.sourceid)
        $('#import-date-'+ global.ia).val(item.date)
        $('#import-note-'+ global.ia).val(item.note)
        $('#import-expire-'+ global.ia).val(item.expire)
        $('#import-number-'+ global.ia).val(item.number)
      })
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
      var temp = 1
      global.id = id
      $('.export').remove()
      resp.data.forEach(item => {
        parseExport(item.id)
        $('#export-name-'+ temp).text(item.name)
        $('#export-source-'+ temp).text(item.source)
        $('#export-remain-'+ temp).text(item.remain)
        $('#export-date-'+ temp).text(item.date)
        $('#export-expire-'+ temp).text(item.expire)
        $('#export-note-'+ temp).val(item.note)
        $('#export-number-'+ temp).val(item.number)
        temp ++
      })
      $('.btn-edit').prop('disabled', true)
      $("#export-modal-insert").modal('show')
    })
  }

  function parseExport(id) {
    global.ia ++
    $(`
      <tbody class="export" index="`+ id + `" ia="` + global.ia + `">
        <tr>
          <td id="export-name-`+ global.ia +`"> </td>
          <td id="export-date-` + global.ia + `"> </td>
          <td id="export-source-`+ global.ia +`"> </td>
          <td> <span id="export-remain-`+ global.ia + `">  </span> </td>
          <td> <input class="form-control" id="export-number-`+ global.ia + `"> </td>
          <td id="export-expire-`+ global.ia +`">  </td>
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
    vhttp.checkelse('', {action: 'get-item', id: id}).then(data => {
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
    vhttp.checkelse('', {action: 'remove-item', id: global['id']}).then(data => {
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
      if (!list.length) return 'Chọn ít nhất 1 hóa chất'
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
        { action: 'insert-export', data: sdata }
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
        { action: 'update-import', data: sdata, id: global.id }
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
        { action: 'update-export', data: sdata, id: global.id }
      ).then(data => {
        alert_msg('Đã cập nhật toa nhập')
        $("#material").html(data['html'])
        $("#export").html(data['html2'])
        $('#export-modal-insert').modal('hide')
      })
    }
  }
</script>
<!-- END: main -->
