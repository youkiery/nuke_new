<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="row form-group">
  <label class="col-sm-4">Số phiếu</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-code" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">
    khách hàng
  </label>
  <div class="relative col-sm-10">
    <input type="text" class="form-control" id="form-insert-sender-employ" autocomplete="off">
    <div class="suggest" id="form-insert-sender-employ-suggest"></div>
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">Ngày nhận mẫu</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-receive" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">Ngày hẹn trả kết quả</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-resend" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label>Hình thức nhận</label>
  <div>
    <label><input type="radio" name="state" class="check-box state" id="state-0" checked>Trực tiếp</label>
  </div>
  <div>
    <label><input type="radio" name="state" class="check-box state" id="state-1">Bưu điện</label>
  </div>
  <div class="row form-group">
    <label class="col-sm-4"><input type="radio" name="state" class="check-box state" id="state-2">Khác</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="form-insert-receive-state-other" autocomplete="off">
    </div>
  </div>
</div>

<div class="row form-group">
  <b> <p> Phòng chuyên môn </p> </b>
  <label class="col-sm-4">
    Người nhận hồ sơ
  </label>
  <div class="relative col-sm-10">
    <input type="text" class="form-control" id="form-insert-receiver-employ" autocomplete="off">
    <div class="suggest" id="form-insert-receiver-employ-suggest"></div>
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">Ngày nhận</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-ireceive" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">Ngày trả</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-iresend" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <div id="form-insert-form">

  </div>
  <button class="btn btn-success" onclick="addInfo(1)">
    <span class="glyphicon glyphicon-plus"></span>
  </button>
</div>
<div class="form-group row">
  <label class="col-sm-4"> Số lượng mẫu </label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-number" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label> Loại mẫu </label>
  <div id="type-0">
    <input type="radio" name="type" class="check-box type" id="typed-0" checked>
    Nguyên con
  </div>
  <div id="type-1">
    <input type="radio" name="type" class="check-box type" id="typed-1">
    Huyết thanh
  </div>
  <div id="type-2">
    <input type="radio" name="type" class="check-box type" id="typed-2">
    Máu
  </div>
  <div id="type-3">
    <input type="radio" name="type" class="check-box type" id="typed-3">
    Phủ tạng
  </div>
  <div id="type-4">
    <input type="radio" name="type" class="check-box type" id="typed-4">
    Swab
  </div>
  <div class="form-group row">
    <label class="col-sm-4">
      <input type="radio" name="type" class="check-box type" id="typed-5">
      Khác
    </label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="form-insert-type-other" autocomplete="off">
    </div>
  </div>
</div>

<div class="form-group row">
  <label class="col-sm-4"> Loài vật được lấy mẫu </label>
  <div class="col-sm-10">
    <input type="text" class="form-control sample" id="form-insert-sample" autocomplete="off">
  </div>
</div>
<div class="form-group row">
  <label class="col-sm-4"> Ký hiệu mẫu </label>
  <div class="col-sm-10" id="form-insert-sample-parent">
    <input type="text" class="form-control" id="form-insert-sample-code" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label>
    Yêu cầu xét nghiệm
    <button class="btn btn-success" onclick="insertMethod()"> <span class="glyphicon glyphicon-plus"></span> </button>
  </label>
  <div id="form-insert-request"></div>
  <button class="btn btn-success" onclick="addInfo(2)">
    <span class="glyphicon glyphicon-plus"></span>
  </button>
</div>

<script>

var ticked = ['Đạt', 'Không đạt']
  var methodModal = $("#method-modal")
  var formInsert = $('#form-insert')
  var remind = JSON.parse('{remind}')
  var remindv2 = JSON.parse('{remindv2}')
  var relation = JSON.parse('{relation}')
  var credit = $("#credit")
  var menu1 = $("#menu1")
  var content = $("#content")
  var formRemove = $("#form-remove")
  var formInsertCode = $("#form-insert-code")
  var formInsertReceiverState = $("#form-insert-receive-state")
  var formInsertReceiverState2 = $("#form-insert-receive-state2")
  var formInsertReceiverState3 = $("#form-insert-receive-state3")
  var formInsertReceiverStateOther = $("#form-insert-receive-state-other")
  var formInsertRequest = $("#form-insert-request")
  var formInsertReceive = $("#form-insert-receive")
  var formInsertResend = $("#form-insert-resend")
  var formInsertIreceive = $("#form-insert-ireceive")
  var formInsertIresend = $("#form-insert-iresend")
  var formInsertNumber = $("#form-insert-number")
  var formInsertNumberWord = $("#form-insert-number-word")
  var formInsertNumber2 = $("#form-insert-number2")
  var formInsertSample = $("#form-insert-sample")
  var formInsertStatus = $("#form-insert-status")
  var formInsertSampleCode = $("#form-insert-sample-code")
  var formInsertSampleParent = $("#form-insert-sample-parent")
  var formInsertOther = $("#form-insert-other")
  var formInsertResult = $("#form-insert-result") 
  var formInsertTypeOther = $("#form-insert-type-other") 

  var formInsertSenderUnit = $("#form-insert-sender-unit")
  var formInsertSenderUnitSuggest = $("#form-insert-sender-unit-suggest")
  var formInsertSenderEmploy = $("#form-insert-sender-employ")
  var formInsertSenderEmploySuggest = $("#form-insert-sender-employ-suggest")
  var formInsertReceiverUnit = $("#form-insert-receiver-unit")
  var formInsertReceiverUnitSuggest = $("#form-insert-receiver-unit-suggest")
  var formInsertReceiverEmploy = $("#form-insert-receiver-employ")
  var formInsertReceiverEmploySuggest = $("#form-insert-receiver-employ-suggest")
  var formInsertSamplerUnit = $("#form-insert-sampler-unit")
  var formInsertSamplerUnitSuggest = $("#form-insert-sampler-unit-suggest")
  var formInsertSamplerEmploy = $("#form-insert-sampler-employ")
  var formInsertSamplerEmploySuggest = $("#form-insert-sampler-employ-suggest")

  var formInsertIsenderEmploy = $("#form-insert-isender-employ")
  var formInsertIsenderEmploySuggest = $("#form-insert-isender-employ-suggest")
  var formInsertIreceiverEmploy = $("#form-insert-ireceiver-employ")
  var formInsertIreceiverEmploySuggest = $("#form-insert-ireceiver-employ-suggest")

  var formInsertIsenderUnit = $("#form-insert-isender-unit")
  var formInsertIsenderUnitSuggest = $("#form-insert-isender-unit-suggest")
  var formInsertIreceiverUnit = $("#form-insert-ireceiver-unit")
  var formInsertIreceiverUnitSuggest = $("#form-insert-ireceiver-unit-suggest")
  var formInsertSampleReceiver = $("#form-insert-sample-receiver")
  var formInsertSampleReceiverSuggest = $("#form-insert-sample-receiver-suggest")
  var formInsertSampleReceive = $("#form-insert-sample-receive")
  var formInsertSampleTime = $("#form-insert-sample-time")

  var formInsertCustomer = $("#form-insert-customer")
  var formInsertCustomerSuggest = $("#form-insert-customer-suggest")
  var formInsertPhone = $("#form-insert-phone")
  var formInsertAddress = $("#form-insert-address")
  var formInsertAddressSuggest = $("#form-insert-address-suggest")

  var formInsertSampleReceiveTime = $("#form-insert-sample-receive-time")
  var formInsertSampleReceiveHour = $("#form-insert-sample-receive-hour")
  var formInsertSampleReceiveMinute = $("#form-insert-sample-receive-minute")
  var formInsertExamDate = $("#form-insert-exam-date")
  var formInsertTarget = $("#form-insert-target")

  var formInsertXcode1 = $("#form-insert-xcode-1")
  var formInsertXcode2 = $("#form-insert-xcode-2")
  var formInsertXcode3 = $("#form-insert-xcode-3")
  var formInsertNo1 = $("#form-insert-no-1")
  var formInsertNo2 = $("#form-insert-no-2")
  var formInsertPage1 = $("#form-insert-page-1")
  var formInsertPage2 = $("#form-insert-page-2")
  var formInsertQuality = $("#form-insert-quality")

  var formInsertInfo = $("#form-insert-info")
  var formInsertForm = $("#form-insert-form")
  var formInsertRequest = $("#form-insert-request")

  var filterLimit = $("#filter-limit")
  var filterPrinter = $("#filter-printer")
  var filterKeyword = $("#filter-keyword")

  var insertMethodSymbol = $("#insert-method-symbol")
  var insertMethodName = $("#insert-method-name")

  var formInsertEndedMinute =  $("#form-insert-ended-minute")
  var formInsertEndedHour =  $("#form-insert-ended-hour")
  var formInsertEndedCopy =  $("#form-insert-ended-copy")

  var formInsertNote =  $("#form-insert-note")
  var formInsertReceiveDis = $("#form-insert-receive-dis")
  var formInsertReceiveLeader = $("#form-insert-receive-leader")
  var formInsertAttach = $("#form-insert-attach")
  var formInsertXaddress = $("#form-insert-xaddress")
  var formInsertXaddressSuggest = $("#form-insert-xaddress-suggest")
  var formInsertOwner = $("#form-insert-owner")
  var formInsertOwnerSuggest = $("#form-insert-owner-suggest")
  var formInsertSamplePlace = $("#form-insert-sample-place")
  var formInsertSamplePlaceSuggest = $("#form-insert-sample-place-suggest")
  var formInsertXphone = $("#form-insert-xphone")
  var formInsertXnote = $("#form-insert-xnote")
  var formInsertFax = $("#form-insert-fax")

  var formSummary = $("#form-summary")
  var formSummaryFrom = $("#form-summary-from")
  var formSummaryEnd = $("#form-summary-end")
  var formSummaryContent = $("#form-summary-content")
  var formSummaryUnit = $("#form-summary-unit")
  var formSummarySample = $("#form-summary-sample")
  var formSummaryExam = $("#form-summary-exam")
  var formInsertNoticeTime = $("#form-insert-notice-time")

  var global_form = 1
  var global_saved = 0
  var global_id = 0
  var global_page = 1
  var global_printer = 1

  var visible = {
    0: {1: '1', 2: '1'},
    1: {1: '1, 2', 2: '1, 2'},
    2: {1: '1, 2, 3', 2: '1, 2, 3'},
    3: {1: '1, 2, 3, 4', 2: '1, 2, 3, 4'},
    4: {1: '1, 2, 3, 4, 5', 2: '1, 2, 3, 4, 5'},
    5: {1: '1, 2, 3, 4, 5', 2: '1, 2, 3, 4, 5'}
  }
  var dataPicker = {'form': 1, 'exam': 2, 'result': 3}
  var rdataPicker = {'1': 'form', '2': 'exam', 3: 'result'}
  var infoData = {1: [], 2: [], 3: []}
  var remindData = {}
  var today = '{today}'
  var globalTarget = {
    'sender-unit': {
      input: formInsertSenderUnit,
      suggest: formInsertSenderUnitSuggest,
      data: 1,
      name: 'value'
    },
    'sender-employ': {
      input: formInsertSenderEmploy,
      suggest: formInsertSenderEmploySuggest,
      data: 2,
      name: 'value'
    },
    'receiver-unit': {
      input: formInsertReceiverUnit,
      suggest: formInsertReceiverUnitSuggest,
      data: 2,
      name: 'value'
    },
    'receiver-employ': {
      input: formInsertReceiverEmploy,
      suggest: formInsertReceiverEmploySuggest,
      data: 1,
      name: 'value'
    },
    'sampler-unit': {
      input: formInsertSamplerUnit,
      suggest: formInsertSamplerUnitSuggest,
      data: 2,
      name: 'value'
    },
    'sampler-employ': {
      input: formInsertSamplerEmploy,
      suggest: formInsertSamplerEmploySuggest,
      data: 1,
      name: 'value'
    },
    'ireceiver-unit': {
      input: formInsertIreceiverUnit,
      suggest: formInsertIreceiverUnitSuggest,
      data: 2,
      name: 'value'
    },
    'ireceiver-employ': {
      input: formInsertIreceiverEmploy,
      suggest: formInsertIreceiverEmploySuggest,
      data: 1,
      name: 'value'
    },
    'isender-unit': {
      input: formInsertIsenderUnit,
      suggest: formInsertIsenderUnitSuggest,
      data: 2,
      name: 'value'
    },
    'isender-employ': {
      input: formInsertIsenderEmploy,
      suggest: formInsertIsenderEmploySuggest,  
      data: 1,
      name: 'value'
    },
    'customer': {
      input: formInsertCustomer,
      suggest: formInsertCustomerSuggest,
      data: 4,
      name: 'value'
    },
    'address': {
      input: formInsertAddress,
      suggest: formInsertAddressSuggest,
      data: 5,
      name: 'value'
    },
    'sample-receiver': {
      input: formInsertSampleReceiver,
      suggest: formInsertSampleReceiverSuggest,
      data: 1,
      name: 'value'
    },
    'xaddress': {
      input: formInsertXaddress,
      suggest: formInsertXaddressSuggest,
      data: 8,
      name: 'value'
    },
    'owner': {
      input: formInsertOwner,
      suggest: formInsertOwnerSuggest,
      data: 9,
      name: 'value'
    },
    'sample-place': {
      input: formInsertSamplePlace,
      suggest: formInsertSamplePlaceSuggest,
      data: 10,
      name: 'value'
    }
  }

  $(document).ready(() => {
    htmlInfo = formInsertInfo.html()
    addInfo(1)
    addInfo(2)
    addInfo(3)
    installRemind('sender-unit');
    installRemind('sender-employ');
    installRemind('receiver-unit');
    installRemind('receiver-employ');
    installRemind('sampler-unit');
    installRemind('sampler-employ');

    installRemind('ireceiver-employ');
    installRemind('ireceiver-unit');
    installRemind('isender-employ');
    installRemind('isender-unit');
    installRemind('sample-receiver');
    installRemind('customer');
    installRemind('address');
    installRemind('xaddress');
    installRemind('owner');
    installRemind('sample-place');

    installExamRemind()
    // installResultRemind()
        
    parseBox(1)
    parseSaved()
  })

  function insertMethod() {
    methodModal.modal('show')
  }
  function insertMethodSubmit(e) {
    e.preventDefault()
    if (insertMethodName.val().length > 0 && insertMethodSymbol.val().length > 0) {
      $.post(
        strHref,
        {action: 'insertMethod', name: insertMethodName.val(), symbol: insertMethodSymbol.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            $('.method').each((index, item) => {
              method = JSON.parse(data['method'])
              item.innerHTML = data['html']
              
              addInfo = (id) => {
                var length = infoData[id].length
                switch (id) {
                  case 1:
                    var html = `
                      <div class="formed" id="form-` + length + `">
                        <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(1, ` + length + `)">&times;</button>
                        <br>
                        <div class="row">
                          <label class="col-sm-4"> Tên hồ sơ </label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control input-box form" id="formed-` + length + `">
                          </div>
                        </div>
                      </div>`
                          
                      formInsertForm.append(html)
                    break;
                  case 2:
                  var html = `
                      <div class="examed" id="exam-` + length + `">
                        <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(2, ` + length + `)">&times;</button>
                        <br>
                        <div class="row">
                          <label class="col-sm-4"> Yêu cầu </label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control input-box exam" id="examed-` + length + `">
                          </div>
                          <div class="input-group">
                            <select class="form-control input-box method" id="method-` + length + `">
                              `+data['html']+`
                            </select>
                          </div>
                        </div>
                      </div>`
                    formInsertRequest.append(html)
                    break;
                }
                infoData[id].push(html)
              }
            })
          })
        }
      )
    }
    else {
      alert_msg('Chưa điền đủ thông tin')
    }
  }

  function addInfo(id) {
    var length = infoData[id].length
    switch (id) {
      case 1:
        var html = `
          <div class="formed" id="form-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(1, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-4"> Tên hồ sơ </label>
              <div class="col-sm-10">
                <input type="text" class="form-control input-box form" id="formed-` + length + `">
              </div>
            </div>
          </div>`
              
          formInsertForm.append(html)
        break;
      case 2:
        var html = `
          <div class="examed" id="exam-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(2, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-4"> Yêu cầu </label>
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box exam examed" id="examed-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest exam-suggest" id="exam-suggest-` + length + `"> </div>
              </div>
            </div>
            <div class="row">
              <label class="col-sm-4"> Phương pháp </label>
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box method" id="method-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest" id="method-suggest-` + length + `"> </div>
              </div>
            </div>
            <div class="row">
              <label class="col-sm-4"> Ký hiệu </label>
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box symbol" id="symbol-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest" id="symbol-suggest-` + length + `"> </div>
              </div>
            </div>
          </div>`
        formInsertRequest.append(html)
        installRemindv2(length, 'symbol')
        installRemindv2(length, 'method')
        installExamRemind()
      break;
      case 3:
        var html = `
          <div class="resulted" id="result-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(3, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-4"> Kết quả </label>
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box resulted resulted" id="resulted-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest resulted-suggest" id="resulted-suggest-` + length + `"> </div>
              </div>
            </div>
          </div>`
        formInsertResult.append(html)
        installResultRemind()
      break;
    }
    infoData[id].push(html)
  }

  function installRemindv2(name, type) {
    var timeout
    var input = $("#"+ type +"-" + name)
    var suggest = $("#"+ type +"-suggest-" + name)
    
    input.keyup(() => {
      clearTimeout(timeout)
      setTimeout(() => {
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

  function installExamRemind() {
    $(".examed").each((index, item) => {
      var id = item.getAttribute('id').replace('examed-', '')
      var timeout
      
      $("#examed-" + id).keyup(() => {
        clearTimeout(timeout)
        setTimeout(() => {
          var key = paintext(item.value)
          var html = ''
          for (const index in remind[3]) {
            if (remind[3].hasOwnProperty(index)) {
              const element = paintext(remind[3][index]['value']);
              
              if (element.search(key) >= 0) {
                html += '<div class="suggest_item" onclick="selectRemindv2a(\'' + '#examed-' + id + '\', \'' + remind[3][index]['value'] + '\')"><span class="right2-click">' + remind[3][index]['value'] + '</span><button class="close right" data-dismiss="modal" onclick="removeRemind('+remind[3][index]['id']+', \''+'#examed-' + id+'\')">&times;</button></div>'
              }
            }
          }
          $("#exam-suggest-" + id).html(html)
        }, 200);
      })
      $("#examed-" + id).focus(() => {
        $("#exam-suggest-" + id).show()
      })
      $("#examed-" + id).blur(() => {
        setTimeout(() => {
          $("#exam-suggest-" + id).hide()
        }, 200);
      })
    })
  }

  function installResultRemind() {
    $(".resulted").each((index, item) => {
      var id = item.getAttribute('id').replace('resulted-', '')
      var timeout
      
      $("#resulted-" + id).keyup(() => {
        clearTimeout(timeout)
        setTimeout(() => {
          var key = paintext(item.value)
          var html = ''
          for (const index in remind[6]) {
            if (remind[6].hasOwnProperty(index)) {
              const element = paintext(remind[6][index]['value']);
              
              if (element.search(key) >= 0) {
                html += '<div class="suggest_item" onclick="selectRemindv2(\'' + '#resulted-' + id + '\', \'' + remind[6][index]['value'] + '\')"><span class="right-click">' + remind[6][index]['value'] + '</span><button class="close right" data-dismiss="modal" onclick="removeRemind('+remind[6][index]['id']+', \''+'#resulted-' + id+'\')">&times;</button></div>'
              }
            }
          }
          $("#resulted-suggest-" + id).html(html)
        }, 200);
      })
      $("#resulted-" + id).focus(() => {
        $("#resulted-suggest-" + id).show()
      })
      $("#examed-" + id).blur(() => {
        setTimeout(() => {
          $("#exam-suggest-" + id).hide()
        }, 200);
      })
    })
  }
  function installRemind(name) {
    var timeout
    globalTarget[name]['input'].keyup(() => {
      clearTimeout(timeout)
      setTimeout(() => {
        var key = paintext(globalTarget[name]['input'].val())
        var html = ''
        for (const index in remind[globalTarget[name]['data']]) {
          if (remind[globalTarget[name]['data']].hasOwnProperty(index)) {
            const element = paintext(remind[globalTarget[name]['data']][index]['value']);
            
            if (element.search(key) >= 0) {
              html += '<div class="suggest_item" onclick="selectRemind(\'' + name + '\', \'' + remind[globalTarget[name]['data']][index]['value'] + '\')"><span class="right-click">' + remind[globalTarget[name]['data']][index]['value'] + '</span><button class="close right" data-dismiss="modal" onclick="removeRemind('+remind[globalTarget[name]['data']][index]['id']+', \''+name+'\')">&times;</button></div>'
            }
          }
        }
        globalTarget[name]['suggest'].html(html)
      }, 200);
    })
    globalTarget[name]['input'].focus(() => {
      globalTarget[name]['suggest'].show()
    })
    globalTarget[name]['input'].blur(() => {
      setTimeout(() => {
        globalTarget[name]['suggest'].hide()
      }, 200);
    })
  }
</script>
<!-- <END: main> -->