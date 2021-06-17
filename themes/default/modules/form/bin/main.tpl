<!-- BEGIN: main -->
<style>
  .right {
    overflow: auto;
  }
  .right-click {
    float: left;
    overflow: hidden;
    height: 32px;
    width: 80%;
  }
  .right2-click {
    float: left;
    overflow: hidden;
    height: 38px;
    width: 80%;
  }
</style>

<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<div class="msgshow" id="msgshow"></div>

<div id="form-summary" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div class="row">
          <label class="col-sm-4">Ngày bắt đầu</label>
          <div class="col-sm-5">
            <input type="text" class="form-control" id="form-summary-from" value="{summaryfrom}" autocomplete="off">
          </div>
          <label class="col-sm-4">Ngày kết thúc</label>
          <div class="col-sm-5">
            <input type="text" class="form-control" id="form-summary-end" value="{summaryend}" autocomplete="off">
          </div>
        </div>
        <label class="row" style="width: 100%;">
          <span class="col-sm-6"> Đơn vị </span>
          <div class="col-sm-12"> <input type="text" class="form-control" id="form-summary-unit"> </div>
        </label>
        <label class="row" style="width: 100%;">
          <span class="col-sm-6"> Yêu cầu xét nghiệm </span>
          <div class="col-sm-12"> <input type="text" class="form-control" id="form-summary-exam"> </div>
        </label>
        <label class="row" style="width: 100%;">
          <span class="col-sm-6"> Loại động vật </span>
          <div class="col-sm-12"> <input type="text" class="form-control" id="form-summary-sample"> </div>
        </label>
        <button class="btn btn-info" onclick="summaryFilter()">
          Xem tổng kết
        </button>
        <div id="form-summary-content"> {summarycontent} </div>
      </div>
    </div>
  </div>
</div>

<div id="method-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>

        <form onsubmit="insertMethodSubmit(event)">
          <div class="row">
            <label class="col-sm-6">Tên phương pháp</label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="insert-method-name" autocomplete="off">
            </div>
          </div>
          <div class="row">
            <label class="col-sm-6">Ký hiệu phương pháp</label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="insert-method-symbol" autocomplete="off">
            </div>
          </div>
          <div class="text-center">
            <button class="btn btn-success">
              Thêm
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="form-remove" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        Xác nhận xóa văn bản 
        <div class="text-center">
          <button class="btn btn-danger" onclick="removeSubmit()">
            Xóa
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<ul class="nav nav-tabs">
  <li class="active"><a data-toggle="tab" href="#home"> Danh sách </a></li>
  <!-- BEGIN: mod -->
  <li><a data-toggle="tab" href="#menu1"> Thêm văn bản </a></li>
  <!-- END: mod -->
</ul>

<div class="tab-content">
  <div id="home" class="tab-pane active">
    <form onsubmit="filter(event)">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control" id="filter-keyword" placeholder="Mẫu phiếu" autocomplete="off">
        </div>
        <div class="col-sm-6">
          <select class="form-control" id="filter-printer">
            <option value="1" selected>Mẫu 1</option>
            <option value="2">Mẫu 2</option>
            <option value="3">Mẫu 3</option>
            <option value="4">Mẫu 4</option>
            <option value="5">Mẫu 5</option>
          </select>
        </div>
        <div class="col-sm-6">
          <select class="form-control" id="filter-limit">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="75">75</option>
            <option value="100">100</option>
          </select>
        </div>
        <div class="col-sm-6"><button class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button></div>
      </div>      
    </form>
    <button class="btn btn-info" onclick="summary()"> Tổng kết </button>
    <div id="content">
      {content}
    </div>
  </div>

  <!-- BEGIN: mod2 -->
  <div id="menu1" class="tab-pane">
    <div id="credit"></div>
    <div class="row form-group boxed box-1 box-1-1">
      <label class="col-sm-6">Số phiếu</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-code" autocomplete="off">
      </div>
    </div>
    
    <div class="row form-group boxed box-2 box-2-1 box-3 box-3-2 box-4 box-4-1 box-5 box-5-15">
      <label class="col-sm-6">Số ĐKXN</label>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box xcode" id="form-insert-xcode-1" autocomplete="off">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box xcode" id="form-insert-xcode-2" autocomplete="off">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box xcode" id="form-insert-xcode-3" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-3 box-3-3">
      <label class="col-sm-6">Số trang</label>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box page" id="form-insert-page-1" autocomplete="off">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box page" id="form-insert-page-2" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-3 box-3-4">
      <label class="col-sm-6">Liên</label>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box no" id="form-insert-no-1" autocomplete="off">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box no" id="form-insert-no-2" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-2 box-5 box-5-2">
      <label class="col-sm-6">
        Tên đơn vị - khách hàng
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sender-employ" autocomplete="off">
        <div class="suggest" id="form-insert-sender-employ-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-2 box-4 box-4-14">
      <label class="col-sm-6"> Thời gian nhận mẫu </label>
      <label class="col-sm-9">
        Giờ 
        <select class="form-control" id="form-insert-sample-receive-hour">
          <!-- BEGIN: hour -->
          <option value="{value}">{value}</option>
          <!-- END: hour -->
        </select>
      </label>
      <label class="col-sm-9">
        Phút 
        <select class="form-control" id="form-insert-sample-receive-minute">
          <!-- BEGIN: minute -->
          <option value="{value}">{value}</option>
          <!-- END: minute -->
        </select>
      </label>
    </div>

    <div class="row form-group boxed box-1 box-1-3 box-2 box-2-3 box-3 box-3-1 box-4 box-4-15 box-5 box-5-10">
      <label class="col-sm-6">Ngày nhận mẫu</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-receive" autocomplete="off">
      </div>
    </div>
    
    <div class="row form-group boxed box-1 box-1-4 box-3 box-3-14">
      <label class="col-sm-6">Ngày hẹn trả kết quả</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-resend" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-1">
      <label class="col-sm-6"> Ngày thông báo kết quả </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-notice-time" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-12">
      <label class="col-sm-6">
        Ngày lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sample-receive" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-13">
      <label class="col-sm-6">
        Người lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sample-receiver" autocomplete="off">
        <div class="suggest" id="form-insert-sample-receiver-suggest"></div>
      </div>
    </div>

    <div class="boxed box-1 box-1-5">
      <label>Hình thức nhận</label>
      <div>
        <label><input type="radio" name="state" class="check-box state" id="state-0" checked>Trực tiếp</label>
      </div>
      <div>
        <label><input type="radio" name="state" class="check-box state" id="state-1">Bưu điện</label>
      </div>
      <div class="row form-group">
        <label class="col-sm-6"><input type="radio" name="state" class="check-box state" id="state-2">Khác</label>
        <div class="col-sm-12">
          <input type="text" class="form-control" id="form-insert-receive-state-other" autocomplete="off">
        </div>
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-6">
      <b> <p> Phòng chuyên môn </p> </b>
      <label class="col-sm-6">
        Người nhận hồ sơ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-receiver-employ" autocomplete="off">
        <div class="suggest" id="form-insert-receiver-employ-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-7">
      <label class="col-sm-6">Ngày nhận</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-ireceive" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-8">
      <label class="col-sm-6">Ngày trả</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-iresend" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-1 box-1-9">
      <div id="form-insert-form">

      </div>
      <button class="btn btn-success" onclick="addInfo(1)">
        <span class="glyphicon glyphicon-plus"></span>
      </button>
    </div>

    <div class="row form-group boxed box-2 box-2-4">
      <label class="col-sm-6">
        Người giao mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-isender-employ" autocomplete="off">
        <div class="suggest" id="form-insert-isender-employ-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-5 box-3 box-3-5 box-4 box-4-2">
      <label class="col-sm-6">
        Bộ phận giao mẫu - Khách hàng yêu cầu xét nghiệm
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-isender-unit" autocomplete="off">
        <div class="suggest" id="form-insert-isender-unit-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-3">
      <label class="col-sm-6">
        Địa chỉ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-address" autocomplete="off">
        <div class="suggest" id="form-insert-address-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-3">
      <label class="col-sm-6">
        Địa chỉ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-xaddress" autocomplete="off">
        <div class="suggest" id="form-insert-xaddress-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-4">
      <label class="col-sm-6">
        Chủ hộ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-owner" autocomplete="off">
        <div class="suggest" id="form-insert-owner-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-5">
      <label class="col-sm-6">
        Nơi lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sample-place" autocomplete="off">
        <div class="suggest" id="form-insert-sample-place-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-6 box-4 box-4-16">
      <label class="col-sm-6">
        Người nhận mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-ireceiver-employ" autocomplete="off">
        <div class="suggest" id="form-insert-ireceiver-employ-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-7">
      <label class="col-sm-6">
        Bộ phận nhận mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-ireceiver-unit" autocomplete="off">
        <div class="suggest" id="form-insert-ireceiver-unit-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-8 box-4 box-4-4">
      <label class="col-sm-6">
        Số điện thoại
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-xphone" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-8 box-4 box-4-5">
      <label class="col-sm-6">
        fax
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-fax" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-10 box-2 box-2-13 box-3 box-3-7 box-4 box-4-8 box-5 box-5-7">
      <label class="col-sm-6"> Số lượng mẫu </label>
      <div class="col-sm-12">
        <input type="number" class="form-control" id="form-insert-number" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-11 box-2 box-2-14 box-3 box-3-8 box-4 box-4-9 box-5 box-5-8">
      <label class="col-sm-6"> Số lượng mẫu (Chữ) </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-number-word" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-1 box-1-12 box-2 box-2-9 box-3 box-3-6 box-4 box-4-7 box-5 box-5-6">
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
        <label class="col-sm-6">
          <input type="radio" name="type" class="check-box type" id="typed-5">
          Khác
        </label>
        <div class="col-sm-12">
          <input type="text" class="form-control" id="form-insert-type-other" autocomplete="off">
        </div>
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-13 box-2 box-2-10 box-3 box-3-9 box-4 box-4-6">
      <label class="col-sm-6"> Loài vật được lấy mẫu </label>
      <div class="col-sm-12">
        <input type="text" class="form-control sample" id="form-insert-sample" autocomplete="off">
      </div>
    </div>

    <!-- <div class="form-group row boxed box-2 box-2-11">
      <label class="col-sm-6"> Số lượng mẫu </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-number2" autocomplete="off">
      </div>
    </div> -->

    <div class="form-group row boxed box-1 box-1-14 box-2 box-2-16 box-3 box-3-10 box-4 box-4-10 box-5 box-5-9">
      <label class="col-sm-6"> Ký hiệu mẫu </label>
      <div class="col-sm-12" id="form-insert-sample-parent">
        <input type="text" class="form-control" id="form-insert-sample-code" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-2 box-2-15 box-4 box-4-11">
      <label class="col-sm-6"> Tình trạng mẫu </label>
      <div>
        <input type="radio" name="status" class="check-box status status-0" checked>
        Đạt
      </div>
      <div>
        <input type="radio" name="status" class="check-box status status-1">
        Không đạt
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-17 box-3 box-3-11">
      <label> Đính kèm danh sách nhận diện mẫu </label>
      <div>
        <input type="radio" name="attach" class="check-box attach attach-0" checked>
        Có
      </div>
      <div>
        <input type="radio" name="attach" class="check-box attach attach-1">
        Không
      </div>
    </div>

    <div class="boxed box-2 box-2-18">
      <label> Hình thức bảo quản </label>
      <div>
        <input type="radio" name="xstatus" class="check-box xstatus status-0" checked>
        Thùng đá
      </div>
      <div>
        <input type="radio" name="xstatus" class="check-box xstatus status-1">
        Xe lạnh
      </div>
      <div>
        <input type="radio" name="xstatus" class="check-box xstatus status-2">
        Phương tiện khác
      </div>
    </div>

    <div class="boxed box-2 box-2-19">
      <label class="6"> Chất lượng chung của mẫu </label>
      <div>
        <input type="radio" name="quality" class="check-box quality quality-0" checked>
        Đạt
      </div>
      <div>
        <input type="radio" name="quality" class="check-box quality quality-1">
        Không đạt
      </div>
    </div>

    <div class="boxed box-1 box-1-15 box-2 box-2-20 box-3 box-3-12 box-4 box-4-17 box-5 box-5-12">
      <label>
        Yêu cầu xét nghiệm
        <button class="btn btn-success" onclick="insertMethod()"> <span class="glyphicon glyphicon-plus"></span> </button>
      </label>
      <div id="form-insert-request"></div>
      <button class="btn btn-success" onclick="addInfo(2)">
        <span class="glyphicon glyphicon-plus"></span>
      </button>
    </div>

    <div class="row form-group boxed box-1 box-1-16 box-2 box-2-21">
      <label class="col-sm-6">
        Ghi chú
      </label>
      <div class="col-sm-20">
        <textarea class="form-control" id="form-insert-xnote" autocomplete="off"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-22">
      <label class="col-sm-6"> Thời gian kết thúc</label>
      <label class="col-sm-6">
        Giờ 
        <select class="form-control" id="form-insert-ended-hour">
          <!-- BEGIN: hour2 -->
          <option value="{value}">{value}</option>
          <!-- END: hour2 -->
        </select>
      </label>
      <label class="col-sm-6">
        Phút 
        <select class="form-control" id="form-insert-ended-minute">
          <!-- BEGIN: minute2 -->
          <option value="{value}">{value}</option>
          <!-- END: minute2 -->
        </select>
      </label>
      <label class="col-sm-6">
        Số bản in
        <input type="text" class="form-control" id="form-insert-ended-copy" autocomplete="off">
      </label>
    </div>

    <div class="row form-group boxed box-3 box-3-13">
      <label class="col-sm-6">
        Yêu cầu khác
      </label>
      <div class="col-sm-20">
        <input type="text" class="form-control" id="form-insert-other" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-14 box-4 box-4-21">
      <label class="col-sm-6">
        Kết quả
      </label>
      <div class="col-sm-12">
        <textarea class="form-control" id="form-insert-result"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-13 box-4 box-4-19">
      <label class="col-sm-6">
        Ghi chú
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-note"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-20">
      <label class="col-sm-6">
        Ngày phân tích
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-exam-date" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-16">
      <label class="col-sm-6">
        Nơi nhận
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-receive-dis"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-17">
      <label class="col-sm-6">
        Người phụ trách
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-receive-leader"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-11">
      <label class="col-sm-6">
        Mục đích xét nghiệm
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-target" autocomplete="off"></textarea>
      </div>
    </div>

    <div class="text-center">
      <button class="btn btn-success" onclick="insertSubmit()"> Lưu biểu mẫu </button>
    </div>

    <button class="btn btn-info saved" id="saved-2-1" style="position: fixed; top: 10px; right: 10px;" onclick="printer(1)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved" id="saved-2-2" style="position: fixed; top: 45px; right: 10px;" onclick="printer(2)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved" id="saved-2-3" style="position: fixed; top: 80px; right: 10px;" onclick="printer(3)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved" id="saved-2-4" style="position: fixed; top: 115px; right: 10px;" onclick="printer(4)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved" id="saved-2-5" style="position: fixed; top: 150px; right: 10px;" onclick="printer(5)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-warning saved" id="saved-1-1" style="position: fixed; top: 10px; right: 50px;" onclick="parseBox(1)">
      <span class="glyphicon glyphicon-user"></span>
    </button>

    <button class="btn btn-warning saved" id="saved-1-2" style="position: fixed; top: 45px; right: 50px;" onclick="parseBox(2)">
      <span class="glyphicon glyphicon-user"></span>
    </button>

    <button class="btn btn-warning saved" id="saved-1-3" style="position: fixed; top: 80px; right: 50px;" onclick="parseBox(3)">
      <span class="glyphicon glyphicon-user"></span>
    </button>

    <button class="btn btn-warning saved" id="saved-1-4" style="position: fixed; top: 115px; right: 50px;" onclick="parseBox(4)">
      <span class="glyphicon glyphicon-user"></span>
    </button>

    <button class="btn btn-warning saved" id="saved-1-5" style="position: fixed; top: 150px; right: 50px;" onclick="parseBox(5)">
      <span class="glyphicon glyphicon-user"></span>
    </button>

    <button class="btn btn-success saved-0" style="position: fixed; top: 185px; right: 10px;" onclick="newForm()">
      <span class="glyphicon glyphicon-user"></span>
    </button>
  </div>
  <!-- END: mod2 -->
</div>

<script>
  var style = '<style> body { margin: 0px; } .document { width: 730px; border: 1px solid white; padding: 60px 60px 0px 100px; } .document * { font-family: "Times New Roman", Times, serif; font-size: 18px; } .text-center { text-align: center; } .text, .multiline-input, .border, .group, .inline { position: absolute; box-sizing: border-box; font-size: 20px; } .text, .group { width: max-content; } .text { overflow: hidden; } .border { border: 1px solid black; } table.form td { padding: 10px; } .form { border-collapse: collapse; width: 100%; } </style>'
  var former = {
    1: '<div class="document"> <div class="border" style="width: 150px; height: 100"></div> <div class="border" style="width: 580px; height: 100; left: 249px;"></div> <div class="text" style="width: 88px; text-align: center; left: 128px; top: 82px;"> CHI CỤC THÚ Y VÙNG V </div> <div class="text" style="left: 430px; top: 82px;"> <b>PHIẾU GIẢI QUYẾT HỒ SƠ</b> </div> <div class="text" style="left: 256px; top: 135px;">  <b>Số</b> (code)/TYV5-TH </div> <div class="text" style="left: 105px; top: 180; width: 720px;"> Tên đơn vị: (sender) </div> <div class="group" style="left: 105px; top: 210;"> <div class="text" style="width: 300px;">  Ngày nhận: (receive) </div> <div class="text" style="left: 400px; width: 300px;">  Ngày hẹn trả kết quả: (resend) </div> </div> <div class="group" style="left: 105px; top: 240;"> <div class="text">  Hình thức nhận: </div> <div class="group" style="left: 144px; width: 300px;"> <input type="checkbox" class="input" (state-0)> Trực tiếp </div> <div class="group" style="left: 300px; width: 300px;"> <input type="checkbox" class="input" (state-1)> Bưu điện </div> <div class="group" style="left: 450px; width: 300px;"> Khác: <span class="input"> (other) </span> </div> </div> <div class="text" style="left: 105px; top: 270; width: 730px;"> Người nhận hồ sơ: (receiver) </div> <div class="group" style="left: 105px; top: 300;"> <div class="text"> Phòng chuyên môn: </div> <div class="text" style="left: 200px; width: 300px;"> Ngày nhận: (ireceive) </div> <div class="text" style="left: 500px; width: 300px;"> Ngày trả: (iresend) </div> </div> <div class="border" style="left: 100px; top: 340; width: 730px; height: 330px;"> </div> <div class="text" style="left: 450; top: 350px;"> <u>Hồ sơ gồm:</u> </div> <div class="multiline-input" row="7" style="left: 110px; top: 380px; width: 700px; height: 280;">(form)</div> <div class="border" style="left: 100; top: 689px; width: 500; height: 30;">  </div> <div class="border" style="left: 599px; top: 689px; width: 230px; height: 30;"></div> <div class="border" style="left: 100; top: 718px; width: 500; height: 300px;"></div> <div class="border" style="left: 599px; top: 718px; width: 230; height: 300px;"></div> <div class="text" style="top: 695px; left: 115px;"> <b>Ý kiến của phòng, bộ phận chịu trách nhiệm giải quyết</b> </div> <div class="text" style="top: 695px; left: 610px;"> <b>Ý kiến của ban lãnh đạo</b> </div> <div class="text" style="top: 1030px; left: 100px; width: 730px;"> <i> <b> <u>Ghi chú:</u></b></i> Hồ sơ có ý kiến của thủ trưởng (hoặc người được ủy quyền) phải được giao lại cho bộ phận một cửa trước 01 ngày so với ngày hẹn trả kết quả </div> <div class="text" style=" top: 1175px; left: 100px;"> Mã số: BM-02/TYV5-06 </div> <div class="text" style="top: 1175px; left: 400px;"> Ngày ban hành: 02/11/2017, </div> <div class="text" style="top: 1175px; left: 650px;"> Lần sửa đổi: 02 </div> </div>',
    2: '<div class="document"> <div class="border" style="top: 115px; left: 50px; width: 300px; height: 45px;"></div> <div class="border" style="top: 110px; left: 140px; width: 93px;"></div> <div class="border" style="top: 110px; left: 496px; width: 218px;"></div> <div class="text" style="left: 140px; top: 60px;"> CỤC THÚ Y </div> <div class="text" style="left: 85px; top: 85px;"> <b>CHI CỤC THÚ Y VÙNG V</b></div> <div class="text" style="left: 410px; top: 60px;"> <b>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</b> </div> <div class="text" style="left: 495px; top: 85px;"> <b>Độc lập - Tự do - Hạnh phúc</b> </div> <div class="text" style="left: 60; top: 130px;"> Số ĐKXN: (xcode-0)/(xcode-1)/(xcode-2) </div> <div class="text" style="left: 430px; top: 130px;"> <i>Đắk Lắk, (receiveHour)giờ, (receiveMinute)p, ngày (receive-0) tháng (receive-1) năm (receive-2) </i> </div> <div class="text" style="left: 230px; top: 190;"><b>BIÊN BẢN GIAO NHẬN MẤU XÉT NGHIỆM</b></div> <div class="text" style="left: 100; top: 225;"> <b>1/ Đại diện bên giao mẫu</b> </div>  <div class="text" style="left: 100; top: 255;"> - Họ và tên: (isenderEmploy) </div> <div class="text" style="left: 100; top: 285;"> (isenderUnit) </div> <div class="text" style="left: 100; top: 315;"><b>2/ Đại diện bên nhận mẫu:</b></div> <div class="text" style="left: 100; top: 345;"> - Họ và tên: (ireceiverEmploy) </div> <div class="text" style="left: 100; top: 375;"> (ireceiverUnit) </div> <div class="text" style="left: 200; top: 405;">* Điện thoại: (phone)</div> <div class="text" style="left: 100; top: 435;"><b>3/ Thông tin về mẫu</b></div> <div class="group" style="left: 100; top: 475px;"> <div class="text"> - Loại mẫu: (type) </div> <div class="text" style="left: 330px;"> Loài vật được lấy mẫu: (sample) </div> </div> <div class="group" style="left: 100; top: 505px;"> <div class="text"> - Số lượng mẫu: (number) (numberword) </div> <div class="text" style="left: 330px;"> Tình trạng mẫu: (status) yêu cầu xét nghiệm </div> </div> <div class="text" style="left: 100; top: 535px; width: 730; height: 50px;"> - Ký hiệu mẫu: (sampleCode) </div> <div class="group" style="left: 100; top: 595px; width: 730px;"> * Ghi chú: (đính kèm danh sách nhận diện mẫu)  <span class="text" style="width: 100px; margin-left: 10px;"> có <input type="checkbox" class="input" (attach-0)> </span> <span class="text" style="width: 100px; left: 550px;"> không <input type="checkbox" class="input" (attach-1)> </span> </div> <div class="text" style="left: 60; top: 625px; width: 730px;">&ensp;&ensp;&ensp;&ensp;- Hình thức bảo quản, vận chuyển mẫu khi bàn giao (đề nghị gạch chéo vào một trong các ô sau đây)</div> <div class="group" style="left: 100; top: 685px;"> <div class="text" style="left: 50px;"> <input type="checkbox" (xstatus-0)> Thùng đá </div> <div class="text" style="left: 250px;"> <input type="checkbox" (xstatus-1)> Xe lạnh </div> <div class="text" style="left: 450px;"> <input type="checkbox" (xstatus-2)> Phương tiện khác </div> </div> <div class="group" style="left: 100; top: 715px;"> <div class="text" style="width: 730; height: 45px;"> - Chất lượng chung của mẫu khi bàn giao (dựa vào cảm quan để nhận xét): <span> (quality) </span> </div> </div> <div class="text" style="left: 100; top: 770px;"> <b>4/ Yêu cầu xét nghiệm</b> </div> <div class="group" style="left: 100; top: 800px; width: 730px; height: 250px;"> (exam) </div> <div class="text" style="left: 60; top: pos-1; width: 730;"> &ensp;&ensp;&ensp;&ensp;Biên bản kết thúc vào lúc (ended-hour)h (ended-minute)p cùng ngày; biên bản được lập thành (ended-copy) bản; bên giao và nhận thống nhất ký vào biên bản (bên nhận mẫu giữ bản copy). </div> <div class="text" style="left: 115px; top: pos-2;"><b>XÁC NHẬN CỦA BÊN NHẬN MẪU</b></div> <div class="text" style="left: 151px; top: pos-3;"><i>(Ký xác nhận, ghi rõ họ tên)</i></div> <div class="text" style="left: 500px; top: pos-2;"><b>XÁC NHẬN CỦA BÊN GIAO MẪU</b></div> <div class="text" style="left: 535px; top: pos-3;"><i>(Ký xác nhận, ghi rõ họ tên)</i></div>  </div>',
    3: '<div class="document">  <div class="border" style="top: 60px; left: 100px; width: 470; height: 60px;"></div> <div class="border" style="top: 60px; left: 569px; width: 260px; height: 60px;"></div> <div class="text" style="top: 63px; left: 220px;"><b>CHI CỤC THÚ Y VÙNG V</b></div> <div class="text" style="top: 90; left: 105px;"><b>TRẠM CHUẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT</b></div> <div class="text" style="top: 65; left: 572px;"><b>BIỂU MẪU SỐ: BM.STTT.02.02</b></div> <div class="text" style="top: 95; left: 615px;"><b>Số Soát xét: 03.02718</b></div> <div class="text" style="top: 130; left: 580;"> <i> Ngày receive-0 tháng receive-1 năm receive-2 </i> </div> <div class="text" style="top: 160; left: 350px;"><b>PHIẾU YÊU CẦU XÉT NGHIỆM</b></div> <div class="border" style="top: 190px; left: 485px; width: 340px; height: 100;"></div> <div class="text" style="top: 200; left: 500;"> <b>Số ĐKXN:</b> (xcode-0)/(xcode-1)/(xcode-2) </div> <div class="text" style="top: 230; left: 500;"> <b>Số trang:</b> (page-0)/(page-1) </div> <div class="text" style="top: 260; left: 500;"> <b>Liên: </b> (no-0)/(no-1) </div>  <div class="text" style="top: 310; left: 100;"> <b>Khách hàng:</b> (customer) </div> <div class="group" style="top: 340; left: 100;"> <b>Loại mẫu:</b> <div class="text" style="left: 150; top: 0px;"> Nguyên con <input type="checkbox" class="input" id="12" (type-0)> </div> <div class="text" style="left: 280; top: 0px;"> Huyết thanh <input type="checkbox" class="input" id="13" (type-1)> </div> <div class="text" style="left: 420; top: 0px;"> Máu <input type="checkbox" class="input" id="14" (type-2)> </div> <div class="text" style="left: 520; top: 0px;"> Phù tạng <input type="checkbox" class="input" id="15" (type-3)> </div> <div class="text" style="left: 620; top: 0px;"> Swab <input type="checkbox" class="input" id="16" (type-4)> </div> </div> <div class="text" style="top: 370; left: 100;"> Khác: (type-5) </div> <div class="group" style="top: 400; left: 100;"> <div class="text"> <b>Số lượng mẫu: </b> (number) (numberword) </div> <div class="text" style="left: 400"> <b>- Loài vật được lấy mẫu: </b> (sample) </div> </div> <div class="text" style="top: 430; left: 100; width: 730;"> <b>Số nhận diện: </b> (sampleCode) </div>  <div class="group" style="top: 480px; left: 150px;"> * Ghi chú: (Đính kèm danh sách nhận diện mẫu): <div class="text" style="left: 370px; top: 0;"> - Có <input type="checkbox" class="input" id="21" (attach-0)> </div> <div class="text" style="left: 500; top: 0;"> - Không <input type="checkbox" class="input" id="22" (attach-1)> </div> </div>  <div class="text" style="top: 510; left: 100;"><b>Chỉ tiêu xét nghiệm</b></div> (exam)  <div class="text" style="top: (position); left: 100;">(index). (exam-content) </div> <div class="text" style="top: (position-2); left: 100;"> Phương pháp xét nghiệm: (method) </div> <div class="text" style="top: (position-3); left: 100;"> Ký hiệu phương pháp: (symbol) </div> (/exam) <div class="text" style="top: pos-0px; left: 100;"> <b>Các yêu cầu khác:</b> (other) </div> <div class="text" style="top: pos-1px; left: 100;"> Ngày nhận mẫu receive-0/receive-1/receive-2</div> <div class="text" style="top: pos-1px; left: 550;"> Ngày hẹn trả kết quả: (resend-0)/(resend-1)/(resend-2)</div> <div class="text" style="top: pos-2px; left: 160;"><b>Khách hàng</b></div> <div class="text" style="top: pos-2px; left: 600px;"><b>Bộ phận nhận mẫu</b></div>',
    4: '<div class="document"> <table border="1" class="form"> <tr> <td class="text-center"> <b>Biểu mẫu số: BM.STTT.22.01</b> </td> <td class="text-center"> <b>Số soát xét: 03.02718</b> </td> </tr> <tr> <td colspan="2"> <div class="text-center"> <b>CHI CỤC THÚ Y VÙNG V</b> </div> <div class="text-center"> <b>TRẠM CHUẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT</b> </div> <div> Địa chỉ: Số 36 Phạm Hùng, Phường Tân An, Thành phố Buôn Ma Thuột, Tỉnh Đăklăk </div> <div> Điện thoại: 0262 3877793 </div> </td> </tr> </table> <div class="text-center" style="margin: 10px;"> <b>PHIẾU KẾT QUẢ XÉT NGHIỆM</b> </div> <div style="margin: 4px;"> <div style="float: left"> Số phiếu kết quả xét nghiệm: xcode-0/xcode-1/xcode-2.CĐXN </div> <div style="float: right">Trang: 1/2</div> </div> <table border="1" class="form"> <tr> <td colspan="2"> Tên khách hàng: (customer) </td> <td style="width: 30%"> Số ĐKXN: xcode-0/xcode-1/xcode-2</td> </tr> <tr> <td colspan="3"> <div> Địa chỉ khách hàng: (address) </div> <div style="float: left; width: 400px;"> Số điện thoại: (phone) </div> <div style="float: left; "> Fax: (fax) </div> </td> </tr> <tr> <td colspan="3"> Loài động vật lấy mẫu: (sample) </td> </tr> <td colspan="3"> Loại mẫu: (type) </td> </tr> <tr> <td colspan="3"> Số lượng mẫu: (number) (numberword) </td> </tr> <tr> <td colspan="3"> Ký hiệu mẫu: (sampleCode) </td> </tr> <tr> <td colspan="3"> Tình trạng khi nhận mẫu: (status) </td> </tr> <tr> <td style="width: 50%"> Ngày lấy mẫu: (sampleReceive) </td> <td colspan="2"> Người lấy mẫu: (sampleReceiver) </td> </tr> <tr> <td style="width: 50%"> Ngày, giờ nhận mẫu: (receiveHour)<sup>h</sup>(receiveMinute)<sup>p</sup> (ireceive)</td> <td colspan="2"> Người nhận mẫu: (ireceiver) </td> </tr> <tr> <td colspan="3">  <b><u>Chỉ tiêu xét nghiệm</u></b> <br> (exam)  <div>(index) (exam-content) </div> <div> Phương pháp xét nghiệm: (method); Ký hiệu phương pháp: (symbol). </div> (/exam) (note) </td> </tr> <tr> <td colspan="3"> Ngày phân tích: (examDate) </td> </tr> <tr> <td colspan="3"> <b> Kết quả: </b> <br> (result) </td> </tr> </table> <table style="width: 100%"> <tr> <td class="text-center"> Ngày examdate-0 tháng examdate-1 năm examdate-2 </td> <td class="text-center"> Ngày examdate-0 tháng examdate-1 năm examdate-2 </td> </tr> <tr> <td class="text-center"> <b>BỘ PHẬN XÉT NGHIỆM</b> </td> <td class="text-center"> <b>TRƯỞNG TRẠM</b> </td> </tr> <tr> <td class="text-center"> (Ký, ghi rõ họ tên) </td> </tr> </table> </div>',
    5: '<style> body { margin: 0px; } .document { border: 1px solid white; padding: 76px 57px 0px 132px; margin: 0px !important; } .document * { font-family: "Times New Roman", Times, serif; } .center { text-align: center; vertical-align: inherit; } .text, .multiline-input, .border, .group, .inline { position: absolute; box-sizing: border-box; font-size: 18px; } .text, .group { width: max-content; } .text { overflow: hidden; } .border { border: 1px solid black; } table.form td { padding: 10px; } .form { border-collapse: collapse; width: 100%; } div { margin-top: 8px; margin-bottom: 8px; } .p11{font-size: 11pt} .p12{font-size: 12pt} .p13{font-size: 13pt} .p14{font-size: 14pt} .p15{font-size: 15pt} .p16{font-size: 16pt} </style> <div class="document"> <table style="width: 100%;"> <tr> <td class="center p12">CỤC THÚ Y</td> <td class="center p13"> <b>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</b> </td> </tr> <tr> <td class="center p12"> <b>CHI CỤC THÚ Y VÙNG V</b> </td> <td class="center p13"> <b>Độc lập - Tự do - Hạnh phúc</b> </td> </tr> <tr> <td class="center p14"> Số &nbsp;&nbsp;&nbsp;&nbsp;/TYV5-TH </td> <td class="center p13"> <i>Đăk Lăk, ngày (iresend-0) tháng (iresend-1) năm (iresend-2)</i> </td> </tr> </table> <div class="center p15"> <b>THÔNG BÁO</b> </div> <div class="center p14"> <b>Kết quả xét nghiệm</b> </div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chi cục thú ý vùng V thông báo kết quả xét nghiệm được thực hiện tại Trạm Chẩn đoán xét nghiệm bệnh Động vật (trực thuộc Chi cục Thú y vùng V) như sau: </div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tên khách hàng: (customer) </div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Địa chỉ: (address)</div> (owner) <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Loại mẫu: (sample)</div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Số lượng mẫu: (number) (numberword) </div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ký hiệu mẫu: (sampleCode)</div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ngày nhận mẫu: (ireceive)</div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mục đích xét nghiệm: (target)</div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><i>Chỉ tiêu xét nghiệm: </i></b> </div> <div class="p14"> (exam) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (index)(content), Phương pháp xét nghiệm: (method); Ký hiệu phương pháp: (symbol)<br> (/exam) </div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (note) </div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><i>Kết quả:</i></b> </div> <div class="p14"> (result) </div>  	 <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <i>  Chi tiết xem phiếu kết quả xét nghiệm số: (xcode-0)/(xcode-1)/(xcode-2).CĐXN của trạm chuẩn đoán xét nghiệm bệnh động vật)./. </i></div> <table style="width: 100%;"> <tr> <td> <div class="p12"> <b><i>Nơi nhận</i></b> </div> <div class="p11"> (receivedis) </div> </td> <td> <div class="center p14"> <b>CHI CỤC TRƯỞNG <br> (receiveleader)</b> </div> </td> </tr> </table> </div>'};
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

  $("#form-insert-receive, #form-insert-resend, #form-insert-ireceive, #form-insert-iresend, #form-insert-sample-receive, #form-insert-sample-time, #form-insert-exam-date, #form-summary-from, #form-summary-end, #form-insert-notice-time").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  $('.printer-x').change(() => {
    var list = []
    $('.printer-x').each((index, item) => {
      if (item.children[0].checked) {
        list.push(item.innerText)
      }
    })
    filterPrinter.val(list.join(', '))
  })

  function clearFilterPrinter() {
    $('.printer-x').each((index, item) => {
      item.children[0].checked = false
    })
    filterPrinter.val('')
  }

  function parseSample() {
    formInsertCode.val('TY-5')
    formInsertSenderEmploy.val('Phùng chí kiên')
    formInsertReceiverEmploy.val('Mai thị lựu')
    formInsertReceive.val('25/11/2018')
    formInsertResend.val('28/11/2018')
    formInsertIreceive.val('25/11/2018')
    formInsertIresend.val('29/11/2018')
    addInfo(1)
    $(".form")[0].value = 'Mẫu'
    $(".form")[1].value = 'Phiếu'
    formInsertNumber.val(1)
    formInsertSample.val("Chó")
    formInsertStatus.val("Tốt")
    formInsertSampleCode.val("GD-05")
    addInfo(2)
    $(".exam")[0].value = 'Phát hiện virus H5N1'
    $(".exam")[1].value = 'Phát hiện virus H1N1'
  }

  function parseSample2() {
    parseSample()
    $(".xcode")[0].value = '25'
    $(".xcode")[1].value = '19'
    $(".xcode")[2].value = '013'
    formInsertSampleReceiveTime.val('25/11/1996')
    formInsertIsenderEmploy.val('Mai Thị Lựu')
    formInsertIsenderUnit.val('Phòng tổng hợp')
    formInsertIreceiverEmploy.val('Lưu Trọng Khoan')
    formInsertIreceiverUnit.val('Phòng xét nghiệm')
    formInsertQuality.val('Đạt')
  }

  function parseSample3() {
    parseSample()
    parseSample2()
    $(".page")[0].value = '01'
    $(".page")[1].value = '01'
    $(".no")[0].value = '01'
    $(".no")[1].value = '02'
    formInsertExamDate.val('11/05/2019')
    formInsertCustomer.val('Bộ thông tin và truyền thông')
    formInsertOther.val('Không')
    formInsertResult.val('Toàn bộ đều nhiễm bệnh sắp chết cmnr')
  }

  function parseBox(index) {
    if (visible[global_saved][1].search(index) >= 0) {
      global_form = index
      parseForm(index)
    }
  }

  function parseSaved() {
    $(".saved").addClass('disabled')
    
    $(".saved").each((index, item) => {
      var id = item.getAttribute('id').replace('saved-', '')
      var pos = id.split('-')
      
      if (visible[global_saved][pos[0]].search(pos[1]) >= 0) {
        $("#saved-" + id).removeClass('disabled')
      }
    })
  }

  function selectRemind(name, selectValue) {
    globalTarget[name]['input'].val(selectValue)
  }

  function selectRemindv2a(id, selectValue) {
    console.log(id, selectValue);
    
    $(id).val(selectValue)
  }

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

  function removeRemind(id, name) {
    if (id) {
      $.post(
        strHref,
        {action: 'removeRemind', id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            remind = JSON.parse(data['remind'])
            setTimeout(() => {
              globalTarget[name][input].val('')
            }, 100);
          }, () => {defreeze()})
        }
      )
    }
  }

  function removeRemindv2(name, type) {
    if (id) {
      $.post(
        strHref,
        {action: 'removeRemindv2', id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            remindv2 = JSON.parse(data['remind'])
            $("#"+ type +"-" + name).val('')
          }, () => {defreeze()})
        }
      )
    }
  }

  function selectRemindv2(name, type, value) {
    $("#"+ type +"-" + name).val(value)
  }

  function selectMethod(name, value) {
    $("#method-" + name).val(value)
  }

  function removeMethod(id, name) {
    if (id) {
      $.post(
        strHref,
        {action: 'removeMethod', id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            method = JSON.parse(data['method'])
            setTimeout(() => {
              $("#method-" + name).val('')
            }, 100);
          }, () => {defreeze()})
        }
      )
    }
  }

  function newForm() {
    global_id = 0
    global_form = 1
    global_saved = 0
    parseSaved()
    parseBox(global_form)
    formInsertCode.val('')
    formInsertSenderEmploy.val('')
    formInsertReceiverEmploy.val('')
    formInsertReceive.val('')
    formInsertResend.val('')
    formInsertIreceive.val('')
    formInsertIresend.val('')
    formInsertNumber.val('')
    formInsertSample.val('')
    formInsertStatus.val('')
    formInsertSampleCode.val('')
    formInsertTarget.val('')
    formInsertXcode1.val('')
    formInsertXcode2.val('')
    formInsertXcode3.val('')
    formInsertPage1.val('')
    formInsertPage2.val('')
    formInsertNo1.val('')
    formInsertNo2.val('')
    formInsertIsenderEmploy.val('')
    formInsertIsenderUnit.val('')
    formInsertIreceiverEmploy.val('')
    formInsertIreceiverUnit.val('')
    formInsertQuality.val('')
    formInsertCustomer.val('')
    formInsertAddress.val('')
    formInsertPhone.val('')
    formInsertSampleReceive.val('')
    formInsertExamDate.val('')
    formInsertOther.val('')
    formInsertResult.val('')
    formInsertIreceiverEmploy.val('')
    formInsertIreceiverUnit.val('')
    formInsertTarget.val('')
    formInsertEndedCopy.val('')
    formInsertSampleReceiver.val('')
    formInsertNote.val('')
    formInsertReceiveDis.val('')
    formInsertReceiveLeader.val('')
    formInsertXaddress.val('')
    formInsertOwner.val('')
    formInsertSamplePlace.val('')

    formInsertEndedHour.each((index, item) => {
      item.removeAttribute('selected')
    })
    formInsertEndedHour[0].children[0].setAttribute('selected', true)

    formInsertEndedMinute.each((index, item) => {
      item.removeAttribute('selected')
    })
    formInsertEndedMinute[0].children[0].setAttribute('selected', true)

    formInsertSampleReceiveHour.each((index, item) => {
      item.removeAttribute('selected')
    })
    formInsertSampleReceiveHour[0].children[0].setAttribute('selected', true)

    formInsertSampleReceiveMinute.each((index, item) => {
      item.removeAttribute('selected')
    })
    formInsertSampleReceiveMinute[0].children[0].setAttribute('selected', true)

    $(".formed").each((index, item) => {
      removeInfo(1, index)
    })
    $(".examed").each((index, item) => {
      removeInfo(2, index)
    })
    $(".resulted").each((index, item) => {
      removeInfo(3, index)
    })
    infoData = {1: [], 2: [], 3: []}
    addInfo(1)
    addInfo(2)
    addInfo(3)
    $(".type").prop('checked', false)
    $(".state").prop('checked', false)

    $("#typed-0").prop('checked', true)
    $("#state-0").prop('checked', true)
    formInsertReceiverStateOther.val('')
    formInsertTypeOther.val('')
  }

  function summary() {
    formSummary.modal('show')
  }

  function summaryFilter() {
    freeze()
    $.post(
      strHref,
      {action: 'summaryFilter', from: formSummaryFrom.val(), end: formSummaryEnd.val(), unit: formSummaryUnit.val(), exam: formSummaryExam.val(), sample: formSummarySample.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          formSummaryContent.html(data['html'])
        }, () => { defreeze() })
      }
    )
  }

  function parseInputs(data, name) {
    $("." + name + "ed").remove()
    
    var array = data['form'][name]
    array = array.split(', ')
    if (data['form']['method']) {
      methodx = data['form']['method'].split(', ')
      symbolx = data['form']['symbol'].split(', ')
    }
    
    array.forEach((element, index) => {
      addInfo(dataPicker[name])
      if (dataPicker[name] == 1) {
        $("#formed-" + index).val(element)
      }
      else if (dataPicker[name] == 2) {
        $("#examed-" + index).val(element)
        $("#method-" + index).val(methodx[index])
        $("#symbol-" + index).val(symbolx[index])
      }
      else {
        $("#resulted-" + index).val(element)
      }
    });
  }

  function insert() {
    formInsert.modal('show')
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

  function removeInfo(id, index) {
    switch (id) {
      case 1:
        $("#form-" + index).remove()
        break;
      case 2:
        $("#exam-" + index).remove()
        break;
      case 3:
        $("#result-" + index).remove()
        break;
    }
  }

  function gatherInput(className) {
    var data = []
    $("." + className).each((index, item) => {
      data.push(item.value)
    })
    return data
  }

  function getCheckbox(name, target = null) {
    var check = 0
    var count = 0
    $(".check-box." + name).each((index, item) => {
      count = index
      if (item.checked) {
        check = index
      }
    })    
    if (check == count && target) {
      return {index: check, value: target.val()}
    } 
    return {index: check, value: ''}
  }

  function getInputs(name, tag = '') {
    var list = []
    $(".input-box." + name).each((index, item) => {
      var row = item.value
      if (tag) {
        row = (index + 1) + tag + row
      }
      list.push(row)
    })    
    return list
  }

  function checkSampleCode(target, parent, number = 1) {
    var value = trim(target.val()).toUpperCase()
    while (value.search('  ') >= 0) {
      value = value.replace(/  /g, ' ')
    }
    value = value.replace(/;/g, ',')
    value = value.split(/, /g)
    target.val(value.join(', '))
    
    if (value.length != number) {
      parent.addClass('has-error')
      alert_msg('Sai số lượng ký hiệu mẫu: ' + value.length + '/' + number);
      return 0
    }
    parent.removeClass('has-error')
    return 1
  }

  function remove(id) {
    formRemove.modal('show')
    global_id = id
  }

  function removeSubmit() {
    freeze()
    $.post(
      strHref, 
      {action: 'remove', id: global_id, page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          formRemove.modal('hide')
        }, () => {defreeze()})
      }
    )
  }
//
  function checkForm(id) {
    var data = {}
    switch (id) {
      case 1:
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            code: formInsertCode.val(),
            sender: formInsertSenderEmploy.val(),
            receive: formInsertReceive.val(),
            resend: formInsertResend.val(),
            state: getCheckbox('state', formInsertReceiverStateOther),
            receiver: formInsertReceiverEmploy.val(),
            ireceive: formInsertIreceive.val(),
            iresend: formInsertIresend.val(),
            form: getInputs('form', ') '),
            forms: getInputs('form'),
            number: formInsertNumber.val(),
            sample: formInsertSample.val(),
            type: getCheckbox('type', formInsertTypeOther),
            samplecode: formInsertSampleCode.val(),
            exam: getInputs('exam', ') '),
            exams: getInputs('exam'),
            symbol: getInputs('symbol'),
            xnote: formInsertXnote.val(),
            numberword: formInsertNumberWord.val(),
            methods: getInputs('method')
          }
        }
      break;
      case 2: 
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            // xcode, receivehour, receiveminute, receive, isender-employ, isender-unit, ireceive-employ, ireceiver-unit, xphone, type, sample, number, status, samplecode, attach, xstatus, quality, exam, method, xnote, endedhour, endedminute, endedcopy
            xcode: getInputs('xcode'),
            receivehour: formInsertSampleReceiveHour.val(),
            receiveminute: formInsertSampleReceiveMinute.val(),
            isenderemploy: formInsertIsenderEmploy.val(),
            isenderunit: formInsertIsenderUnit.val(),
            ireceiveremploy: formInsertIreceiverEmploy.val(),
            ireceiverunit: formInsertIreceiverUnit.val(),
            type: getCheckbox('type', formInsertTypeOther),
            endedcopy: formInsertEndedCopy.val(),
            xnote: formInsertXnote.val(),
            endedhour: formInsertEndedHour.val(),
            endedminute: formInsertEndedMinute.val(),
            status: getCheckbox('status'),
            sample: formInsertSample.val(),
            receive: formInsertReceive.val(),
            number: formInsertNumber.val(),
            attach: getCheckbox('attach'),
            samplecode: formInsertSampleCode.val(),
            xstatus: getCheckbox('xstatus'),
            quality: getCheckbox('quality'),
            exam: getInputs('exam', ') '),
            method: getInputs('method'),
            numberword: formInsertNumberWord.val(),
            exams: getInputs('exam'),
            methods: getInputs('method'),
            symbol: getInputs('symbol'),
            xphone: formInsertXphone.val()
          }
        }
      break;
      case 3:
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            // receive, xcode, page, no, isender-unit, type, number, sample, samplecode, attach, exam, method, other, resend
            attach: getCheckbox('attach'),
            receive: formInsertReceive.val(),
            resend: formInsertResend.val(),
            xcode: getInputs('xcode'),
            page: getInputs('page'),
            no: getInputs('no'),
            isenderunit: formInsertIsenderUnit.val(),
            number: formInsertNumber.val(),
            sample: formInsertSample.val(),
            samplecode: formInsertSampleCode.val(),
            type: getCheckbox('type', formInsertTypeOther),
            other: formInsertOther.val(), 
            exam: getInputs('exam', ') '),
            method: getInputs('method'),
            exams: getInputs('exam'),
            symbol: getInputs('symbol'),
            numberword: formInsertNumberWord.val(),
            methods: getInputs('method'),
          }
        }
      break;            
      case 4:
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            // xcode, isender-unit, address. xphone, sample, type, number, samplecode, status, sample-receive, sample-receiver, receive-hour, receive-minute, receive, receiver-employ, exam, method, note, note, examdate, result
            receive: formInsertReceive.val(),
            xcode: getInputs('xcode'),
            receivehour: formInsertSampleReceiveHour.val(),
            receiveminute: formInsertSampleReceiveMinute.val(),
            type: getCheckbox('type', formInsertTypeOther),
            number: formInsertNumber.val(),
            status: getCheckbox('status'),
            samplecode: formInsertSampleCode.val(),
            isenderunit: formInsertIsenderUnit.val(), 
            address: formInsertAddress.val(),
            fax: formInsertFax.val(),
            xphone: formInsertXphone.val(),
            samplereceive: formInsertSampleReceive.val(),
            samplereceiver: formInsertSampleReceiver.val(),
            examdate: formInsertExamDate.val(),
            result: formInsertResult.val(),
            sample: formInsertSample.val(),
            note: formInsertNote.val(),
            ireceiveremploy: formInsertIreceiverEmploy.val(),
            exam: getInputs('exam', ') '),
            method: getInputs('method'),
            exams: getInputs('exam'),
            numberword: formInsertNumberWord.val(),
            symbol: getInputs('symbol'),
            methods: getInputs('method'),
          }
        }
      break;
      case 5:
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            // resend, sender-employ, address, owner, sample-place, type, number, sample-code, , receive, target, exam, method, note, result, xcode, receive-dis, receive-leader
            xcode: getInputs('xcode'),
            sender: formInsertSenderEmploy.val(),
            resend: formInsertNoticeTime.val(),
            xaddress: formInsertXaddress.val(),
            number: formInsertNumber.val(),
            samplecode: formInsertSampleCode.val(),
            // ireceive: formInsertIreceive.val(),
            target: formInsertTarget.val(),
            note: formInsertNote.val(),
            receivedis: formInsertReceiveDis.val(),
            receiveleader: formInsertReceiveLeader.val(),
            sampleplace: formInsertSamplePlace.val(),
            owner: formInsertOwner.val(),
            exam: getInputs('exam'),
            method: getInputs('method'),
            exams: getInputs('exam'),
            methods: getInputs('method'),
            symbol: getInputs('symbol'),
            result: formInsertResult.val(),
            receive: formInsertReceive.val(),
            numberword: formInsertNumberWord.val(),
            type: getCheckbox('type', formInsertTypeOther),
          }
        }
      break;
    }
    return data
  }

  function edit(id) {
    $.post(
      strHref,
      {action: 'getForm', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          newForm()
          global_id = id
          global_form = global_printer
          global_saved = data['form']['printer']
          parseSaved()
          
          parseBox(global_form)
          infoData = {1: [], 2: [], 3: []}

          if (data['form']['printer'] >= 1) {
            formInsertCode.val(data['form']['code'])
            formInsertSenderEmploy.val(data['form']['sender'])
            formInsertReceiverEmploy.val(data['form']['receiver'])
            formInsertReceive.val(data['form']['receive'])
            formInsertResend.val(data['form']['resend'])
            formInsertIreceive.val(data['form']['ireceive'])
            formInsertIresend.val(data['form']['iresend'])
            formInsertNumber.val(data['form']['number'])
            formInsertSample.val(data['form']['sample'])
            formInsertSampleCode.val(data['form']['samplecode'])
            formInsertXnote.val(data['form']['xnote'])
            formInsertNumberWord.val(data['form']['numberword']),

            parseInputs(data, 'exam')
            parseInputs(data, 'form')
            $("#typed-" + data['form']['typeindex']).prop('checked', true)
            if (data['form']['typeindex'] == 5) {
              formInsertTypeOther.val(data['form']['typevalue'])
            }
            $("#state-" + data['form']['stateindex']).prop('checked', true)
            if (data['form']['stateindex'] == 2) {
              formInsertReceiverStateOther.val(data['form']['statevalue'])
            }
          }

          if (data['form']['printer'] >= 2) {
            var xcode = data['form']['xcode'].split(',')
            formInsertXcode1.val(xcode[0])
            formInsertXcode2.val(xcode[1])
            formInsertXcode3.val(xcode[2])
            formInsertXphone.val(data['form']['xphone'])
            // formInsertSampleReceiveTime.val(data['form']['receivetime'])
            formInsertEndedCopy.val(data['form']['endedcopy'])
            formInsertIsenderEmploy.val(data['form']['isenderemploy'])
            formInsertIsenderUnit.val(data['form']['isenderunit'])
            formInsertIreceiverEmploy.val(data['form']['ireceiveremploy'])
            formInsertIreceiverUnit.val(data['form']['ireceiverunit'])
            
            $(".xstatus-" + data['form']['xstatus']).prop('checked', true)
            $(".attach-" + data['form']['attach']).prop('checked', true)
            $(".status-" + data['form']['status']).prop('checked', true)
            $(".quality-" + data['form']['quality']).prop('checked', true)

            for (const key in formInsertEndedHour[0].children) {
              if (formInsertEndedHour[0].children.hasOwnProperty(key)) {
                if (key == data['form']['endedhour']) { 
                  formInsertEndedHour[0].children[key].setAttribute('selected', true)
                }
                else {
                  formInsertEndedHour[0].children[key].removeAttribute('selected')
                }
              }
            }
            for (const key in formInsertEndedMinute[0].children) {
              if (formInsertEndedMinute[0].children.hasOwnProperty(key)) {
                if (key == data['form']['endedminute']) {
                  formInsertEndedMinute[0].children[key].setAttribute('selected', true)
                }
                else {
                  formInsertEndedMinute[0].children[key].removeAttribute('selected')
                }
              }
            }

            for (const key in formInsertSampleReceiveHour[0].children) {
              if (formInsertSampleReceiveHour[0].children.hasOwnProperty(key)) {
                if (key == data['form']['receivehour']) { 
                  formInsertSampleReceiveHour[0].children[key].setAttribute('selected', true)
                }
                else {
                  formInsertSampleReceiveHour[0].children[key].removeAttribute('selected')
                }
              }
            }
            for (const key in formInsertSampleReceiveMinute[0].children) {
              if (formInsertSampleReceiveMinute[0].children.hasOwnProperty(key)) {
                if (key == data['form']['receiveminute']) {
                  formInsertSampleReceiveMinute[0].children[key].setAttribute('selected', true)
                }
                else {
                  formInsertSampleReceiveMinute[0].children[key].removeAttribute('selected')
                }
              }
            }
          }

          if (data['form']['printer'] >= 3) {
            var page = data['form']['page'].split(',')
            var no = data['form']['no'].split(',')
            formInsertPage1.val(page[0])
            formInsertPage2.val(page[1])
            formInsertNo1.val(no[0])
            formInsertNo2.val(no[1])
            formInsertOther.val(data['form']['other'])
          }

          if (data['form']['printer'] >= 4) {
            // address. xphone, sample, type, number, samplecode, status, sample-receive, sample-receiver, receive-hour, receive-minute, receive, receiver-employ, exam, method, note, note, examdate, result
            
            formInsertResult.val(data['form']['result'])
            formInsertSampleReceiver.val(data['form']['samplereceiver'])
            formInsertSampleReceive.val(data['form']['samplereceive'])
            formInsertExamDate.val(data['form']['examdate'])
            formInsertNote.val(data['form']['note'])
            formInsertAddress.val(data['form']['address'])
            formInsertFax.val(data['form']['fax'])
          }

          if (data['form']['printer'] >= 5) {
            // resend, sender-employ, address, owner, sample-place, type, number, sample-code, , receive, target, exam, method, note, result, xcode, receive-dis, receive-leader

            formInsertOwner.val(data['form']['owner'])
            if (data['form']['noticetime']) {
              formInsertNoticeTime.val(data['form']['noticetime'])
            }
            else {
              formInsertNoticeTime.val(today)
            }
            formInsertSamplePlace.val(data['form']['sampleplace'])
            formInsertXaddress.val(data['form']['xaddress'])
            formInsertTarget.val(data['form']['target'])
            formInsertReceiveDis.val(data['form']['receivedis'])
            formInsertReceiveLeader.val(data['form']['receiveleader'])
          }
          
          $('a[href="#menu1"]').tab('show')
        }, () => {defreeze()})
      }
    )
  }

  function parseForm(id) {
    var list = []
    var credit = document.getElementById('credit')
    var box = $(".box-" + id)
    $(".boxed").hide()
    box.show()
    box.each((index, item) => {
      var className = item.getAttribute('class')
      var start = className.indexOf('box-' + id + '-')
      var end = className.indexOf(' ', start)
      if (end < 0) {
        var pos = className.slice(start + 6) 
      }
      else {
        var pos = className.slice(start + 6, end) 
      }

      if (pos) {
        list[pos] = item
      }
    })

    for (const listKey in list) {
      if (list.hasOwnProperty(listKey)) {
        const item = list[listKey];
        credit.appendChild(item)
      }
    }
  }

  // function gritForm(id) {
  //   freeze()
  //     $.post(
  //       strHref,
  //       {action: 'insert', formid: id},
  //       (response, status) => {
  //         checkResult(response, status).then(data => {

  //         }, () => {defreeze()})
  //       }
  //     )
  // }

  function insertSubmit() {
    freeze()
    var data = checkForm(global_form)
    if (Object.keys(data).length) {
      $.post(
        strHref,
        {action: 'insert', form: global_form, id: global_id, data: data, page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            remind = JSON.parse(data['remind'])
            if (global_form > global_saved) {
              global_saved = global_form
            }
            parseSaved()
            content.html(data['html'])
            global_id = data['id']
          }, () => {defreeze()})
        }
      )
    }
    else {
      defreeze()
    }
  }

  function filter(e) {
    e.preventDefault()
    freeze()
    $.post(
      strHref,
      {action: 'filter', page: 1, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global_page = 1
          global_printer = filterPrinter.val()
          content.html(data['html'])
        }, () => {defreeze()})
      }
    )
  }

  function goPage(page) {
    freeze()
    $.post(
      strHref,
      {action: 'filter', page: page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global_page = page
          content.html(data['html'])
        }, () => {defreeze()})
      }
    )
  }

  function findMethod(value) {
    for (const key in method) {
      item = method[key];
      if (item['name'] == value) {
        return item['symbol']
      }
    }
    return ''
  }

  function preview(id) {
    $.post(
      strHref,
      {action: 'preview', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          printer(global_printer, data)
        }, () => {})
      }
    )
  }

  function printer(id, data = {}) {
    if (Object.keys(data).length || visible[global_saved][2].search(id) >= 0) {
      if (!Object.keys(data).length) {
        var data = checkForm(id)
      }
      
      if (Object.keys(data).length) {
        var html = former[id]
        id = Number(id)
        switch (id) {
          case 1:
            html = html.replace('(code)', data['code'])
            html = html.replace('(sender)', data['sender'])
            html = html.replace('(receiver)', data['receiver'])
            html = html.replace('(receive)', data['receive'])
            html = html.replace('(resend)', data['resend'])
            html = html.replace('(ireceive)', data['ireceive'])
            html = html.replace('(iresend)', data['iresend'])
            html = html.replace('(state-0)', data['state']['index'] == 0 ? 'checked' : '')
            html = html.replace('(state-1)', data['state']['index'] == 1 ? 'checked' : '')
            html = html.replace('(other)', data['state']['value'])
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(form)', (data['form'].join('<br>') + '<br>Số lượng mẫu: ' + data['number'] + ', loại mẫu: ' + (data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text())) + ', loài động vật: ' + data['sample'] + '<br> Ký hiệu mẫu: ' + data['samplecode'] + '<br>Yêu cầu xét nghiệm:<br>' + ((data['exam'].length > 1 ? data['exam'].join('<br>') : data['exams'].join('<br>')) + (trim(data['xnote']).length ? '<br>Ghi chú: <br>' + data['xnote'].replace(/\n/g, '<br>') : ''))))
          break;
          case 2:
            var receive = data['receive'].split('/')
            var xnote = data['xnote'].split('\n')
            html = html.replace('(xcode-0)', trim(data['xcode'][0]))
            html = html.replace('(xcode-1)', trim(data['xcode'][1]))
            html = html.replace('(xcode-2)', trim(data['xcode'][2]))
            html = html.replace('(attach-0)', data['attach']['index'] == 0 ? 'checked' : '')
            html = html.replace('(attach-1)', data['attach']['index'] == 1 ? 'checked' : '')
            html = html.replace('(receive-0)', receive[0])
            html = html.replace('(receive-1)', receive[1])
            html = html.replace('(receive-2)', receive[2])
            html = html.replace('(phone)', data['xphone'])
            html = html.replace('(ended-copy)', data['endedcopy'])
            html = html.replace('(ended-hour)', data['endedhour'])
            html = html.replace('(ended-minute)', data['endedminute'])
            html = html.replace('(receiveHour)', data['receivehour'])
            html = html.replace('(receiveMinute)', data['receiveminute'])
            html = html.replace('(isenderEmploy)', data['isenderemploy'])
            html = html.replace('(isenderUnit)', data['isenderunit'])
            html = html.replace('(ireceiverEmploy)', data['ireceiveremploy'])
            html = html.replace('(ireceiverUnit)', data['ireceiverunit'])
            html = html.replace('(type)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('(sample)', data['sample'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['samplecode'])
            html = html.replace('(status)', ticked[data['status']['index']])
            html = html.replace('(quality)', ticked[data['quality']['index']])
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(xstatus-0)', data['xstatus']['index'] == 0 ? 'checked' : '')
            html = html.replace('(xstatus-1)', data['xstatus']['index'] == 1 ? 'checked' : '')
            html = html.replace('(xstatus-2)', data['xstatus']['index'] == 2 ? 'checked' : '')
            var exam = ''
            var pos = 770;
            var top = 0
            
            if (!(data['exam'].length > 1)) {
              data['exam'] = data['exams']
            }
            for (const key in data['exam']) {
              item = data['exam'][key]
              exam += '<div class="text" style="top: '+top+'px">' + item + '</div>'
              top += 30
            }
            
            if (xnote.length && trim(xnote) != "") {
              exam += '<div class="text" style="top: '+top+'px">Ghi chú: </div>'
              top += 30
              for (const key in xnote) {
                item = xnote[key]
                exam += '<div class="text" style="top: '+top+'px">' + item + '</div>'
                top += 30
              }
            }

            html = html.replace('(exam)', exam)
            html = html.replace(/pos-1/g, (pos + top + 30) + 'px') 
            html = html.replace(/pos-2/g, (pos + top + 90) + 'px') 
            html = html.replace(/pos-3/g, (pos + top + 120) + 'px') 
          break;
          case 3:
            var receive = data['receive'].split('/')
            var resend = data['resend'].split('/')
            html = html.replace('(attach-0)', data['attach']['index'] == 0 ? 'checked' : '')
            html = html.replace('(attach-1)', data['attach']['index'] == 1 ? 'checked' : '')
            html = html.replace('(xcode-0)', trim(data['xcode'][0]))
            html = html.replace('(xcode-1)', trim(data['xcode'][1]))
            html = html.replace('(xcode-2)', trim(data['xcode'][2]))
            html = html.replace('(page-0)', trim(data['page'][0]))
            html = html.replace('(page-1)', trim(data['page'][1]))
            html = html.replace('(no-0)', trim(data['no'][0]))
            html = html.replace('(no-1)', trim(data['no'][1]))
            html = html.replace('(customer)', data['isenderunit'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sample)', data['sample'])
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(sampleCode)', data['samplecode'])
            html = html.replace('(type-0)', data['type']['index'] == 0 ? 'checked' : '')
            html = html.replace('(type-1)', data['type']['index'] == 1 ? 'checked' : '')
            html = html.replace('(type-2)', data['type']['index'] == 2 ? 'checked' : '')
            html = html.replace('(type-3)', data['type']['index'] == 3 ? 'checked' : '')
            html = html.replace('(type-4)', data['type']['index'] == 4 ? 'checked' : '')
            html = html.replace('(type-5)', data['type']['value'])
            html = html.replace('(result)', data['result'])
            
            html = html.replace(/(receive-0)/g, receive[0])
            html = html.replace(/(receive-1)/g, receive[1])
            html = html.replace(/(receive-2)/g, receive[2])
            html = html.replace('(resend-0)', resend[0])
            html = html.replace('(resend-1)', resend[1])
            html = html.replace('(resend-2)', resend[2])
            
            html = html.replace('(other)', data['other'])
            var length = data['exam'].length
            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var position = 540
            var parse = ''
            for (let i = 0; i < length; i++) {
              var temp = part 
              if (data['exams'].length > 1) {
                temp = temp.replace('(index)', i + 1)
              }
              else {
                temp = temp.replace('(index)', '')
              }
              temp = temp.replace('(position)', position + "px")
              temp = temp.replace('(position-2)', position + 30 + "px")
              temp = temp.replace('(position-3)', position + 60 + "px")
              temp = temp.replace('(exam-content)', data['exams'][i])
              temp = temp.replace('(method)', data['method'][i])
              temp = temp.replace('(symbol)', data['symbol'][i])
              parse += temp
              position += 90
            }
            html = html.replace('(parse)', parse)
            html = html.replace(/pos-0/g, position)
            html = html.replace(/pos-1/g, position + 30)
            html = html.replace(/pos-2/g, position + 60)
          break; 
          case 4:
            var receive = data['receive'].split('/')
            var examdate = data['examdate'].split('/')
            html = html.replace(/xcode-0/g, trim(data['xcode'][0]))
            html = html.replace(/xcode-1/g, trim(data['xcode'][1]))
            html = html.replace(/xcode-2/g, trim(data['xcode'][2]))
            html = html.replace('(customer)', data['isenderunit'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['samplecode'])

            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(sample)', data['sample'])
            html = html.replace('(receiveHour)', data['receivehour'])
            html = html.replace('(receiveMinute)', data['receiveminute'])
            html = html.replace('(address)', data['address'])
            html = html.replace('(phone)', data['xphone'])
            html = html.replace('(fax)', data['fax'])
            html = html.replace('(type)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('(status)', ticked[data['status']['index']] + ' yêu cầu xét nghiệm')
            html = html.replace('(sampleReceive)', data['samplereceive'])
            html = html.replace('(sampleReceiver)', data['samplereceiver'])
            html = html.replace('(ireceive)', data['receive'])
            html = html.replace('(ireceiver)', data['ireceiveremploy'])
            html = html.replace('(examDate)', data['examdate'])
            html = html.replace(/examdate-0/g, examdate[0])
            html = html.replace(/examdate-1/g, examdate[1])
            html = html.replace(/examdate-2/g, examdate[2])
            html = html.replace('(result)', data['result'].replace(/\n/g, '<br>'))
            var noteString = ''
            if (trim(data['note'])) {
              // (note)
              var note = data['note'].split('\n');
              var notes = []
              note.forEach(item => {
                notes.push('<i>' + item + '</i>')
              })
              noteString += '<u style="display: inline-block"><b>Ghi chú:</b></u> <div style="display: inline-table">' + notes.join('<br>') + '</div>'
            }
            html = html.replace('(note)', noteString)

            var length = data['exam'].length
            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var parse = ''
            for (let i = 0; i < length; i++) {
              var temp = part 
              if (data['exams'].length > 1) {
                temp = temp.replace('(index)', i + 1 + '. ')
              }
              else {
                temp = temp.replace('(index)', '')
              }
              temp = temp.replace('(exam-content)', data['exams'][i])
              temp = temp.replace('(method)', data['method'][i])
              temp = temp.replace('(symbol)', data['symbol'][i])
              parse += temp
            }
            html = html.replace('(parse)', parse)
          break;
          case 5:
            var iresend = data['resend'].split('/')
            var tabbed = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
            
            html = html.replace('(xcode-0)', trim(data['xcode'][0]))
            html = html.replace('(xcode-1)', trim(data['xcode'][1]))
            html = html.replace('(xcode-2)', trim(data['xcode'][2]))
            html = html.replace('(code)', data['code'])
            html = html.replace('(iresend-0)', iresend[0])
            html = html.replace('(iresend-1)', iresend[1])
            html = html.replace('(iresend-2)', iresend[2])
            html = html.replace('(customer)', data['sender'])
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(address)', data['xaddress'])
            html = html.replace('(sample)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['samplecode'])
            html = html.replace('(ireceive)', data['receive'])
            html = html.replace('(target)', data['target'])

            if (data['owner']) {
              var x = '<div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thông tin mẫu: </div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chủ hộ: (owner)</div>  <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Nơi lấy mẫu: (sampleplace)</div>'
              x = x.replace('(sampleplace)', data['sampleplace'])
              x = x.replace('(owner)', data['owner'])
              html = html.replace('(owner)', x)
            }
            else {
              html = html.replace('(owner)', '')
            }

            var length = data['exam'].length
            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var parse = ''
            for (let i = 0; i < length; i++) {
              var temp = part 
              if (data['exams'].length > 1) {
                temp = temp.replace('(index)', i + 1 + '. ')
              }
              else {
                temp = temp.replace('(index)', '')
              }
              temp = temp.replace('(content)', data['exam'][i])
              temp = temp.replace('(method)', data['method'][i])
              temp = temp.replace('(symbol)', data['symbol'][i])
              parse += temp
            }
            html = html.replace('(parse)', parse)
            html = html.replace('(result)', tabbed + data['result'].replace(/\n/g, '<br>' + tabbed))
            var noteString = ''
            if (trim(data['note'])) {
              // (note)
              var note = data['note'].split('\n');
              var notes = []
              note.forEach(item => {
                notes.push('<i>' + item + '</i>')
              })
              noteString += '<u style="display: inline-block"><b>Ghi chú:</b></u> <div style="display: inline-table">' + notes.join('<br>') + '</div>'
            }
            html = html.replace('(note)', noteString)
            
            html = html.replace('(receivedis)', data['receivedis'].replace(/\n/g, '<br>'))
            html = html.replace('(receiveleader)', data['receiveleader'].toUpperCase())
          break;
        }
        
        var html = style + html
        var winPrint = window.open('', '', 'left=0,top=0,width=800,height=600,toolbar=0,scrollbars=0,status=0');
        winPrint.focus()
        winPrint.document.write(html);
        winPrint.print()
        winPrint.close()
      }
    }
  }
</script>
<!-- END: main -->
