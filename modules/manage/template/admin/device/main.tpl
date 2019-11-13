<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" href="/modules/manage/src/style.css">
{device_modal}
{remove_modal}
{remove_all_modal}
<div id="msgshow"></div>
<div style="float: right;">
  <button class="btn btn-success" onclick="deviceInsert()">
    <span class="glyphicon glyphicon-plus"></span>
  </button>
</div>
<div class="form-group form-inline">
  Số dòng mỗi trang
  <div class="input-group">
    <input type="text" class="form-control" id="filter-limit" value="10">
    <div class="input-group-btn">
      <button class="btn btn-info" onclick="goPage(1)"> Hiển thị </button>
    </div>
  </div>
</div>

<div style="clear: both;"></div>
<div id="content">
  {content}
</div>

<!-- <button class="btn btn-info">
  edit all
</button>   -->
<button class="btn btn-danger" onclick="removeAll()">
  Xóa mục đã chọn
</button>  
<script src="/modules/manage/src/script.js"></script>
<script>
  var global = {
    id: 0,
    page: {
      'main': 1
    },
    depart: {
      list: JSON.parse('{depart}'),
      selected: {}
    },
    today: '{today}',
    remind: JSON.parse('{remind}'),
    remindv2: JSON.parse('{remindv2}')
  }

  $(document).ready(() => {
    installCheckAll('device')
    installRemindv2('device', 'name')
    installRemindv2('device', 'intro')
    installRemindv2('device', 'source')
    input = $("#device-depart-input")
    suggest = $("#device-depart-suggest")
    input.keyup((e) => {
      keyword = e.currentTarget.value
      html = ''
      count = 0

      global['depart']['list'].forEach((depart, index) => {
        if (count < 30 && depart['name'].search(keyword) >= 0) {
          count ++
          html += `
            <div class="suggest-item" onclick="selectDepart(`+ index +`)">
              `+ depart['name'] +`
            </div>`
        }
      })
      if (!html.length) {
        html = 'Không có kết quả'
      }
      suggest.html(html)
    })

    input.focus(() => {
      suggest.show()
    })

    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
      }, 300);
    })
  })

  function selectDepart(index) {
    global['depart']['selected'][index] = 1
    $("#device-depart-input").val('')
    val = []
    for (const key in global['depart']['selected']) {
      if (global['depart']['selected'].hasOwnProperty(key)) {
        val.push('<span class="btn btn-info btn-xs" onclick="deselectDepart('+ key +')"> '+ global['depart']['list'][key]['name'] +' </span>')
      }
    }
    $("#device-depart").html(val.join(', '))
  }

  function deselectDepart(index) {
    delete global['depart']['selected'][index]
    val = []
    for (const key in global['depart']['selected']) {
      if (global['depart']['selected'].hasOwnProperty(key)) {
        val.push('<span class="btn btn-info btn-xs" onclick="deselectDepart('+ key +')"> '+ global['depart']['list'][key]['name'] +' </span>')
      }
    }
    $("#device-depart").html(val.join(', '))
  }

  function insertDepart() {
    depart = $("#device-depart-input").val()
    if (!depart.length) {
      alert_msg('Điền tên đơn vị trước khi thêm mới')
    }
    else {
      $.post(
        '',
        { action: 'insert-depart', name: depart },
        (response, status) => {
          checkResult(response, status).then(data => {
            global['depart']['list'].push(data['inserted'])
            selectDepart(global['depart']['list'].length - 1)
          }, () => {})
        }
      )
    }
  }

  function checkFilter() {
    limit = $("#filter-limit").val()
    if (limit < 10) {
      $("#filter-limit").val(10)
    }
    else if (limit > 200) {
      $("#filter-limit").val(200)
    }
    return {
      page: global['page']['main'],
      limit: $("#filter-limit").val()
    }
  }

  function checkDeviceData() {
    list = []
    for (const key in global['depart']['selected']) {
      if (global['depart']['selected'].hasOwnProperty(key)) {
        list.push(global['depart']['list'][key]['id'])
      }
    }
    name = $("#device-name").val()
    day = $("#device-import-day").val()
    month = $("#device-import-month").val()
    year = $("#device-import-year").val()

    if (!name.length) {
      return 'Điền tên thiết bị'
    }
    if (day < 0 || day > 31) {
      return 'Ngày quá giới hạn'
    }
    if (month < 0 || month > 12) {
      return 'Tháng quá giới hạn'
    }
    if (year < 1950 || year > 2050) {
      return 'Năm quá giới hạn'
    }

    return {
      name: name,
      unit: $("#device-unit").val(),
      number: $("#device-number").val(),
      year: $("#device-year").val(),
      intro: $("#device-intro").val(),
      source: $("#device-source").val(),
      status: $("#device-status").val(),
      depart: list,
      description: $("#device-description").val(),
      import: day + '/' + month + '/' + year
    }
  }

  function deviceInsert() {
    $("#device-name").val(''),
    $("#device-unit").val(''),
    $("#device-number").val(''),
    $("#device-year").val(''),
    $("#device-intro").val(''),
    $("#device-source").val(''),
    $("#device-status").val(''),
    $("#device-description").val('')
    $("#device-insert").show()
    $("#device-edit").hide()
    global['depart']['selected'] = {}
    $("#device-depart").html('')
    $('#device-modal').modal('show')
  }

  function deviceInsertSubmit() {
    data = checkDeviceData()
    if (!data['name']) {
      alert_msg(data)
    }
    else {
      $.post(
        '',
        { action: 'insert-device', filter: checkFilter(), data: data },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#content").html(data['html'])
            $("#device-name").val(''),
            $("#device-unit").val(''),
            $("#device-number").val(''),
            $("#device-year").val(''),
            $("#device-intro").val(''),
            $("#device-source").val(''),
            $("#device-status").val(''),
            $("#device-description").val('')
            global['depart']['selected'] = {}
            $("#device-depart").html('')
            $('#device-modal').modal('hide')
          }, () => {})
        }
      )
    }
  }

  function deviceEditSubmit() {
    data = checkDeviceData()
    if (!data['name']) {
      alert_msg(data)
    }
    else {
      $.post(
        '',
        { action: 'edit-device', filter: checkFilter(), data: data, id: global['id'] },
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#content").html(data['html'])
            $('#device-modal').modal('hide')
          }, () => {})
        }
      )
    }
  }

  function deviceEdit(id) {
    $.post(
      '',
      { action: 'get-device', id: id },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          $("#device-name").val(data['device']['name']),
          $("#device-unit").val(data['device']['unit']),
          $("#device-number").val(data['device']['number']),
          $("#device-year").val(data['device']['year']),
          $("#device-intro").val(data['device']['intro']),
          $("#device-source").val(data['device']['source']),
          $("#device-status").val(data['device']['status']),
          $("#device-description").val(data['device']['description'])
          $("#device-insert").hide()
          $("#device-edit").show()
          global['depart']['selected'] = {}
          data['device']['depart'].forEach(depart => {
            global['depart']['list'].forEach((item, index) => {
              if (item['id'] == depart) {
                selectDepart(index)
              }
            })
          })
          global['id'] = id
          $('#device-modal').modal('show')
        }, () => {})
      }
    )
  }

  function loadDefault() {
    $("#device-name").val(),
    $("#device-unit").val(global['remind']['unit']),
    $("#device-number").val(global['remind']['number']),
    $("#device-year").val(global['remind']['year']),
    $("#device-intro").val(global['remind']['intro']),
    $("#device-source").val(global['remind']['source']),
    $("#device-status").val(global['remind']['status']),
    time = global['today'].split('/')
    $("#device-day").val(time[0]),
    $("#device-month").val(time[1]),
    $("#device-year").val(time[2]),
    $("#device-description").val('')
  }

  function deviceRemove(id) {
    $('#remove-modal').modal('show')
    global['id'] = id
  }

  function deviceRemoveSubmit() {
    $.post(
      '',
      { action: 'remove-device', filter: checkFilter(), id: global['id'] },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
          $('#remove-modal').modal('hide')
        }, () => {})
      }
    )
  }

  function removeAll() {
    list = []
    $(".device-checkbox:checked").each((index, item) => {
      if (item.checked) {
        list.push(item.getAttribute('id').replace('device-checkbox-', ''))
      }
    })
    if (!list.length) {
      alert_msg('Chọn ít nhất một thiết bị')
    }
    else {
      $("#remove-all-modal").modal('show')
    }
  }

  function removeAllSubmit() {
    $.post(
    '',
    { action: 'remove-all-device', filter: checkFilter(), list: list },
    (response, status) => {
      checkResult(response, status).then(data => {
        $("#content").html(data['html'])
        $('#remove-all-modal').modal('hide')
      }, () => {})
    })
  }

  function installCheckAll(name) {
    $("#"+ name +"-check-all").change((e) => {
      checked = e.currentTarget.checked 
      $("."+ name +"-checkbox").each((index, item) => {
        item.checked = checked
      })
    })
  }

  function installRemindv2(prefix, type) {
    var timeout
    var input = $("#"+ prefix +"-" + type)
    var suggest = $("#"+ prefix + '-' + type + "-suggest")

    input.keyup(() => {
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        var key = convert(input.val())
        var html = ''
        
        for (const index in global['remindv2'][type]) {
          if (global['remindv2'][type].hasOwnProperty(index)) {
            const element = convert(global['remindv2'][type][index]);
            
            if (element.search(key) >= 0) {
              html += '<div class="suggest-item" onclick="selectRemindv2(\'' + prefix + '\', \'' + type + '\', \'' + global['remindv2'][type][index] + '\')"><p class="right-click">' + global['remindv2'][type][index] + '</p></div>'
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

  function selectRemindv2(prefix, type, value) {
    $("#" + prefix + "-" + type).val(value)
  }
</script>
<!-- END: main -->
