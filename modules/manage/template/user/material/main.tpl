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
  <li><a data-toggle="tab" href="#import"> Phiếu nhập </a></li>
  <li><a data-toggle="tab" href="#export"> Phiếu xuất </a></li>
  <li><a data-toggle="tab" href="#source"> Nguồn cung </a></li>
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
    material: JSON.parse('{material}'),
    selected: {
      'import': [],
      'export': []
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
    'source': JSON.parse('{source}'),
    'report': {}
  }
  var insertLine = {
    'import': () => {
      global['ia']++
      $(`
        <tbody class="import" ia="` + global['ia'] + `">
          <tr>
            <td>
              <div class="relative">
                <div class="input-group">
                  <input type="text" class="form-control" id="import-type-`+ global['ia'] + `">
                  <input type="hidden" class="form-control" id="import-type-val-`+ global['ia'] + `">
                  <div class="input-group-btn">
                    <button class="btn btn-success" onclick="materialModal('import', `+ global['ia'] + `)">
                      <span class="glyphicon glyphicon-plus"></span>
                    </button>
                  </div>
                </div>
                <div class="suggest" id="import-type-suggest-`+ global['ia'] + `"></div>
              </div>
            </td>
            <td> <input class="form-control date-`+ global['ia'] + `" id="import-date-` + global['ia'] + `" value="` + global['today'] + `"> </td>
            <td> 
              <div class="relative">
                <div class="input-group">
                  <input type="text" class="form-control" id="import-source-`+ global['ia'] + `">
                  <input type="hidden" class="form-control" id="import-source-val-`+ global['ia'] + `">
                  <div class="input-group-btn">
                    <button class="btn btn-success" onclick="insertSource('import', `+ global['ia'] + `)">
                      <span class="glyphicon glyphicon-plus"></span>
                    </button>
                  </div>
                </div>
                <div class="suggest" id="import-source-suggest-`+ global['ia'] + `"></div>
              </div>
            </td>
            <td> <input class="form-control" id="import-number-`+ global['ia'] + `" value="0"> </td>
            <td> <input class="form-control date-`+ global['ia'] + `" id="import-expire-` + global['ia'] + `" value="` + global['today'] + `"> </td>
            <td> <input class="form-control" id="import-note-`+ global['ia'] + `"> </td>
            <td>
              <button class="btn btn-danger btn-xs" onclick="removeRow(`+ global['ia'] + `)">
                xóa
              </button>
            </td>
          </tr>
        </tbody>
      `).insertAfter('#import-insert-modal-content')
      vremind.install('#import-type-' + global['ia'], '#import-type-suggest-' + global['ia'], ((input, ia) => {
        return new Promise(resolve => {
          resolve(searchMaterial(input, 'import', ia))
        })
      }), 300, 300, 0, global['ia'])
      vremind.install('#import-source-' + global['ia'], '#import-source-suggest-' + global['ia'], ((input, ia) => {
        return new Promise(resolve => {
          resolve(searchSource(input, 'import', ia))
        })
      }), 300, 300, 0, global['ia'])
      $(".date-" + global['ia']).datepicker({
        format: 'dd/mm/yyyy',
        changeMonth: true,
        changeYear: true
      });
    },
    'export': (index) => {
      global['material'][index]['detail'].forEach((detail) => {
        global['ia']++
        $(`
          <tbody class="export" index="`+ detail['id'] + `" ia="` + global['ia'] + `">
            <tr>
              <td>
                `+ global['material'][index]['name'] + `
              </td>
              <td> <input class="form-control date-`+ global['ia'] + `" id="export-date-` + global['ia'] + `" value="` + global['today'] + `"> </td>
              <td> `+ parseSource(detail['source']) + ` </td>
              <td> <input class="form-control" id="export-number-`+ global['ia'] + `" value="` + detail['number'] + `"> </td>
              <td> `+ parseTime(detail['expire']) + ` </td>
              <td> <input class="form-control" id="export-note-`+ global['ia'] + `"> </td>
              <td>
                <button class="btn btn-danger btn-xs" onclick="removeRow(`+ global['ia'] + `)">
                  xóa
                </button>
              </td>
            </tr>
          </tbody>
        `).insertAfter('#export-insert-modal-content')
        $(".date-" + global['ia']).datepicker({
          format: 'dd/mm/yyyy',
          changeMonth: true,
          changeYear: true
        });
      });
    }
  }

  var getLine = {
    'import': () => {
      data = []
      msg = ''
      $(".import").each((index, item) => {
        ia = trim(item.getAttribute('ia'))
        temp = {
          id: global['material'][$('#import-type-val-' + ia).val()]['id'],
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
        if (temp['number'] < 0) return msg = 'Số lượng đang âm'
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
        resolve(searchAvaiableMaterial(input, 'export'))
      })
    }), 300, 300)
    vremind.install('#report-type', '#report-type-suggest', (input => {
      return new Promise(resolve => {
        keyword = convert(input)
        html = ''
        count = 0

        global['material'].forEach((item, index) => {
          if (count < 30 && item['alias'].search(keyword) >= 0) {
            count++
            check = 0
            if (global['report'][index]) check = 1
            html += `
              <label class="suggest-box" onclick="reloadReportSuggest()">
                `+ item['name'] + `
                <input class="suggest_box" index="`+ index + `" type="checkbox" style="float: right;" ` + (check ? 'checked' : '') + `>
              </label>`
          }
        })
        if (!html.length) html = 'Không có kết quả'
        resolve(html)
      })
    }), 300, 300, 1)
    vremind.install('#report-source', '#report-source-suggest', (input => {
      return new Promise(resolve => {
        keyword = convert(input)
        html = ''
        count = 0

        global['source'].forEach((item, index) => {
          if (count < 30 && item['alias'].search(keyword) >= 0) {
            count++
            html += `
              <div class="suggest-item" onclick="pickSuggest('source', '` + item['id'] + `', '` + item['name'] + `')">
                `+ item['name'] + `
              </div>
              `
          }
        })
        if (!html.length) html = 'Không có kết quả'
          resolve(html)
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

  function reloadReportSuggest() {
    $('.suggest_box').each((index, item) => {
      itemIndex = item.getAttribute('index')
      itemCheck = item.checked
      if (itemCheck) global['report'][itemIndex] = itemIndex
      else delete global['report'][itemIndex]
    })
    list = []
    for (const key in global['report']) {
      if (global['report'].hasOwnProperty(key)) {
        list.push(global['material'][key]['name'])        
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

  function pickSuggest(type, index, name) {
    $('#report-' + type).val(name)
    $('#report-' + type + '-val').val(index)
  }

  function searchMaterial(keyword, name, ia) {
    keyword = convert(keyword)
    html = ''
    count = 0

    global['material'].forEach((item, index) => {
      if (count < 30 && item['alias'].search(keyword) >= 0) {
        count++
        html += `
            <div class="suggest-item" onclick="selectItem('`+ name + `', ` + index + `, ` + ia + `)">
              `+ item['name'] + `
            </div>`
      }
    })
    if (!html.length) return 'Không có kết quả'
    return html
  }

  function searchAvaiableMaterial(keyword, name) {
    keyword = convert(keyword)
    html = ''
    count = 0

    global['material'].forEach((item, index) => {
      if (count < 30 && item['alias'].search(keyword) >= 0 && item['detail'].length > 0) {
        count++
        html += `
          <div class="suggest-item" onclick="insertLine.export(` + index + `)">
            `+ item['name'] + `
          </div>`
      }
    })
    if (!html.length) return 'Không có kết quả'
    return html
  }

  function searchSource(keyword, name, ia) {
    keyword = convert(keyword)
    html = ''
    count = 0

    global['source'].forEach((item, index) => {
      if (count < 30 && item['alias'].search(keyword) >= 0) {
        count++
        html += `
          <div style="clear: both;">
            <div class="suggest-item sl" onclick="selectSource('`+ name + `', ` + index + `, ` + ia + `)">
            `+ item['name'] + `
            </div>
            <div class="sr" onclick="removeSource('`+ item['id'] +`', \'`+keyword+`\', \'`+name+`\', `+ia+`)">
              &times;
            </div>
          </div>`
      }
    })
    if (!html.length) return 'Không có kết quả'
    return html
  }

  function removeSource(id, keyword, name, ia) {
    vhttp.checkelse('', {action: 'remove-source', id: id}).then(data => {
      global['source'] = data['source']
      $('#import-source-suggest-'+ ia).html(searchSource(keyword, name, ia))      
    })
  }

  function materialModal(name, ia) {
    global['name'] = name
    global['ia'] = ia
    $('.insert').show()
    $('.update').hide()
    $("#material-name").val('')
    $("#material-unit").val('')
    $("#material-number").val('')
    $("#material-description").val('')
    $("#material-modal").modal('show')
  }
  // function importModal() {
  //   $("#import-modal").modal('show')
  // }
  function importModal() {
    // $("#import-button").show()
    // $("#edit-import-button").hide()
    // global['selected']['import'] = []
    // parseFormLine('import')
    global['ia'] = 0
    $('.import').remove()
    insertLine['import']()
    $("#import-modal-insert").modal('show')
  }

  function exportModal() {
    global['ia'] = 0
    $('.export').remove()
    $("#export-modal-insert").modal('show')
  }
  // function exportModal() {
  //   $("#export-modal").modal('show')
  // }

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
      global['material'] = data['material']
      $('#content').html(data['html'])
      $('#remove-modal').modal('hide')
    })
  }

  function findMaterialIndex(id) {
    index = -1
    global['material'].forEach((item, itemIndex) => {
      if (item['id'] === id) return index = itemIndex
    })
    return index
  }

  function selectItem(name, index, ia) {
    selected = global['material'][index]
    $("#" + name + "-type-val-" + ia).val(index)
    $("#" + name + "-type-" + ia).val(selected['name'])
  }

  function selectSource(name, index, ia) {
    selected = global['source'][index]
    $("#" + name + "-source-val-" + ia).val(selected['id'])
    $("#" + name + "-source-" + ia).val(selected['name'])
  }

  function parseSource(sourceid) {
    name = ''
    global['source'].forEach(source => {
      if (source['id'] == sourceid) return name = source['name']
    });
    return name
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
          if (global['report'][key]) list.push(global['material'][key]['id'])
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
    else vhttp.checkelse('', { action: global['report_action'][sdata['tick']], data: sdata }).then(data => {
      $('#' + global['report_action'][sdata['tick']].replace('_', '-') + '-content').html(data['html'])
    })
  }

  function insertSourceSubmit() {
    if (!$('#source-name').val().length) alert_msg('Nhập tên nguồn trước')
    else vhttp.checkelse('', { action: 'insert-source', name: $('#source-name').val(), note: trim($('#source-note').val()) }).then(data => {
      if (data['data']) global['source'].push(data['data'])
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
        global['material'].push(data['json'])
        last = global['material'].length - 1
        selected = global['material'][last]
        $("#" + global['name'] + "-type-val-" + global['ia']).val(last)
        $("#" + global['name'] + "-type-" + global['ia']).val(selected['name'])
        $("#content").html(data['html'])
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
        itemIndex = findMaterialIndex(global['id'])
        global['material'][itemIndex] = data['json']
        selected = global['material'][index]
        $("#content").html(data['html'])
        $("#material-modal").modal('hide')
      }
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
        global['material'] = JSON.parse(data['material'])
        $("#content").html(data['html'])
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
        global['material'] = JSON.parse(data['material'])
        $("#content").html(data['html'])
        $('#import-modal-insert').modal('hide')
        $('.import').remove()
      })
    }
  }
</script>
<!-- END: main -->
