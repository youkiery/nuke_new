<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>

<style>
  .red {
    background: pink;
  }
  label { text-align: left !important; padding-left: 10px; }
  
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
</style>

{device_modal}

<div id="msgshow"></div>

<div style="clear: both;"></div>

<!-- BEGIN: m1 -->
<div class="form-group">
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#content"> Danh sách </a></li>
    <li><a data-toggle="tab" href="#manager"> Quản lý </a></li>
  </ul>
</div>
<!-- END: m1 -->

<div class="tab-content">
  <div id="content" class="tab-pane fade in active">
    {content}
  </div>
  <div id="manager" class="tab-pane fade">
    <div class="rows form-group">
      <div class="col-6">
        <input type="text" class="form-control" id="date" value="{today}">
      </div>
      <div class="col-6">
        &nbsp;
        <button class="btn btn-info" onclick="changeDate(-1)">
          &lt;
        </button>    
        <button class="btn btn-info" onclick="changeDate(1)">
          &gt;
        </button>    
        <button class="btn btn-info" onclick="reportContent()">
          Báo cáo
        </button>            
      </div>
    </div>
    <div id="manager-content">
      {manager_content}
    </div>
  </div>
</div>

<script src="/modules/manage/src/script.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script>
  var global = {
    id: 0,
    page: {
      'main': 1
    },
    selected: {
      filter: {},
      device: {}
    },
    filter: {
      selected: {}
    },
    list: JSON.parse('{depart}'),
    today: '{today}',
    remind: JSON.parse('{remind}'),
    remindv2: JSON.parse('{remindv2}'),
    time: Number('{time}') * 1000,
    config: Number('{config}') * 60 * 60 * 24 * 1000
  }

  $(document).ready(() => {
    // installCheckAll('device')
    // installRemindv2('device', 'name')
    // installRemindv2('device', 'intro')
    // installRemindv2('device', 'source')
    // installDepart('filter')
    // installDepart('device')
  })

  function checkDeviceData() {
    list = []
    for (const key in global['selected']['device']) {
      if (global['selected']['device'].hasOwnProperty(key)) {
        list.push(global['list'][key]['id'])
      }
    }
    name = $("#device-name").val()

    if (!name.length) {
      return 'Điền tên thiết bị'
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
      import: $("#device-import-time").val()
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
    $("#device-import-time").val(global['today'])
    $("#device-insert").show()
    $("#device-edit").hide()
    global['selected']['device'] = {}
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
          $("#device-name").text(data['device']['name']),
          $("#device-unit").text(data['device']['unit']),
          $("#device-number").text(data['device']['number']),
          $("#device-year").text(data['device']['year']),
          $("#device-intro").text(data['device']['intro']),
          $("#device-source").text(data['device']['source']),
          $("#device-status").text(data['device']['status']),
          $("#device-import-time").text(data['device']['import'])
          $("#device-description").text(data['device']['description'])
          $("#detail-msg").text(data['data']['msg'])
          $("#detail-note").val(data['data']['note'])
          $("#detail-status").val(data['data']['status'])
          $("#device-insert").hide()
          $("#device-edit").show()
          global['id'] = id
          $('#device-modal').modal('show')
        }, () => {})
      }
    )
  }

  function manual(id) {
    vhttp.checkelse('', {action: 'get-manual', id: id}).then(data => {
      $("#manual-content").html(data['manual'])
      $("#manual-modal").modal('show')
    })
  }

  function loadDefault() {
    $("#device-name").val(),
    $("#device-unit").val(global['remind']['unit']),
    $("#device-number").val(global['remind']['number']),
    $("#device-year").val(global['remind']['year']),
    $("#device-intro").val(global['remind']['intro']),
    $("#device-source").val(global['remind']['source']),
    $("#device-status").val(global['remind']['status']),
    $("#device-import-time").val(global['today']),
    $("#device-import-description").val('')
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

  function goPage(page) {
    global['page']['main'] = page
    $.post(
      '',
      { action: 'filter', 'device_filter': checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
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

  function installDepart(prefix) {
    var input = $("#"+ prefix +"-depart-input")
    var suggest = $("#"+ prefix +"-depart-suggest")
    
    input.keyup((e) => {
      keyword = e.currentTarget.value
      html = ''
      count = 0
      

      global['list'].forEach((depart, index) => {
        if (count < 30 && depart['name'].search(keyword) >= 0) {
          count ++
          html += `
            <div class="suggest-item" onclick="selectDepart('`+ prefix +`', `+ index +`)">
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
  }

  function selectRemindv2(prefix, type, value) {
    $("#" + prefix + "-" + type).val(value)
  }

  function deviceDetail(id, status, note) {
    global['id'] = id
    $("#detail-status").val(status)
    $("#detail-note").val(note)
    $("#detail-modal").modal('show')
  }

  function detailSubmit() {
    vhttp.checkelse('', { action: 'insert-detail', status: $("#detail-status").val(), note: $("#detail-note").val(), id: global['id'] }).then(data => {
      $("#content").html(data['html'])
      $("#device-modal").modal('hide')
    })
  }

  function reportDetail(id) {
    vhttp.checkelse('', { action: 'report-detail', id: id, date: Number(global['time']) / 1000 }).then(data => {
      $("#report-content").html(data['html'])
      $("#report-modal").modal('show')
    })
  }

  function changeDate(multipie) {
    datetime = global['time'] + global['config'] * multipie
    vhttp.checkelse('', { action: 'change-date', date: Number(datetime) / 1000 }).then(data => {
      global['time'] = datetime
      $("#date").val(parseDate(new Date(global['time'])))
      $("#manager-content").html(data['html'])
    })
  }

  function reportContent() {
    vhttp.checkelse('', { action: 'report-content', date: Number(global['time']) / 1000 }).then(data => {
      $("#report-content-content").html(data['html'])
      $("#report-content-modal").modal('show')
    })
  }

  function parseDate(datetime) {
    date = datetime.getDate()
    month = datetime.getMonth() + 1
    year = datetime.getFullYear()
    return (date < 10 ? '0' : '') + date + '/' + (month < 10 ? '0' : '') + month + '/' + year
  }
</script>
<!-- END: main -->
