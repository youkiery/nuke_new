<!-- BEGIN: main -->
  <div class="row form-group">
    <label class="col-sm-6"> Ngày tháng </label>
    <div class="col-sm-12">
      <input type="text" value="{date}" class="form-control" id="sdate" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Tên tổ chức, cá nhân </label>
    <div class="col-sm-12">
      <input type="text" value="{org}" class="form-control" id="sorg" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Địa chỉ giao dịch </label>
    <div class="col-sm-12">
      <input type="text" value="{address}" class="form-control" id="saddress" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Điện thoại </label>
    <div class="col-sm-12">
      <input type="text" value="{phone}" class="form-control" id="sphone" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Fax </label>
    <div class="col-sm-12">
      <input type="text" value="{fax}" class="form-control" id="sfax" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Email </label>
    <div class="col-sm-12">
      <input type="text" value="{mail}" class="form-control" id="smail" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Chủ hộ </label>
    <div class="col-sm-12">
      <input type="text" value="{owner}" class="form-control" id="sowner" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Địa chỉ </label>
    <div class="col-sm-12">
      <input type="text" value="{ownaddress}" class="form-control" id="sownaddress" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Số điện thoại </label>
    <div class="col-sm-12">
      <input type="text" value="{ownphone}" class="form-control" id="sownphone" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Nội dung công việc </label>
    <div class="col-sm-12">
      <input type="text" value="{content}" class="form-control" id="scontent" autocomplete="off">
    </div>
  </div>

  <div class="form-group row">
    <label class="col-sm-6">
      Lấy mẫu
    </label>
    <div class="col-sm-12">
      <input type="text" value="{type}" class="form-control" id="stype" autocomplete="off">
    </div>
  </div>


  <div class="row form-group">
    <label class="col-sm-6"> Loại động vật </label>
    <div class="col-sm-12">
      <input type="text" value="{sample}" class="form-control" id="ssample" autocomplete="off">
    </div>
  </div>

  <div class="form-group row">
    <label class="col-sm-6">Số ĐKXN</label>
    <div class="col-sm-6">
      <input type="text" value="{xcode0}" class="form-control input-box xcode" id="sxcode1" autocomplete="off">
    </div>
    <div class="col-sm-6">
      <input type="text" value="{xcode1}" class="form-control input-box xcode" id="sxcode2" autocomplete="off">
    </div>
    <div class="col-sm-6">
      <input type="text" value="{xcode2}" class="form-control input-box xcode" id="sxcode3" autocomplete="off">
    </div>
  </div>

  <div class="html-sample" id="smsample">
  </div>

  <div class="row form-group">
    <label class="col-sm-6">Số phiếu</label>
    <div class="col-sm-12">
      <input type="text" value="{mcode}" class="form-control" id="smcode" autocomplete="off">
    </div>
  </div>

  <div class="row form-group">
    <label class="col-sm-6"> Người đề nghị </label>
    <div class="col-sm-12 relative">
      <input type="text" value="{reformer}" class="form-control" id="reformer-0" autocomplete="off">
      <div class="suggest" id="reformer-suggest-0"></div>
    </div>
  </div>

  <!-- BEGIN: secretary -->
  <div class="row form-group">
    <label class="col-sm-6"> Thanh toán </label>
    <div class="col-sm-12">
      <label> <input type="radio" name="pay" value="0" id="pay0" {pay0}> Chưa trả </label> <br>
      <label> <input type="radio" name="pay" value="1" id="pay1" {pay1}> Đã trả </label>
    </div>
  </div>
  <!-- END: secretary -->
<!-- END: main -->
