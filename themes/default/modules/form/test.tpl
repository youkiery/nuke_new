<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<style>
  legend {
    width: fit-content;
  }
</style>

<div class="msgshow" id="msgshow"></div>

<div class="html">
  <div class="row form-group">
    <label class="col-sm-4">
      Số ĐKXN
    </label>
    <div class="col-sm-6">
      <input type="text" name="xcode-1" class="form-control input-box xcode" id="form-insert-xcode-1" autocomplete="off">
    </div>
    <div class="col-sm-6">
        <input type="text" name="xcode-2" class="form-control input-box xcode" id="form-insert-xcode-2" autocomplete="off">
    </div>
    <div class="col-sm-6">
      <input type="text" name="xcode-3" class="form-control input-box xcode" id="form-insert-xcode-3" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Bên giao mẫu </label>
    <div class="col-sm-10">
      <input type="tex" name="receiver-unit" class="form-control">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Bên nhận mẫu </label>
    <div class="col-sm-10">
      <input type="tex" name="sender-unit" class="form-control">
    </div>
  </div>

  <fieldset>
    <legend>
      Mẫu
    </legend>
    <!-- BEGIN: sample -->
    <div class="row form-group">
      <label class="col-sm-6"> Kí hiệu mẫu </label>
      <div class="col-sm-10">
        <input type="text" name="samplecode[]" class="form-control">
      </div>
    </div>

    <div class="row form-group">
      <label class="col-sm-6"> Loại mẫu </label>
      <div class="col-sm-10">
        <select name="sampletype" class="form-control">
    
        </select>
      </div>
    </div>
    
    <div class="row form-group">
      <label class="col-sm-6"> Tình trạng mẫu </label>
        <input type="radio" name="samplestatus" class="form-control">
        <input type="radio" name="samplestatus" class="form-control">
    </div>

    <!-- BEGIN: standard -->
    <fieldset>
      <legend>
        Chỉ tiêu
      </legend>

      <div class="row form-group">
        <label class="col-sm-6"> Chỉ tiêu </label>
        <div class="col-sm-10">
          <input type="text" class="form-control">
        </div>
      </div>
      
      <div class="row form-group">
        <label class="col-sm-6"> Phương pháp </label>
        <div class="col-sm-10">
          <input type="text" class="form-control">
        </div>
      </div>
      
      <!-- BEGIN: result -->
      <fieldset>
        <legend>
          Kết quả
        </legend>

        <div class="row form-group">
          <label class="col-sm-6"> Kết quả </label>
          <div class="col-sm-10">
            <input type="text" class="form-control">
          </div>
        </div>

        <div class="row form-group">
          <label class="col-sm-6"> Ghi chú </label>
          <div class="col-sm-10">
            <input type="text" class="form-control">
          </div>
        </div>
      </fieldset>
      <!-- END: result -->
    </fieldset>
    <!-- END: standard -->
    <!-- END: sample -->
  </fieldset>

  <br>

  <div class="row form-group">
    <label class="col-sm-6"> Ngày xét nghiệm </label>
    <div class="col-sm-10">
      <input type="text" name="exam-date" class="form-control" id="exam-date">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Ngày hẹn trả kết quả </label>
    <div class="col-sm-10">
      <input type="text" name="iresend" class="form-control" id="iresend">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Ngày giao mẫu </label>
    <div class="col-sm-10">
      <input type="text" name="xsend" class="form-control">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Người giao mẫu </label>
    <div class="col-sm-10">
      <input type="text" name="xsender-employ" class="form-control">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Người nhận mẫu </label>
    <div class="col-sm-10">
      <input type="text" name="xreceiver-employ" class="form-control">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Ngày giao kết quả </label>
    <div class="col-sm-10">
      <input type="text" name="xre" class="form-control">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Người phụ trách bộ phận xét nghiệm </label>
    <div class="col-sm-10">
      <input type="text" class="form-control">
    </div>
  </div>
</div>

<script>
  var global_id = '{id}'
  var global_option = ['@page { size: 210mm 297mm landscape; margin: 20mm 10mm 20mm 30mm;} ']
  // var method = JSON.parse('{method}')
  // var method = JSON.parse('{method}')
  function printer() {
    var html = '<style>' + global_option[0] + '</style>' + $(".html")[0].innerHTML
    var winPrint = window.open('', '', 'left=0,top=0,width=800,height=600,toolbar=0,scrollbars=0,status=0');
    winPrint.focus()
    winPrint.document.write(html);
    winPrint.print()
    winPrint.close()
  }
</script>
<!-- END: main -->
