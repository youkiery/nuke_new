<!-- BEGIN: main -->
<style>
  .top { right: 10px;}
  .toped { right: 50px;}
  .top2 { top: 45px; }
  .top3 { top: 80px; }
  .top4 { top: 115px; }
  .top5 { top: 150px; }
  .top6 { top: 185px; }
  .top7 { top: 220px; }
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
</style>

<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<div class="msgshow" id="msgshow"></div>

<div id="modal-locker" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
        <div class="text-center">
          <p>
            <b>
              bạn có chắc chắn muốn khóa bộ hồ sơ này không?
            </b>
          </p>
          <button class="btn btn-success" onclick="locker(1)">
            Có
          </button>
          <button class="btn btn-danger" onclick="locker(0)">
            Không
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="modal-print" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <button class="btn btn-info" onclick="savePrint()">
          <span class="glyphicon glyphicon-floppy-disk"></span>
        </button>
        <button class="btn btn-info" onclick="printXSubmit()">
          <span class="glyphicon glyphicon-print"></span>
        </button>
        <div id="print-content"></div>
      </div>
    </div>
  </div>
</div>

<div id="modal-print2" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <button class="btn btn-info" onclick="printX2Submit()">
          <span class="glyphicon glyphicon-print"></span>
        </button>
        <div class="form-group"></div>
        <div id="print2-content"></div>
      </div>
    </div>
  </div>
</div>

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
  <!-- BEGIN: user -->
  <li class="active xmenu" id="xhome"><a data-toggle="tab" href="#home"> Danh sách </a></li>
  <!-- END: user -->
  <!-- BEGIN: super_user -->
  <li class="xmenu" id="xmenu1"><a data-toggle="tab" href="#menu1"> Thêm văn bản </a></li>
  <!-- END: super_user -->
  <li class="{secretary_active} xmenu" id="xmenu2"><a data-toggle="tab" href="#menu2"> Xuất ra excel </a></li>
  <!-- BEGIN: secretary -->
  <li><a href="/{module_name}/lp1"> Kế toán </a></li>
  <!-- END: secretary -->
  <!-- BEGIN: printx -->
  <li class="xmenu" id="xmenu4"><a data-toggle="tab" href="#menu4"> Văn thư </a></li>
  <!-- END: printx -->
  <li><a href="/form/statistic"> Thống kê </a></li>
</ul>

<div class="tab-content">
  <!-- BEGIN: super_user2 -->
  <div id="home" class="tab-pane active">
    <form onsubmit="filter(event)">
      <div class="row form-group">
        <div class="col-sm-4">
          <input type="text" class="form-control" id="filter-keyword" placeholder="Mẫu phiếu" autocomplete="off">
        </div>
        <div class="col-sm-4">
          <input type="text" class="form-control" id="filter-xcode" placeholder="Số ĐKXN" autocomplete="off">
        </div>
        <div class="col-sm-4">
          <select class="form-control" id="filter-printer">
            <option value="1" selected>Mẫu 1</option>
            <option value="2">Mẫu 2</option>
            <option value="3">Mẫu 3</option>
            <option value="4">Mẫu 4</option>
            <option value="5">Mẫu 5</option>
          </select>
        </div>
        <div class="col-sm-4">
          <select class="form-control" id="filter-limit">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="75">75</option>
            <option value="100">100</option>
          </select>
        </div>
        <div class="col-sm-4">
          <input type="text" class="form-control" id="filter-unit" placeholder="Đơn vị">
        </div>
      </div>
      <div class="form-group row">
        <div class="col-sm-4">
          <input type="text" class="form-control" id="filter-owner" placeholder="Chủ hộ">
        </div>

        <div class="col-sm-4">
          <input type="text" class="form-control" id="filter-exam" placeholder="Kết quả xét nghiệm">
        </div>

        <div class="col-sm-4">
          <input type="text" class="form-control" id="filter-sample" placeholder="Loại động vật">
        </div>
        <div class="col-sm-4">
          <input type="text" class="form-control" id="filter-from" value="{last_week}">
        </div>
  
        <div class="col-sm-4">
          <input type="text" class="form-control" id="filter-end" value="{today}">
        </div>

      </div>      
      

      <div class="text-center">
        <button class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
      </div>
    </form>
    <button class="btn btn-info" onclick="summary()"> Tổng kết </button>
    <div id="content">
      {content}
    </div>
  </div>
  <!-- END: super_user2 -->
  
  <!-- BEGIN: super_user3 -->
  <div id="menu1" class="tab-pane">
    <div id="credit"></div>
    <div class="row form-group boxed box-1 box-1-1">
      <label class="col-sm-6">Số phiếu</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-code" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-5 box-5-1">
      <div class="row form-group">
        <label class="col-sm-6"> Khóa văn bản </label>
        <div class="col-sm-12">
          <button class="btn btn-info" id="locker_button" onclick="$('#modal-locker').modal('show')">
            <span class="glyphicon glyphicon-lock"></span>
          </button>
          <input type="hidden" id="signer_locker">
          <div id="signer_locking"> </div>
        </div>
      </div>

      <div class="row form-group">
        <label class="col-sm-6">Số phiếu</label>
        <div class="col-sm-12">
          <input type="text" class="form-control" id="form-insert-mcode" autocomplete="off">
        </div>
      </div>
    </div>

    <div class="row form-group boxed box-6">
      <label class="col-sm-6"> Người đề nghị </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-reformer" autocomplete="off">
      </div>
    </div>
    
    <div class="row form-group boxed box-6">
      <label class="col-sm-6"> Nội dung công việc </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-content" autocomplete="off">
      </div>
    </div>
    
    <div class="row form-group boxed box-2 box-2-1 box-3 box-3-1 box-4 box-4-1 box-5 box-5-21">
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

    <div class="row form-group boxed box-1 box-1-2 box-5 box-5-3">
      <label class="col-sm-6">
        Tên đơn vị - khách hàng
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="sender-employ-0" autocomplete="off">
        <div class="suggest" id="sender-employ-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-15">
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

    <div class="row form-group boxed box-1 box-1-3 box-4 box-4-16 box-5 box-5-17">
      <label class="col-sm-6">Ngày nhận mẫu</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-receive" autocomplete="off">
      </div>
    </div>
    
    <div class="row form-group boxed box-1 box-1-4">
      <label class="col-sm-6">Ngày hẹn trả kết quả</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-resend" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-2">
      <label class="col-sm-6"> Ngày thông báo kết quả </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-notice-time" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-13 box-5 box-5-16">
      <label class="col-sm-6">
        Ngày lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sample-receive" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-14">
      <label class="col-sm-6">
        Người lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="sample-receiver-0" autocomplete="off">
        <div class="suggest" id="sample-receiver-suggest-0"></div>
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
        <input type="text" class="form-control" id="receiver-employ-0" autocomplete="off">
        <div class="suggest" id="receiver-employ-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-7">
      <label class="col-sm-6">Ngày nhận</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-ireceive" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-8 box-2 box-2-7">
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

    <div class="row form-group boxed box-2 box-2-3 box-4 box-4-3">
      <label class="col-sm-6">
        Bộ phận giao mẫu - Khách hàng yêu cầu xét nghiệm
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="isender-unit-0" autocomplete="off">
        <div class="suggest" id="isender-unit-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-4">
      <label class="col-sm-6">
        Địa chỉ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="address-0" autocomplete="off">
        <div class="suggest" id="address-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-4">
      <label class="col-sm-6">
        Địa chỉ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="xaddress-0" autocomplete="off">
        <div class="suggest" id="xaddress-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-7">
      <label class="col-sm-6">
        Chủ hộ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="owner-0" autocomplete="off">
        <div class="suggest" id="owner-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-8">
      <label class="col-sm-6">
        Nơi lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="sample-place-0" autocomplete="off">
        <div class="suggest" id="sample-place-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-6">
      <label class="col-sm-6">
        Điện thoại
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="ownerphone-0" autocomplete="off">
        <div class="suggest" id="ownerphone-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-5">
      <label class="col-sm-6">
        Email
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="ownermail-0" autocomplete="off">
        <div class="suggest" id="ownermail-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-17">
      <label class="col-sm-6">
        Người nhận mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="ireceiver-employ-0" autocomplete="off">
        <div class="suggest" id="ireceiver-employ-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-4">
      <label class="col-sm-6">
        Bộ phận nhận mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="ireceiver-unit-0" autocomplete="off">
        <div class="suggest" id="ireceiver-unit-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-5">
      <label class="col-sm-6">
        Số điện thoại
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="xphone-0" autocomplete="off">
        <div class="suggest" id="xphone-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-6">
      <label class="col-sm-6">
        fax
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="fax-0" autocomplete="off">
        <div class="suggest" id="fax-suggest-0"></div>
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-10 box-4 box-4-9 box-5 box-5-11">
      <label class="col-sm-6"> Số lượng mẫu nhận </label>
      <div class="col-sm-12">
        <input type="number" class="form-control" id="form-insert-number" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-11 box-4 box-4-10 box-5 box-5-12">
      <label class="col-sm-6"> Số lượng mẫu nhận (Chữ) </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-number-word" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-5 box-5-13">
      <label class="col-sm-6"> Số lượng mẫu đạt yêu cầu </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-examsample" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-1 box-1-12 box-4 box-4-8 box-5 box-5-10">
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

    <div class="form-group row boxed box-1 box-1-13 box-4 box-4-7 box-5 box-5-9">
      <label class="col-sm-6"> Loài vật được lấy mẫu </label>
      <div class="col-sm-12 relative">
        <input type="text" class="form-control sample" id="sample-0" autocomplete="off">
        <div class="suggest" id="sample-suggest-0"></div>
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-14">
      <label class="col-sm-6"> Ký hiệu mẫu </label>
      <div class="col-sm-12" id="form-insert-sample-parent">
        <input type="text" class="form-control" id="form-insert-sample-code" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-4 box-4-11 box-5 box-5-14">
      <label class="col-sm-6"> Ký hiệu mẫu </label>
      <div class="col-sm-12" id="form-insert-sample-parent">
        <input type="text" class="form-control" id="form-insert-sample-code-5" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-4 box-4-12">
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

    <div class="boxed box-1 box-1-15 box-4 box-4-18 box-5 box-5-18 bordered">
      <label>
        Yêu cầu xét nghiệm
        <button class="btn btn-success" onclick="insertMethod()"> <span class="glyphicon glyphicon-plus"></span> </button>
      </label>
      <div id="form-insert-request"></div>
    </div>

    <div class="row form-group boxed box-1 box-1-16">
      <label class="col-sm-6">
        Ghi chú
      </label>
      <div class="col-sm-12">
        <textarea class="form-control" id="form-insert-xnote" autocomplete="off"></textarea>
      </div>
    </div>

    <div class="boxed box-2 box-2-8 box-5 box-5-20 box-4 box-4-22">
      <div class="row form-group">
        <label class="col-sm-6">
          Kết quả
        </label>
        <div class="col-sm-12">
          <div id="insert-result"></div>
          <button class="btn btn-info" onclick="insertResult()">
            <span class="glyphicon glyphicon-plus"></span>
          </button>
        </div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-19 box-4 box-4-20">
      <label class="col-sm-6">
        Ghi chú
      </label>
      <div class="col-sm-12">
        <textarea type="text" class="form-control" id="form-insert-note"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-15">
      <label class="col-sm-6">
        Ghi chú
      </label>
      <div class="col-sm-12">
        <textarea type="text" class="form-control" id="form-insert-cnote"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-6 box-4 box-4-21">
      <label class="col-sm-6">
        Ngày phân tích
      </label>
      <div class="col-sm-6">
        <input type="text" class="form-control date" id="form-insert-exam-date" autocomplete="off">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control date" id="form-insert-exam-date-2" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-22">
      <label class="col-sm-6">
        Nơi nhận
      </label>
      <div class="col-sm-12">
        <textarea type="text" class="form-control" id="form-insert-receive-dis"></textarea>
      </div>
    </div>

    <div class="boxed box-5 box-5-23">
      <div class="row form-group">
        <label class="col-sm-6">
          Người phụ trách
        </label>
        <div class="col-sm-12 relative">
          <input type="text" class="form-control" id="receive-leader-0" autocomplete="off">
          <div class="suggest" id="receive-leader-suggest-0"></div>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-sm-6"> Chữ ký </label>
        <div class="col-sm-12 relative" id="signer_receiveleader">
        </div>
      </div>
      <div class="row form-group">
        <label class="col-sm-6"> Người ký thay </label>
        <div class="col-sm-12 relative">
          <input type="checkbox" id="signer_xsign">
        </div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-15">
      <label class="col-sm-6">
        Mục đích xét nghiệm
      </label>
      <div class="col-sm-12">
        <textarea type="text" class="form-control" id="form-insert-target" autocomplete="off"></textarea>
      </div>
    </div>

    <div class="boxed box-2 box-2-5 box-3 box-3-5 html-sample" id="sample">
      
    </div>

    <div class="row form-group boxed box-3 box-3-7">
      <label class="col-sm-6"> Ghi chú </label>
      <div class="col-sm-12">
        <textarea id="form-insert-vnote" class="form-control"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-2">
      <label class="col-sm-6"> Số trang </label>
      <div class="col-sm-12">
        <input type="text" id="form-insert-page2" class="form-control" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-3 box-3-2">
      <label class="col-sm-6"> Số trang </label>
      <div class="col-sm-12">
        <input type="text" id="form-insert-page3" class="form-control" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-2">
      <label class="col-sm-6"> Số trang </label>
      <div class="col-sm-12">
        <input type="text" id="form-insert-page4" class="form-control" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-3 box-3-8 box-4 box-4-23">
      <div class="row form-group">
        <label class="col-sm-6"> Bộ phận xét nghiệm </label>
        <div class="col-sm-12 relative">
          <input type="text" id="xexam-0" class="form-control" autocomplete="off">
          <div class="suggest" id="xexam-suggest-0"></div>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-sm-6"> Chữ ký </label>
        <div class="col-sm-12 relative" id="signer_xexam">
        </div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-9">
      <label class="col-sm-6"> Ngày giao mẫu </label>
      <div class="col-sm-12">
        <input type="text" id="form-insert-xsend" class="form-control" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-2 box-2-10">
      <div class="row form-group">
        <label class="col-sm-6"> Người giao mẫu </label>
        <div class="col-sm-12 relative">
          <input type="text" id="xsender-0" class="form-control" autocomplete="off">
          <div class="suggest" id="xsender-suggest-0"></div>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-sm-6"> Chữ ký </label>
        <div class="col-sm-12 relative" id="signer_xsender">
        </div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-11">
      <label class="col-sm-6"> Ngày nhận mẫu </label>
      <div class="col-sm-12">
        <input type="text" id="form-insert-xreceive" class="form-control" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-2 box-2-12">
      <div class="row form-group">
        <label class="col-sm-6"> Người nhận mẫu </label>
        <div class="col-sm-12 relative">
          <input type="text" id="xreceiver-0" class="form-control" autocomplete="off">
          <div class="suggest" id="xreceiver-suggest-0"></div>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-sm-6"> Chữ ký </label>
        <div class="col-sm-12 relative" id="signer_xreceiver">
        </div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-13">
      <label class="col-sm-6"> Ngày giao kết quả </label>
      <div class="col-sm-12">
        <input type="text" id="form-insert-xresend" class="form-control" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-2 box-2-14 box-3 box-3-9 box-4 box-4-24">
      <div class="row form-group">
        <label class="col-sm-6"> Người phụ trách bộ phận xét nghiệm </label>
        <div class="col-sm-12 relative">
          <input type="text" class="form-control" id="xresender-0" autocomplete="off">
          <div class="suggest" id="xresender-suggest-0"></div>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-sm-6"> Chữ ký </label>
        <div class="col-sm-12 relative" id="signer_xresender">
        </div>
      </div>
    </div>
    <!-- BEGIN: p1 -->
    <button class="btn btn-info saved float-button top top{top}" id="saved-2-1" onclick="printer(1)">
      <span class="glyphicon glyphicon-print"></span>
    </button>
    <button class="btn btn-warning saved float-button toped top{top}" id="saved-1-1" onclick="parseBox(1)">
      Mẫu 1
    </button>
    <!-- END: p1 -->
    
    <!-- BEGIN: p2 -->
    <button class="btn btn-info saved float-button top top{top}" id="saved-2-2" onclick="printer(2)">
      <span class="glyphicon glyphicon-print"></span>
    </button>
    <button class="btn btn-warning saved float-button toped top{top}" id="saved-1-2" onclick="parseBox(2)">
      Mẫu 2
    </button>
    <!-- END: p2 -->

    <!-- BEGIN: p3 -->
    <button class="btn btn-info saved float-button top top{top}" id="saved-2-3" onclick="printer(3)">
      <span class="glyphicon glyphicon-print"></span>
    </button>
    <button class="btn btn-warning saved float-button toped top{top}" id="saved-1-3" onclick="parseBox(3)">
      Mẫu 3
    </button>
    <!-- END: p3 -->

    <!-- BEGIN: p4 -->
    <button class="btn btn-info saved float-button top top{top}" id="saved-2-4" onclick="printer(4)">
      <span class="glyphicon glyphicon-print"></span>
    </button>
    <button class="btn btn-warning saved float-button toped top{top}" id="saved-1-4" onclick="parseBox(4)">
      Mẫu 4
    </button>
    <!-- END: p4 -->

    <!-- BEGIN: p5 -->
    <button class="btn btn-info saved float-button top top{top}" id="saved-2-5" onclick="printer(5)">
      <span class="glyphicon glyphicon-print"></span>
    </button>
    <button class="btn btn-warning saved float-button toped top{top}" id="saved-1-5" onclick="parseBox(5)">
      Mẫu 5
    </button>
    <!-- END: p5 -->

    <button class="btn btn-success float-button toped top{top}" onclick="insertSubmit()"> Lưu </button>

    <button class="btn btn-info saved-0 float-button top top{top}" onclick="newForm()">
      <span class="glyphicon glyphicon-file"></span>
    </button>
  </div>
  <!-- END: super_user3 -->
  <div id="menu2" class="tab-pane {secretary_active}">
    <label class="row" style="width: 100%;">
      <div class="col-sm-6">Ngày bắt đầu</div>
      <div class="col-sm-12">
        <input type="text" value="{excelf}" class="form-control" id="excelf">
      </div>
    </label>

    <label class="row" style="width: 100%;">
      <div class="col-sm-6">Ngày kết thúc</div>
      <div class="col-sm-12">
        <input type="text" value="{excelt}" class="form-control" id="excelt">
      </div>
    </label>
    <!-- khách hàng, địa chỉ, email, điện thoại, chỉ hộ, nơi lấy mẫu, mục đích, nơi nhận, người phụ trách --> 
    <label style="width: 30%"> <input type="checkbox" class="po" id="index" checked> STT </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="set" checked> Kết quả xét nghiệm </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="code"> Số phiếu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="sender"> Tên đơn vị </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="receive"> Ngày nhận mẫu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="resend"> Ngày hẹn trả kết quả </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="status"> Hình thức nhận </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="ireceiver"> Người nhận hồ sơ </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="ireceive"> Ngày nhận hồ sơ </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="iresend"> Ngay trả hồ sơ </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="number"> Số lượng mẫu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="sampletype"> Loại mẫu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="sample"> Loài vật lấy mẫu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="xcode"> Số ĐKXN </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="isenderunit"> Bộ phận giao mẫu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="ireceiverunit"> Bộ phận nhận mẫu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="examdate"> Ngày phân tích </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="xresender"> Người phụ trách bộ phận xét nghiệm </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="xexam"> Bộ phận xét nghiệm </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="examsample"> Lượng mẫu xét nghiệm </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="receiver"> Người lấy mẫu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="samplereceive"> Thời gian lấy mẫu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="senderemploy"> Khách hàng </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="xaddress"> Địa chỉ </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="ownermail"> Email </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="ownerphone"> Điện thoại </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="owner"> Chủ hộ </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="sampleplace"> Nơi lấy mẫu </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="target"> Mục đích </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="receivedis"> Nơi nhận </label>
    <label style="width: 30%"> <input type="checkbox" class="po" id="receiveleader"> Người phụ trách </label>
    <div class="text-center">
      <button class="btn btn-info" onclick="download()">
        Xuất ra Excel
      </button>
    </div>
  </div>
  <!-- BEGIN: secretary2 -->
  <!-- <div id="menu3" class="tab-pane {secretary_active}">
    <form onsubmit="secretaryFilter(event)">
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

    <button class="btn btn-info" style="float: right;" onclick="selectRow(this)">
      <span class="glyphicon glyphicon-unchecked"></span>
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
  </div> -->
  <!-- END: secretary2 -->

  <!-- BEGIN: printx2 -->
  <div id="menu4" class="tab-pane">
    <form onsubmit="secretaryFilter2(event)">
      <div class="row form-group">
        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter2-keyword" placeholder="Số thông báo" autocomplete="off">
        </div>
        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter2-xcode" placeholder="Số ĐKXN" autocomplete="off">
        </div>
        <div class="col-sm-4">
          <select class="form-control" id="sfilter2-limit">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="75">75</option>
            <option value="100" selected>100</option>
          </select>
        </div>
        <div class="col-sm-4">
          <select class="form-control" id="sfilter2-pay">
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
          <input type="text" class="form-control" id="sfilter2-unit" placeholder="Đơn vị">
        </div>
        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter2-exam" placeholder="Kết quả xét nghiệm">
        </div>
      </div>
      <div class="form-group row">
        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter2-owner" placeholder="Chủ hộ">
        </div>

        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter2-sample" placeholder="Loại động vật">
        </div>

        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter2-from" value="{today}">
        </div>

        <div class="col-sm-4">
          <input type="text" class="form-control" id="sfilter2-end" value="{today}">
        </div>
      </div>

      <div class="text-center">
        <button class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
      </div>
    </form>

    <button class="btn btn-info" style="float: right;" onclick="printX2()">
      <img src="/assets/images/letter.png" style="width: 15px; height: 15px;">
      <!-- <span class="glyphicon glyphicon-file"></span> -->
    </button>  
    <button class="btn btn-info" style="float: right;" onclick="printX()">
      <span class="glyphicon glyphicon-print"></span>
    </button>  

    <div style="clear: both;"></div>

    <div id="secretary2-list">
      {printx}
    </div>
  </div>
  <!-- END: secretary2 -->

<script src="/modules/core/js/vhttp.js"></script>
<script>
  var style = '.table-bordered {border-collapse: collapse;}.table-wider td, .table-wider th {padding: 10px;}table {width: 100%;}table td {padding: 5px;}.no-bordertop {border-top: 1px solid white; }.no-borderleft {border-left: 1px solid white; }.c20, .c25, .c30, .c35, .c40, .c45, .c50, .c80 {display: inline-block;}.c20 {width: 19%;}.c25 {width: 24%;}.c30 {width: 29%;}.c35 {width: 34%;}.c40 {width: 39%;}.c45 {width: 44%;}.c50 {width: 49%;}.c80 {width: 79%;}.p11 {font-size: 11pt}.p12 {font-size: 12pt}.p13 {font-size: 13pt}.p14 {font-size: 14pt}.p15 {font-size: 15pt}.p16 {font-size: 16pt}.text-center, .cell-center {text-align: center;}.cell-center {vertical-align: inherit;} p {margin: 5px 0px;}'
  var profile = ['@media print { @page { size: A4 portrait; margin: 20mm 10mm 10mm 25mm; } .pagebreak { clear: both; page-break-after: always; } }', '@media print { @page { size: A4 landscape; margin: 20mm 10mm 10mm 25mm;} .pagebreak { clear: both; page-break-after: always; } }']
  var former = {
    1: `{form1}`,
    2: `{form2}`,
    3: `{form3}`,
    4: `{form4}`,
    5: `{form5}`,
  }
  
  var credit = $("#credit")
  var menu1 = $("#menu1")
  var content = $("#content")
  var secretary = $("#secretary")
  var secretaryList = $("#secretary-list")
  var secretaryList2 = $("#secretary2-list")
  var formRemove = $("#form-remove")

  var formInsertSenderEmploy = $("#sender-employ-0")
  var formInsertReceiverEmploy = $("#receiver-employ-0")
  var formInsertIreceiverEmploy = $("#ireceiver-employ-0")
  var formInsertXaddress = $("#xaddress-0")
  var formInsertOwner = $("#owner-0")
  var formInsertSamplePlace = $("#sample-place-0")
  var formInsertXphone = $("#xphone-0")
  var formInsertFax = $("#fax-0")
  var formInsertXresender = $("#xresender-0")
  var formInsertXsender = $("#xsender-0")
  var formInsertXreceiver = $("#xreceiver-0")
  var formInsertIsenderUnit = $("#isender-unit-0")
  var formInsertIreceiverUnit = $("#ireceiver-unit-0")
  var formInsertSampleReceiver = $("#sample-receiver-0")
  var formInsertAddress = $("#address-0")
  var formInsertXexam = $("#xexam-0")
  var formInsertOwnerPhone = $("#ownerphone-0")
  var formInsertOwnerMail = $("#ownermail-0")

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
  var formInsertSample = $("#sample-0")
  var formInsertStatus = $("#form-insert-status")
  var formInsertSampleCode = $("#form-insert-sample-code")
  var formInsertSampleParent = $("#form-insert-sample-parent")
  var formInsertOther = $("#form-insert-other")
  var formInsertResult = $("#form-insert-result") 
  var formInsertTypeOther = $("#form-insert-type-other") 

  var formInsertSampleReceive = $("#form-insert-sample-receive")
  var formInsertSampleTime = $("#form-insert-sample-time")

  var formInsertPhone = $("#form-insert-phone")

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
  var formInsertCnote =  $("#form-insert-cnote")
  var formInsertReceiveDis = $("#form-insert-receive-dis")
  var formInsertReceiveLeader = $("#receive-leader-0")
  var formInsertAttach = $("#form-insert-attach")
  var formInsertXnote = $("#form-insert-xnote")
  var formInsertPage2 = $("#form-insert-page2")
  var formInsertPage3 = $("#form-insert-page3")
  var formInsertPage4 = $("#form-insert-page4")

  var formInsertXresend = $("#form-insert-xresend")
  var formInsertXsend = $("#form-insert-xsend")
  var formInsertXreceive = $("#form-insert-xreceive")
  var formInsertVnote = $("#form-insert-vnote")
  var formInsertExamSample = $("#form-insert-examsample")
  var formInsertSampleCode5 = $("#form-insert-sample-code-5")
  var formInsertMcode = $("#form-insert-mcode")

  var formSummary = $("#form-summary")
  var formSummaryFrom = $("#form-summary-from")
  var formSummaryEnd = $("#form-summary-end")
  var formSummaryContent = $("#form-summary-content")
  var formSummaryUnit = $("#form-summary-unit")
  var formSummarySample = $("#form-summary-sample")
  var formSummaryExam = $("#form-summary-exam")
  var formInsertNoticeTime = $("#form-insert-notice-time")
  var sample = $("#sample")

  var excelf = $("#excelf")
  var excelt = $("#excelt")

  var filterXcode = $("#filter-xcode")
  var filterUnit = $("#filter-unit")
  var filterExam = $("#filter-exam")
  var filterSample = $("#filter-sample")
  var filterOwner = $("#filter-owner")
  var filterFrom = $("#filter-from")
  var filterEnd = $("#filter-end")

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

  var sfilter2Keyword = $("#sfilter2-keyword")
  var sfilter2Xcode = $("#sfilter2-xcode")
  var sfilter2Limit = $("#sfilter2-limit")
  var sfilter2Unit = $("#sfilter2-unit")
  var sfilter2Exam = $("#sfilter2-exam")
  var sfilter2Sample = $("#sfilter2-sample")
  var sfilter2Pay = $("#sfilter2-pay")
  var sfilter2Owner = $("#sfilter2-owner")
  var sfilter2From = $("#sfilter2-from")
  var sfilter2End = $("#sfilter2-end")

  var global_html = {}
  var global_form = 1
  var global_saved = 0
  var global_id = 0
  var global_page = 1
  var global_printer = 1
  var global_ig = []
  var global_clone = 0
  var permist = "{permist}".split(',')
  var defaultData = JSON.parse(`{default}`)

  var ticked = ['Đạt', 'Không đạt']
  var methodModal = $("#method-modal")
  var formInsert = $('#form-insert')
  var toggle = 1
  var global_secretary = 0
  var spage = 1

  var visible = {
    // "-1": {1: '6', 2: '6'},
    0: {1: '1', 2: '1'},
    1: {1: '1, 2', 2: '1, 2'},
    2: {1: '1, 2, 3', 2: '1, 2, 3'},
    3: {1: '1, 2, 3, 4', 2: '1, 2, 3, 4'},
    4: {1: '1, 2, 3, 4, 5', 2: '1, 2, 3, 4, 5'},
    5: {1: '1, 2, 3, 4, 5', 2: '1, 2, 3, 4, 5'}
  }
  var dataPicker = {'form': 1, 'result': 3}
  var rdataPicker = {'1': 'form', 3: 'result'}
  var infoData = {1: [], 2: [], 3: []}
  var remindData = {}
  var today = '{today}'
  var global_field = [{
    code: '',
    type: '',
    number: 1,
    status: 0,
    mainer: [{
      main: '',
      method: '',
      note: [{
        result: '',
        note: ''
      }]
    }]
  }]
  var global_exam = [{
    method: '',
    symbol: '',
    exam: ['']
  }]
  var global = {
    result: [],
    select: false,
    signer: JSON.parse('{signer}'),
    secretary: {
      page: 1
    },
    secretary2: {
      page: 1
    },
    signdata: [
      {
        name: 'xsender',
        id: 'signer_xsender',
        form: 2
      },
      {
        name: 'xreceiver',
        id: 'signer_xreceiver',
        form: 2
      },
      {
        name: 'xresender',
        id: 'signer_xresender',
        form: 2
      },
      {
        name: 'xexam',
        id: 'signer_xexam',
        form: 3
      },
      {
        name: 'receiveleader',
        id: 'signer_receiveleader',
        form: 5
      }
    ]
  }

  $(this).ready(() => {
    htmlInfo = formInsertInfo.html()
    var x = strHref.split("#")[1]
    if (x) {
      $('[href="#'+ x +'"]').tab('show');
    }

    addInfo(1)
    // addInfo(3)
    installRemindv2('0', 'xsender');
    installRemindv2('0', 'xreceiver');
    installRemindv2('0', 'xresender');
    installRemindv2('0', 'xexam');
    installRemindv2('0', 'xphone');
    installRemindv2('0', 'fax');
    installRemindv2('0', 'ownerphone');
    installRemindv2('0', 'ownermail');
    installRemindv2('0', 'sample');
    installRemindv2('0', 'sender-employ');
    installRemindv2('0', 'receiver-employ');
    installRemindv2('0', 'ireceiver-employ');
    installRemindv2('0', 'ireceiver-unit');
    installRemindv2('0', 'isender-unit');
    installRemindv2('0', 'sample-receiver');
    installRemindv2('0', 'address');
    installRemindv2('0', 'xaddress');
    installRemindv2('0', 'owner');
    installRemindv2('0', 'sample-place');
    installRemindv2('0', 'receive-leader');
    installSelect()
    // installExamRemind()
    parseField(global_field)
    parseExam(global_exam)        
    parseBox(1)
    parseSaved()
  })

  $("#form-insert-receive, #form-insert-resend, #form-insert-ireceive, #form-insert-iresend, #form-insert-sample-receive, #form-insert-sample-time, #form-summary-from, #form-summary-end, #form-insert-notice-time, #form-insert-xresend, #form-insert-xreceive, #form-insert-xsend, #excelf, #excelt, #filter-from, #filter-end, #sfilter-from, #sfilter-end, #sfilter2-from, #sfilter2-end, .date").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function installSelect() {
    $("tbody").click((e) => {
      var current = e.currentTarget
      if (global['select']) {
        if (current.className == 'select') {
          global['select'].forEach((element, index) => {
            if (element == current) {
              global['select'].splice(index, 1)
            }
          });
          current.className = ''
        }
        else {
          global['select'].push(current)
          current.className = 'select'
        }
      }
    })
  }

  function selectRow(button) {
    if (global['select']) {
      button.children[0].className = 'glyphicon glyphicon-unchecked'
      $(".select-button").prop('disabled', true)
      global['select'].forEach(item => {
        item.className = ''
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
      var list = []
      global['select'].forEach((item, index) => {
        list.push(item.getAttribute('id'))
      })
      freeze()
      $.post(
        global['url'],
        {action: 'change-pay', list: list, type: status, page: global['secretary']['page'], filter: getSecretaryFilter()},
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

  function printX() {
    var list = []
    $('.check:checked').each((index, item) => {
      list.push(item.getAttribute('id'))
    })

    if (list.length) {
      freeze()
      $.post(
        '',
        {action: 'print-x-list', list: list},
        (response, status) => {
          checkResult(response, status).then(data => {  
            $("#print-content").html(data['html'])
            $("#modal-print").modal('show')
          }, () => {})
        }
      )
    }    
  }

  function printX2() {
    var list = []
    $('.check:checked').each((index, item) => {
      list.push(item.getAttribute('id'))
    })

    if (list.length) {
      freeze()
      $.post(
        '',
        {action: 'print-x2-list', list: list},
        (response, status) => {
          checkResult(response, status).then(data => {  
            $("#print2-content").html(data['html'])
            $("#modal-print2").modal('show')
          }, () => {})
        }
      )
    }    
  }

  function printX2Submit() {
    var winPrint = window.open(origin, '_blank', 'left=0,top=0,width=800,height=600');
    winPrint.focus()
    winPrint.document.write($("#print2-content").html());
    setTimeout(() => {
      winPrint.print()
      winPrint.close()
    }, 300)
  }

  function printXSubmit() {
    var list = []
    $('.check:checked').each((index, item) => {
      list.push(item.getAttribute('id'))
    })

    if (list.length) {
      freeze()
      $.post(
        global['url'],
        {action: 'print-x', list: list},
        (response, status) => {
          checkResult(response, status).then(data => {  
            var winPrint = window.open(origin, '_blank', 'left=0,top=0,width=800,height=600');
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

  function savePrint() {
    var list = []
    $('.check:checked').each((index, item) => {
      var id = item.getAttribute('id')
      list.push({
        id: id,
        customer: $('#print-customer-'+ id).val(),
        address: $('#print-address-'+ id).val(),
        mobile: $('#print-mobile-'+ id).val(),
      })
    })

    if (list.length) {
      freeze()
      $.post(
        global['url'],
        {action: 'save-print', data: list},
        (response, status) => {
          checkResult(response, status).then(data => {  
            alert_msg('Đã lưu')
          }, () => {})
        }
      )
    }
  }

  function getSavePrintData(id) {
    return {
      customer: $("#print-customer-" + id).val(),
      address: $("#print-address-" + id).val(),
      mobile: $("#print-mobile-" + id).val(),
      fax: $("#print-fax-" + id).val(),
      mail: $("#print-mail-" + id).val()
    }
  }

  function installSigner(id, selectid = 0) {
    var html = ''
    global['signer'].forEach((signer, signerid) => {
      var check = ''
      if (signerid == selectid) {
        check = 'selected'
      }
      html += `
      <option value="`+signerid+`" `+check+`>
        `+ signer['name'] +`
      </option>`   
    })
    html = `
    <select class="form-control" id="signer_`+id+`">
      `+ html +`
    </select>
    `
    $('#' + id).html(html)
  }

  function checkSimilarSigner(data) {
    for (const signerKey in data) {
      if (data.hasOwnProperty(signerKey)) {
        var key = signerKey.replace('-', '')        
        var count = -1
        global['signer'].forEach((signer, signerIndex) => {
          if (signer['name'] == defaultData['remind'][signerKey]) {
            data[signerKey] = signerIndex
          }
        })
      }
    }

    return data
  }

  function installSignerTemplate(data = 0) {
    if (!data) {
      data = {'xsender': 1, 'xreceiver': 0, 'xresender': 0, 'xexam': 0, 'receiveleader': 0}
      data = checkSimilarSigner(data)
    }
    global['signdata'].forEach(signData => {
      if ((global_saved + 1) >= signData['form']) {
        installSigner(signData['id'], data[signData['name']])  
      }
    })
  }

  function checkSigner() {
    var data = {}
    global['signdata'].forEach(signData => {
      if ((global_saved + 1) >= signData['form']) {
        data[signData['name']] = $('#signer_' + signData['id']).val()
      }
    })
    return data
  }

  function checkExcel() {
    var list = []
    $('.po').each((index, checkbox) => {
      if (checkbox.checked) {
        list.push(checkbox.getAttribute('id'))
      }
    })
    return list
  }

	function download() {
		var link = '/index.php?' + nv_name_variable + '=' + nv_module_name + '&excel=1&excelf=' + excelf.val() + '&excelt=' + excelt.val() + '&data=' + (checkExcel().join(','))
		window.open(link)
	}

  function parseBox(index) {
    if (visible[global_saved][1].search(index) >= 0) {
      global_form = index
      parseForm(index)
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

  function parseExam(data) {
    var installer = []
    var html = ''
    var mainIndex = -1
    data.forEach(main => {
      var temp = ''
      var examIndex = -1
      mainIndex ++
      main['exam'].forEach(exam => {
        examIndex ++
        temp += 
        `<div class="row">
          <button type="button" class="close" data-dismiss="modal" onclick="splitExam(\'0-`+ mainIndex +`-`+ examIndex +`\')">&times;</button>
          <label class="col-sm-4"> Yêu cầu </label>
          <div class="col-sm-12 relative">
            <input type="text" value="`+ exam +`" class="form-control input-box exam examed iex iex-exam-` + mainIndex + `-`+ examIndex +`" id="exam-`+ mainIndex +`-`+ examIndex +`" style="float: none;" autocomplete="off">
            <div class="suggest exam-suggest" id="exam-suggest-`+ mainIndex +`-`+ examIndex +`"> </div>
          </div>
        </div>`
        installer.push({
          name: mainIndex +`-`+ examIndex,
          type: 'exam'
        })
      })
      if (examIndex == -1) examIndex = 0
      if (mainIndex == -1) mainIndex = 0
      temp += '<button class="btn btn-success" onclick="splitExam(\'1-'+ mainIndex +'-'+ examIndex +'\')"><span class="glyphicon glyphicon-plus"></span></button>'
      
      html += `
      <div class="examed bordered">
        <button type="button" class="close" data-dismiss="modal" onclick="splitExam(\'0-`+ mainIndex +`\')">&times;</button>
        <div class="row">
          <label class="col-sm-4"> Phương pháp </label>
          <div class="col-sm-12 relative">
            <input type="text" value="`+ main['method'] +`" class="form-control input-box method iex iex-method-` + mainIndex + `" id="method-` + mainIndex + `" style="float: none;" autocomplete="off">
            <div class="suggest" id="method-suggest-` + mainIndex + `"> </div>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-4"> Ký hiệu </label>
          <div class="col-sm-12 relative">
            <input type="text" value="`+ main['symbol'] +`" class="form-control input-box symbol iex iex-symbol-` + mainIndex + `" id="symbol-` + mainIndex + `" style="float: none;" autocomplete="off">
            <div class="suggest" id="symbol-suggest-` + mainIndex + `"> </div>
          </div>
        </div>
        `+ temp +`
      </div>
      <button class="btn btn-success" onclick="splitExam(\'1-`+ mainIndex +`\')"><span class="glyphicon glyphicon-plus"></span></button>`
      installer.push({
        name: mainIndex,
        type: 'method'
      })
      installer.push({
        name: mainIndex,
        type: 'symbol'
      })
    })
    formInsertRequest.html(html)
    installer.forEach(item => {
      installRemindv2(item['name'], item['type'])
    })
  }

  function getExam() {
    list = []
    data = []
    $(".iex").each((index, item) => {
      list.push()
      className = item.getAttribute('class')
      var start = className.indexOf('iex-')
      var end = className.indexOf(' ', start)
      if (end < 0) {
        var pos = className.slice(start + 4) 
      }
      else {
        var pos = className.slice(start + 4, end) 
      }

      if (pos) {
        var poses = pos.split('-')
        var posesCount = poses.length
        switch (posesCount) {
          case 2:
            if (!data[poses[1]]) {
              data[poses[1]] = {}
            }
            data[poses[1]][poses[0]] = $(".iex-" + pos).val()
          break;
          case 3:
            if (!data[poses[1]]) {
              data[poses[1]] = {}
            }
            if (!data[poses[1]]['exam']) {
              data[poses[1]]['exam'] = []
            }
            data[poses[1]]['exam'][poses[2]] = $(".iex-" + pos).val()
          break;
        }
      }
    })
    return data
  }

  function splitExam(indexString) {
    var indexes = indexString.split('-')
    var indexCount = indexes.length
    indexes[0] = Number(indexes[0])
    global_exam = getExam()
    if (indexes[0]) {
      // insert
      if (indexes[2]) {
        global_exam[indexes[1]]['exam'].splice(indexes[2] + 1, 0, '')
      }
      else {
        global_exam.splice(indexes[1] + 1, 0, {method: '', symbol: '', exam: ['']})
      }
    }
    else {
      // remove
      if (indexes[2]) {
        global_exam[indexes[1]]['exam'].splice(indexes[2], 1)
      }
      else {
        global_exam.splice(indexes[1], 1)
      }
    }
    parseExam(global_exam)
  }

  function getFilter() {
    var data = {
      unit: filterUnit.val(),
      exam: filterExam.val(),
      sample: filterSample.val(),
      from: filterFrom.val(),
      end: filterEnd.val()
    }
    return data
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

  function parseInputs(data, name) {
    $("." + name + "ed").remove()
    
    var array = data['form'][name]
    if (typeof(array) == 'string') {
      array = array.split(', ')
    }

    array.forEach((element, index) => {
      addInfo(dataPicker[name])
      if (dataPicker[name] == 1) {
        $("#form-" + index).val(element)
      }
      else {
        $("#resulted-" + index).val(element)
      }
    });
  }

  function synchField() {
    var samplecode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())['list']
    // console.log(samplecode);
    
    var data = {
      type: getCheckbox('type', formInsertTypeOther),
      sample: formInsertSample.val(),
      samplecode: checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())['list'],
      exam: getExam()
    }

    var type = (data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
    var sampleCount = data['samplecode'].length
    var maintemp = []
    global_field = []
    for (let i = 0; i < sampleCount; i++) {
      var temp = []
      global_field.push({
        main: ''
      })

      data['exam'].forEach(main => {
        var temp2 = []
        main['exam'].forEach(exam => {
          temp2.push({
            result: '',
            note: exam
          })
        })
        temp.push({
          main: main['symbol'],
          method: main['method'],
          note: temp2
        })
      })

      // splited = splitCode(data['samplecode'][i])
      // if (splited.length > 1) {
      //   from = Number(trim(splited[0]))
      //   end = Number(trim(splited[1]))
      //   for (let j = from; j <= end; j++) {
      //     maintemp.push({
      //       code: j,
      //       number: 1,
      //       status: 0,
      //       type: type,
      //       mainer: temp
      //     })
      //   }
      // }
      // else {
        maintemp.push({
          code: data['samplecode'][i],
          number: 1,
          status: 0,
          type: type,
          mainer: temp
        })
      // }

    }
    global_field = maintemp
    // console.log(global_field);
    
    parseField(global_field)
  }

  function splitCode(code) {
    array = ['đến']
    checker = false
    array.forEach(item => {
      splited = code.split(item)
      if (splited.length > 1) {
        // splited = code.replace('')
        checker = splited
      } 
    })
    return checker
  }

  function parseForm(id) {
    var list = {}
    var x = []
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
        x.push(pos)
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

  function parseField(data) {
    var html = ''
    var installer = []
    var sampleX = -1
    global_field = data

    sample.html('')

    data.forEach((sample, sampleIndex) => {
      var html2 = ''
      var resultX = -1
      sampleX ++

      if (sample['mainer']) sample['mainer'].forEach((result, resultIndex) => {
        var html3 = ''
        var noteX = -1
        resultX ++
        if (!result['note']) result['note'] = [{
          result: '',
          note: ''
        }]
            
        if (result['note']) result['note'].forEach((note, noteIndex) => {
          noteX ++
          html3 += `
          <div class="html-result bordered">
            <button class="close right" data-dismiss="modal" onclick="removeField('`+ sampleIndex +`,`+ resultIndex +`,`+ noteIndex +`')">&times;</button>
            <div class="row form-group">
              <label class="col-sm-6"> Kết quả </label>
              <div class="col-sm-12 relative">
                <input type="text" value="`+ note['result'] +`" class="form-control ig ig-result-`+ sampleIndex +`-`+ resultIndex +`-`+ noteIndex +`" id="result-`+ sampleIndex +`-`+ resultIndex +`-`+ noteIndex +`" autocomplete="off">
                <div class="suggest" id="result-suggest-`+ sampleIndex +`-`+ resultIndex +`-`+ noteIndex +`"></div>
              </div>
            </div>
            <div class="row form-group">
              <label class="col-sm-6"> Ghi chú </label>
              <div class="col-sm-12">
                <input type="text" value="`+ note['note'] +`" class="form-control ig ig-note-`+ sampleIndex +`-`+ resultIndex +`-`+ noteIndex +`" autocomplete="off">
              </div>
            </div>
          </div>`
          installer.push({
            name: sampleIndex +`-`+ resultIndex +`-`+ noteIndex,
            type: 'result'
          })
        })

        html2 += `
        <div class="html-main bordered">
          <button class="close right" data-dismiss="modal" onclick="removeField('`+ sampleIndex +`,`+ resultIndex +`')">&times;</button>
          <div class="row form-group">
            <label class="col-sm-6"> Chỉ tiêu </label>
            <div class="col-sm-12">
              <div class="relative">
                <input type="text" value="`+ result['main'] +`" class="form-control ig ig-main-`+ sampleIndex +`-`+ resultIndex +`" id="main-s`+ sampleIndex +`" autocomplete="off">
                <div class="suggest" id="main-suggest-s`+ sampleIndex +`"></div>
              </div>
            </div>
          </div>
          
          <div class="row form-group">
            <label class="col-sm-6"> Phương pháp </label>
            <div class="col-sm-12">
              <div class="relative">
                <input type="text" value="`+ result['method'] +`" class="form-control ig ig-method-`+ sampleIndex +`-`+ resultIndex +`" id="method-s`+ sampleIndex +`" autocomplete="off">
                <div class="suggest" id="method-suggest-s`+ sampleIndex +`"></div>
              </div>
            </div>
          </div>
          `+ html3 +`
          <button class="btn btn-info" onclick="addField('`+ sampleX +`,`+ resultX +`,`+ noteX +`')"> <span class="glyphicon glyphicon-plus"></span> </button>
        </div>`
        installer.push({
          name: "s" + sampleIndex,
          type: 'main'
        })
        installer.push({
          name: "s" + sampleIndex,
          type: 'method'
        })
      })

      html += `    
      <div class="bordered">
        <span class="marker"> Mẫu `+(sampleIndex + 1)+` </span>
        <span style="float: right;"> <button class="btn btn-info" onclick="toggleButton('#toggle-`+sampleIndex+`')"> <span class="glyphicon glyphicon-eye-open"></span> </button> </span>
        <br>
        <div id="toggle-`+sampleIndex+`">
          <button class="close right" data-dismiss="modal" onclick="removeField('`+ sampleIndex +`')">&times;</button>
          <div class="row form-group">
            <label class="col-sm-6"> Kí hiệu mẫu </label>
            <div class="col-sm-12">
              <input type="text" name="samplecode[]" value="`+ sample['code'] +`" class="form-control ig ig-code-`+ sampleIndex +`" autocomplete="off">
            </div>
          </div>
          <div class="row form-group">
            <label class="col-sm-6"> Loại mẫu </label>
            <div class="col-sm-12">
              <input type="text" name="type[]" value="`+ sample['type'] +`" class="form-control ig ig-type-`+ sampleIndex +`" autocomplete="off">
            </div>
          </div>
          
          <div class="row form-group">
            <label class="col-sm-6"> Số lượng mẫu </label>
            <div class="col-sm-12">
              <input type="text" name="number[]" value="`+ sample['number'] +`" class="form-control ig ig-number-`+ sampleIndex +`" autocomplete="off">
            </div>
          </div>
          
          <div class="row form-group">
            <label class="col-sm-6"> Tình trạng mẫu </label>
              <input type="radio" name="samplestatus-`+ sampleIndex +`" `+ (Number(sample['status']) ? '' : 'checked' ) +` class="form-control ig ig-status0-`+ sampleIndex +`"> Đạt<br>
              <input type="radio" name="samplestatus" `+ (Number(sample['status']) ? 'checked' : '' ) +` class="form-control ig ig-status1-`+ sampleIndex +`"> Không đạt
          </div>
          `+ html2 +`
          <button class="btn btn-info" onclick="addField('`+ sampleX +`,`+ resultX +`')"><span class="glyphicon glyphicon-plus"></span></button>
        </div>
      </div>`
    })
    html = `<button class="btn btn-info" onclick="synchField()"><span class="glyphicon glyphicon-refresh"></span></button> <a href="#fdown" class="btn btn-info"> <span class="glyphicon glyphicon-arrow-down"> </span></a><span id="fup"> `+ html +`<button class="btn btn-info" onclick="addField('`+ sampleX +`')"><span class="glyphicon glyphicon-plus"></span></button> <a href="#fup" class="btn btn-info"> <span class="glyphicon glyphicon-arrow-up"> </span></a><span id="fdown"></span>`
    sample.html(html)
    installer.forEach(item => {
      installRemindv2(item['name'], item['type'])
    })
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
        html += `
          <div class="row form-group" style="width: 100%;">
            <button type="button" class="close" data-dismiss="modal" onclick="removeIgSecret('`+ key +`')">&times;</button>
            <label class="col-sm-6">
              Chỉ tiêu:
            </label>
            <div class="col-sm-12 relative">
              <input type="text" class="form-control exam-sx exam-sx-`+index+`" value="`+ key +`" id="examsx-`+ (index) +`" autocomplete="off">
              <div class="suggest" id="examsx-suggest-`+ (index) +`"> </div>
            </div>
            <div class="col-sm-4">
              <input type="number" class="form-control number-sx-`+index+`" id="number-sx`+ (index) +`" value="`+ element +`" autocomplete="off">
            </div>
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
      </button>
    `
    $("#smsample").html(html)
    installer.forEach(item => {
      installRemindv2(item['name'], item['type'])
    })
    installRemindv2('0', 'reformer');
  }

  function removeIgSecret(key) {
    var dat = {}
    $(".exam-sx").each((index, item) => {
      dat[item.value] = $("#number-sx" + (index + 1)).val()
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
      dat[item.value] = $("#number-sx" + (index + 1)).val()
    })
    dat[''] = ''
    global_ig = dat
    parseIgSecret(global_ig)
  }

  function checkSecretary() {
    var temp = {}
    $(".exam-sx").each((index, item) => {
      var idp = item.getAttribute('class').replace('form-control exam-sx exam-sx-', '')
      temp[$(".exam-sx-" + idp).val()] = $(".number-sx-" + idp).val()
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
          temp += '<p><div style="width: 80%; display: inline-block;">&emsp;- Chỉ tiêu: '+key+'</div><span style="width: 20%;">/<div style="width: 20pt; text-align: center; display: inline-block">'+element+'</div> mẫu.</span> </p>'
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

    function checkSamplecode(samplecode, samplenumber) {
      var result = []
      var sampleListA = samplecode.split(', ')
      sampleListA.forEach((sampleA, sampleAIndex) => {
        if (sampleA.search('-') >= 0) {
          liberate = ''
          var sampleListB = sampleA.split('-')
          if (sampleListB.length == 2) {
            var sampleFrom = trim(sampleListB[0])
            var sampleEnd = trim(sampleListB[1])

            if (sampleFrom.length == sampleEnd.length) {
              var liberateCount = sampleFrom.length
              for (let i = 0; i < liberateCount; i++) {
                if (sampleFrom[i] == sampleEnd[i]) {
                  liberate += sampleFrom[i]
                }
                else {
                  break;
                }
              }

              liberateCount = liberate.length
              sampleFrom = Number(sampleFrom.slice(liberateCount))
              sampleEnd = Number(sampleEnd.slice(liberateCount))
              sampleCount = String(sampleEnd).length

              if (sampleFrom && sampleEnd) {
                // replace 
                if (sampleFrom > sampleEnd) {
                  temp = sampleFrom
                  sampleFrom = sampleEnd
                  sampleEnd = temp
                }

                for (let index = sampleFrom; index <= sampleEnd; index++) {
                  result.push(liberate + fillZero(index, sampleCount))
                }
              }
            }
            else {
              result.push(sampleA)
            }

            // var liberateCount = (sampleFrom.length > sampleEnd.length ? sampleEnd.length : sampleFrom.length)
            // var liberate = ''
            // for (let i = 0; i < liberateCount; i++) {
            //   if (sampleFrom[i] == sampleEnd[i]) {
            //     liberate += sampleFrom[i]
            //   }
            //   else {
            //     break;
            //   }
            // }
            // var sampleNumber = liberate.length
            // if (sampleNumber) {
            //   var sampleNumberFrom = Number(sampleFrom.slice(sampleNumber))
            //   var sampleNumberEnd = Number(sampleEnd.slice(sampleNumber))
            //   sampleListA[sampleAIndex] = sampleFrom
            //   for (let i = sampleNumberEnd; i > sampleNumberFrom; i--) {
            //     sampleListA.splice(sampleAIndex + 1, 0, liberate + i)
            //   }
            //   // return true
            // }
            // else {
            //   // reutrn false
            // }
          }
          else {
            result.push(sampleA)
            // return false
          }
        }
        else {
          result.push(sampleA)
        }
      })
      // console.log(result);
      
      // var result = (sampleListA.length == samplenumber ? true : false)
      // if (!result) {
        //   alert_msg('Ký hiệu mẫu không khớp số lượng')
      // }
      // return {list: sampleListA, result: result}
      resultChecker = result.length == samplenumber ? true : false
      if (!resultChecker) {
        alert_msg('Ký hiệu mẫu không khớp số lượng, ' + result.length + ' trên ' + samplenumber)
      }

      return {list: result, result: resultChecker}
    }

  function fillZero(number, length) {
    if (String(number).length < length) {
      return (new Array(length - String(number).length).fill(0)).join('') + number
    }
    return number
  }

  function parseFieldTable(data) {
    var html = `  <table class="table-bordered" border="1">
    <tr>
      <th rowspan="2" style="width: 10px"> TT </th>
      <th rowspan="2" style="width: 50px"> Kí hiệu mẫu </th>
      <th rowspan="2" style="width: 50px"> Loại mẫu </th> 
      <th rowspan="2" style="width: 50px"> Số lượng </th>
      <th rowspan="2"> Tình trạng mẫu </th>
      <th colspan="3"> Yêu cầu thử nghiệm </th>
      <th rowspan="2"> Ghi chú </th>
    </tr>
    <tr>
      <th style="width: 100px"> Chỉ tiêu </th>
      <th> Phương pháp </th>
      <th style="width: 120px"> Kết quả </th>
    </tr>`
    var html2 = ''
    var index = 1

    data.forEach((sample, sampleIndex) => {
      var html3 = ''
      var noteCount = 0 
      var xcode = getInputs('xcode')
      sample['mainer'].forEach((result, resultIndex) => {
        var html4 = ''
        var mainerNoteCount = 0;
            
        if (result['note'].length > 1) {
          result['note'].forEach((note, noteIndex) => {
            noteCount ++
            mainerNoteCount ++
            html4 += `<td class="text-center">`+ note['result'] +`</td> <td>`+ note['note'] +`</td></tr>`
          })
          html4 = `<td class="text-center" rowspan="`+ mainerNoteCount +`"> ` + result['main'] + `</td><td class="text-center" rowspan="`+ mainerNoteCount +`">`+ result['method'] + `</td>` + html4
        }
        else {
          noteCount ++
          html4 += `<td class="text-center"> ` + result['main'] + `</td><td class="text-center">`+ result['method'] + `</td><td class="text-center">`+ result['note'][0]['result'] +`</td> <td>`+ result['note'][0]['note'] +`</td></tr>`
        }
        html3 += html4
      })

      html2 += '<tr><td rowspan="'+ noteCount +'" class="text-center">'+ (index++) +'</td><td rowspan="'+ noteCount +'" class="text-center">'+ (sample['code'] + '-' + parseIntNum(index - 1)) +'</td><td rowspan="'+ noteCount +'" class="text-center"> '+ sample['type'] +'</td><td rowspan="'+ noteCount +'" class="text-center"> '+ sample['number'] +' </td><td rowspan="'+ noteCount +'" class="text-center"> '+ (sample['status'] ? 'Đạt' : 'Không đạt') +' YCXN </td>' + html3;
    })

    html += html2 + '</table>'
    return html
  }

  function parseIntNum(number) {
    return ((Number(number) < 10 ? '0' : '') + number)
  }

  function parseFieldTable2(data, xcode) {
    var index = 1
    var list = []

    data.forEach((sample, sampleId) => {
      sample.mainer.forEach((result, resultId) => {
        result.note.forEach((note, noteId) => {
          list.push({
            index: parseIntNum(index),
            code: sample.code,
            method: result.main,
            result: note.result,
            note: note.note
          })
        })
      })
      index ++
    })

    var length = list.length
    var page = 1
    var min = Math.floor((length - 24) / 30)
    var total = 1 + min + ((length - 24 - min * 30 ) ? 1 : 0)
    var html = `
    <p class="text-center" style="clear:both"> <b> Số phiếu kết quả thử nghiệm: `+xcode[0]+`/`+xcode[1]+`/`+xcode[2]+`.CĐXN </b> </p> 
    <table class="table-bordered" border="1">
      <tr>
        <th style="width: 50px"> KHM </th>
        <th style="width: 50px"> Số nhận diện </th>
        <th> Phương pháp XN </th> 
        <th> Kết quả </th>
        <th> Ghi chú </th>
      </tr>`

    prv = { index: '', code: '' }
    for (let i = 0; i < 24; i++) {
      if (item = list[i]) {
        // if (prv.index == item.index) item.index = ''
        // else prv.index = item.index
        // if (prv.code == item.code) item.code = ''
        // else prv.code = item.code
        html += `
          <tr>
            <td class="text-center"> `+ item.index +` </td>
            <td class="text-center"> `+ item.code +` </td>
            <td class="text-center"> `+ item.method +` </td>
            <td class="text-center"> `+ item.result +` </td>
            <td> `+ item.note +` </td>
          </tr>`
      }      
    }

    while (length - 24 - (page - 1) * 30 > 0) {
      html += `
      </table>
      <div class="pagebreak"> </div>
      <table class="table-bordered" border="1" style="clear:both">
        <tr>
          <th style="width: 50px"> KHM </th>
          <th style="width: 50px"> Số nhận diện </th>
          <th> Phương pháp XN </th> 
          <th> Kết quả </th>
          <th> Ghi chú </th>
        </tr>`

      prv = { index: '', code: '' }
      max = 24 + page * 30
      for (let i = 24 + (page - 1) * 30; i < max; i++) {
        if (item = list[i]) {
        // if (prv.index == item.index) item.index = ''
        // else prv.index = item.index
        // if (prv.code == item.code) item.code = ''
        // else prv.code = item.code
          html += `
            <tr>
              <td> `+ item.index +` </td>
              <td> `+ item.code +` </td>
              <td> `+ item.method +` </td>
              <td> `+ item.result +` </td>
              <td> `+ item.note +` </td>
            </tr>`
        }
      }
      page ++
    }
    
    html += `</table>`
    return html
  }


  function getIgField() {
    var list = []
    var data = []
    $(".ig").each((index, item) => {
      list.push()
      className = item.getAttribute('class')
      var start = className.indexOf('ig-')
      var end = className.indexOf(' ', start)
      if (end < 0) {
        var pos = className.slice(start + 3) 
      }
      else {
        var pos = className.slice(start + 3, end) 
      }

      if (pos) {
        var poses = pos.split('-')
        var posesCount = poses.length
        switch (posesCount) {
          case 2:
            if (!data[poses[1]]) {
              data[poses[1]] = {}
            }
            if (poses[0].search('status') >= 0) {
              var id = poses[0].replace('status', '')
              if ($(".ig-" + pos)[0].checked) {
                data[poses[1]]['status'] = id
              }
            }
            else {
              data[poses[1]][poses[0]] = $(".ig-" + pos)[0].value
            }
          break;
          case 3:
            if (!data[poses[1]]['mainer']) {
              data[poses[1]]['mainer'] = []
            }
            if (!data[poses[1]]['mainer'][poses[2]]) {
              data[poses[1]]['mainer'][poses[2]] = {}
            }
            data[poses[1]]['mainer'][poses[2]][poses[0]] = $(".ig-" + pos)[0].value
          break;
          case 4:
            if (!data[poses[1]]) {
              data[poses[1]] = {}
            }
          
            if (!data[poses[1]]['mainer']) {
              data[poses[1]]['mainer'] = []
            }
            if (!data[poses[1]]['mainer'][poses[2]]) {
              data[poses[1]]['mainer'][poses[2]] = {}
            }

            if (!data[poses[1]]['mainer'][poses[2]]['note']) {
              data[poses[1]]['mainer'][poses[2]]['note'] = []
            }
            if (!data[poses[1]]['mainer'][poses[2]]['note'][poses[3]]) {
              data[poses[1]]['mainer'][poses[2]]['note'][poses[3]] = {}
            }
            data[poses[1]]['mainer'][poses[2]]['note'][poses[3]][poses[0]] = $(".ig-" + pos)[0].value            
          break;
        }
      }
    })
    return data
  }

  function addField(indexString) {
    var indexType = indexString.split(',')
    var indexCount = indexType.length

    switch (indexCount) {
      case 1:
        global_field.splice(Number(indexType[0]) + 1, 0, {
          code: '',
          type: '',
          number: 1,
          status: 0,
          mainer: [
            {
              main: '',
              method: '',
              note: [
                {
                  result: '',
                  note: ''
                }
              ]
            }
          ]
        })
      break;
      case 2:
        global_field[indexType[0]]['mainer'].splice(Number(indexType[1]) + 1, 0, {
          main: '',
          method: '',
          number: 1,
          note: [
            {
              result: '',
              note: ''
            }
          ]
        })
      break;
      case 3:
        global_field[indexType[0]]['mainer'][indexType[1]]['note'].splice(Number(indexType[2]) + 1, 0, {
          result: '',
          note: ''
        })     
      break;
    }
    parseField(global_field)
  }

  function removeField(indexString) {
    var indexType = indexString.split(',')
    var indexCount = indexType.length
    switch (indexCount) {
      case 1:
        
        global_field = global_field.filter((item, index) => {
          return index != indexType[0]
        })
      break;
      case 2:
        global_field[indexType[0]]['mainer'] = global_field[indexType[0]]['mainer'].filter((item, index) => {
          return index != indexType[1]
        })        
      break;
      case 3:
        global_field[indexType[0]]['mainer'][indexType[1]]['note'] = global_field[indexType[0]]['mainer'][indexType[1]]['note'].filter((item, index) => {
          return index != indexType[2]
        })
      break;
    }
    
    parseField(global_field)
  }

  function selectRemind(name, selectValue) {
    globalTarget[name]['input'].val(selectValue)
  }

  function selectRemindv2a(id, selectValue) {
    $(id).val(selectValue)
  }

  function insertMethod() {
    methodModal.modal('show')
  }


  function installRemindv2(name, type) {
    var timeout
    var check = true
    var input = $("#"+ type +"-" + name)
    var suggest = $("#"+ type +"-suggest-" + name)
    input.keyup(() => {
      if (check) check = false
      clearTimeout(timeout)
      timeout = setTimeout(() => {
        if (!check) {
          var html = ''
  
          vhttp.checkelse('', {
            action: 'get-remind', 
            name: name,
            type: type,
            key: input.val()
          }).then(response => {
            html = response.html
            check = true
            suggest.html(html)
          }, () => {
            html = 'Không có dữ liệu'
            check = true
            suggest.html(html)
          })
        } 
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


  function removeRemindv2(name, type, id) {
    if (id) {
      $.post(
        strHref,
        {action: 'removeRemindv2', id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            remindv2 = JSON.parse(data['remind'])
            $("#"+ type +"-" + name).val('')
          }, () => {})
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
          }, () => {})
        }
      )
    }
  }

  function newForm() {
    global_clone = 0
    global_id = 0
    global_form = 1
    global_saved = 0
    parseSaved()
    parseBox(global_form)
    var xcode = defaultData['xcode'].split(',')
    installSignerTemplate()
    
    formInsertReceive.val(defaultData['today'])
    formInsertResend.val(defaultData['tomorrow'])
    formInsertIreceive.val(defaultData['today'])
    formInsertIresend.val(defaultData['tomorrow'])
    formInsertExamDate.val(defaultData['tomorrow'])
    $("#form-insert-exam-date-2").val(defaultData['tomorrow'])
    formInsertXreceive.val(defaultData['today'])
    formInsertXsend.val(defaultData['today'])
    formInsertXresend.val(defaultData['tomorrow'])
    formInsertSampleReceive.val(defaultData['yesterday'])
    formInsertNoticeTime.val(defaultData['today'])

    formInsertPage2.val(defaultData['remind']['page2'])
    formInsertPage3.val(defaultData['remind']['page3'])
    formInsertPage4.val(defaultData['remind']['page4'])
    formInsertReceiveDis.val(defaultData['receivedis'])
    formInsertCode.val(defaultData['code'])
    formInsertXcode1.val(xcode[0])
    formInsertXcode2.val(xcode[1])
    formInsertXcode3.val('')
    formInsertNumber.val(defaultData['number'])
    formInsertNumberWord.val(defaultData['numberword'])

    formInsertSenderEmploy.val(defaultData['remind']['sender-employ'])
    formInsertReceiverEmploy.val(defaultData['remind']['receiver-employ'])
    formInsertIsenderUnit.val(defaultData['remind']['isender-unit'])
    formInsertIreceiverEmploy.val(defaultData['remind']['ireceiver-employ'])
    formInsertIreceiverUnit.val(defaultData['remind']['ireceiver-unit'])
    formInsertSampleReceiver.val(defaultData['remind']['sample-receiver'])
    formInsertXreceiver.val(defaultData['remind']['xreceiver'])
    formInsertXresender.val(defaultData['remind']['xresender'])
    formInsertXsender.val(defaultData['remind']['xsender'])
    formInsertXexam.val(defaultData['remind']['xexam'])
    formInsertAddress.val(defaultData['remind']['address'])
    formInsertXphone.val(defaultData['remind']['xphone'])
    formInsertFax.val(defaultData['remind']['fax'])
    formInsertSample.val(defaultData['remind']['sample'])
    formInsertXaddress.val(defaultData['remind']['xaddress'])
    formInsertOwnerPhone.val(defaultData['remind']['ownerphone'])
    formInsertOwnerMail.val(defaultData['remind']['ownermail'])
    formInsertOwner.val(defaultData['remind']['owner'])
    formInsertSamplePlace.val(defaultData['remind']['sample-place'])
    formInsertReceiveLeader.val(defaultData['remind']['receive-leader'])

    formInsertMcode.val('')
    formInsertExamSample.val('')
    formInsertStatus.val('')
    formInsertSampleCode.val('')
    formInsertSampleCode5.val('')
    formInsertTarget.val('')
    formInsertQuality.val('')
    formInsertPhone.val('')
    formInsertOther.val('')
    formInsertResult.val('.........................................................................................................................................................................................................................<br>..........................................................................................................................................................................................................................................')
    formInsertTarget.val('')
    formInsertEndedCopy.val('')
    formInsertNote.val('')
    formInsertVnote.val(`(*)- Các chỉ tiêu được công nhận TCVN ISO/IEC 17025:2007.
    - Các chỉ tiêu được chứng nhận đăng ký hoạt động thử nghiệm.`)
    global_field = [{
      code: '',
      type: '',
      number: 1,
      status: 0,
      mainer: [
        {
          main: '',
          method: '',
          note: [
            {
              result: '',
              note: ''
            }
          ]
        }
      ]
    }]
    $(".status").prop('checked', false)
    $(".status-0").prop('checked', true)
    parseField(global_field)
    global_exam = [{
      method: defaultData['remind']['method'],
      symbol: defaultData['remind']['symbol'],
      exam: [defaultData['remind']['exam']]
    }]
    parseExam(global_exam)

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
    // addInfo(1)
    addInfo(3)
    parseInputs({form: {form: defaultData['remind']['form']}}, 'form')
    $(".type").prop('checked', false)
    $(".state").prop('checked', false)
    $("#signer_xsign").prop('checked', false)
    $("#signer_locker").val(0)
    $("#locker_button").attr('class', 'btn btn-info')
    $("#signer_locking").text('Chưa khóa')
    
    $("#typed-0").prop('checked', true)
    $("#state-0").prop('checked', true)
    formInsertReceiverStateOther.val('')
    formInsertTypeOther.val('')
  }

  function change() {
    var check = $('#checkall').prop('checked')
    $('.check').prop('checked', check)
  }

  function summary() {
    formSummary.modal('show')
  }

  function toggleButton(section) {
    $(section).fadeToggle()
  }

  function summaryFilter() {
    $.post(
      strHref,
      {action: 'summaryFilter', from: formSummaryFrom.val(), end: formSummaryEnd.val(), unit: formSummaryUnit.val(), exam: formSummaryExam.val(), sample: formSummarySample.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          formSummaryContent.html(data['html'])
        }, () => {  })
      }
    )
  }

  function insert() {
    formInsert.modal('show')
  }

  function addInfo(id) {
    var length = infoData[id].length
    switch (id) {
      case 1:
        var html = `
          <div class="formed" id="formed-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(1, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-6"> Tên hồ sơ </label>
              <div class="col-sm-12 relative">
                <input type="text" class="form-control input-box form" id="form-` + length + `" autocomplete="off">
                <div class="suggest" id="form-suggest-` + length + `"></div>
              </div>
            </div>
          </div>`
          
          formInsertForm.append(html)
          installRemindv2(length, 'form')
        break;
      case 2:
        var html = `
          <div class="examed bordered" id="exam-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(2, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-4"> Phương pháp </label>
              <div class="col-sm-12 relative">
                <input type="text" class="form-control input-box method" id="method-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest" id="method-suggest-` + length + `"> </div>
              </div>
            </div>
            <div class="row">
              <label class="col-sm-4"> Ký hiệu </label>
              <div class="col-sm-12 relative">
                <input type="text" class="form-control input-box symbol" id="symbol-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest" id="symbol-suggest-` + length + `"> </div>
              </div>
            </div>
            <div class="row">
              <label class="col-sm-4"> Yêu cầu </label>
              <div class="col-sm-12 relative">
                <input type="text" class="form-control input-box exam examed" id="examed-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest exam-suggest" id="exam-suggest-` + length + `"> </div>
              </div>
            </div>
          </div>`
        formInsertRequest.append(html)
        installRemindv2(length, 'symbol')
        installRemindv2(length, 'method')
      break;
      case 3:
        var html = `
          <div class="resulted" id="result-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(3, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-4"> Kết quả </label>
              <div class="col-sm-12 relative">
                <input type="text" class="form-control input-box resulted resulted" id="resulted-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest resulted-suggest" id="resulted-suggest-` + length + `"> </div>
              </div>
            </div>
          </div>`
        formInsertResult.append(html)
      break;
    }
    infoData[id].push(html)
  }

  function insertResult() {
    global.result = []
    $('.results').each((index, item) => {
      global.result.push(item.value)
    })
    global.result.push('')
    reloadResult()
  }

  function reloadResult() {
    var html = ''
    var code = checkSamplecode($('#form-insert-sample-code').val(), $('#form-insert-number').val())
    global.result.forEach((item, index) => {
      html += `
        <div class="row form-group">
          <div class="input-group">
            <span class="input-group-addon"> `+ (code.list[index] ? code.list[index] : '') +` </span>
            <input type="text" class="form-control input-box results" id="results-` + index + `" autocomplete="off" value="`+ item +`">
            <div class="input-group-btn">
              <button class="btn btn-danger" onclick="removeResult(` + index + `)">
                <span class="glyphicon glyphicon-remove"> </span>
              </button>
            </div>
          </div>
        </div>`
    })
    $('#insert-result').html(html)
  }

  function removeResult(remove_index) {
    global.result = []
    $('.results').each((index, item) => {
      if (remove_index != index) global.result.push(item.value)
    })

    if (!global.result.length) global.result = ['']
    reloadResult()
  }

  // function toggleResult(result = []) {
  //   var disabled = $('#form-insert-result').attr('disabled')
  //   if (disabled) {
  //     $('#results').fadeOut()
  //     $('#form-insert-result').attr('disabled', false)
  //   }
  //   else {
  //     var html = ''
  //     if (result.length) {
  //       result.forEach((item, index) => {
  //       html += `
  //         <div class="row form-group">
  //           <label class="col-sm-1">  </label>
  //           <label class="col-sm-5">  </label>
  //           <div class="col-sm-12">
  //             <input type="text" class="form-control results" id="results-`+index+`" autocomplete="off" value="`+ item +`">
  //           </div>
  //         </div>`
  //       })
  //     }
  //     else {
  //       var ig = getIgField()
  //       ig.forEach((item, index) => {
  //       html += `
  //         <div class="row form-group">
  //           <label class="col-sm-1">  </label>
  //           <label class="col-sm-5"> `+ item.code +` </label>
  //           <div class="col-sm-12">
  //             <input type="text" class="form-control results" id="results-`+index+`" autocomplete="off">
  //           </div>
  //         </div>`
  //       })
  //     } 
  //     $('#results').html(html)
  //     $('#results').fadeIn()
  //     $('#form-insert-result').attr('disabled', true)
  //   }
  // }

  function removeInfo(id, index) {
    switch (id) {
      case 1:
        $("#formed-" + index).remove()
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

  function remove(id) {
    formRemove.modal('show')
    global_id = id
  }

  function removeSubmit() {
    $.post(
      strHref, 
      {action: 'remove', id: global_id, page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val(), other: getFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          formRemove.modal('hide')
        }, () => {})
      }
    )
  }
//
  function checkAllForm() {
    var data = {}
    var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())

    global.result = []
    $('.results').each((index, item) => {
      global.result.push(item.value)
    })

    if (sampleCode['result']) {
      data = {
        code: formInsertCode.val(),
        sender: formInsertSenderEmploy.val(),
        receive: formInsertReceive.val(),
        resend: formInsertResend.val(),
        state: getCheckbox('state', formInsertReceiverStateOther),
        receiver: formInsertReceiverEmploy.val(),
        ireceive: formInsertIreceive.val(),
        iresend: formInsertIresend.val(),
        form: getInputs('form'),
        number: formInsertNumber.val(),
        sample: formInsertSample.val(),
        type: getCheckbox('type', formInsertTypeOther),
        samplecode: formInsertSampleCode.val(),
        exam: getExam(),
        xnote: formInsertXnote.val(),
        numberword: formInsertNumberWord.val(),
        xcode: getInputs('xcode'),
        isenderunit: formInsertIsenderUnit.val(),
        ireceiverunit: formInsertIreceiverUnit.val(),
        xreceiver: formInsertXreceiver.val(),
        xsender: formInsertXsender.val(),
        xresender: formInsertXresender.val(),
        examdate: formInsertExamDate.val(),
        xreceive: formInsertXreceive.val(),
        xsend: formInsertXsend.val(),
        result: global.result.join('@@'),
        xresend: formInsertXresend.val(),
        note: formInsertCnote.val(),
        page2: formInsertPage2.val(),
        ig: getIgField(),
        vnote: formInsertVnote.val(),
        xexam: formInsertXexam.val(),
        page3: formInsertPage3.val(),
        receivehour: formInsertSampleReceiveHour.val(),
        receiveminute: formInsertSampleReceiveMinute.val(),
        status: getCheckbox('status'),
        samplecode5: formInsertSampleCode5.val(),
        address: formInsertAddress.val(),
        fax: formInsertFax.val(),
        xphone: formInsertXphone.val(),
        samplereceive: formInsertSampleReceive.val(),
        samplereceiver: formInsertSampleReceiver.val(),
        ireceiveremploy: formInsertIreceiverEmploy.val(),
        page4: formInsertPage4.val(),
        xaddress: formInsertXaddress.val(),
        examsample: formInsertExamSample.val(),
        target: formInsertTarget.val(),
        mcode: formInsertMcode.val(),
        receivedis: formInsertReceiveDis.val(),
        receiveleader: formInsertReceiveLeader.val(),
        sampleplace: formInsertSamplePlace.val(),
        owner: formInsertOwner.val(),
        ownerphone: formInsertOwnerPhone.val(),
        ownermail: formInsertOwnerMail.val(),
        xsign: $("#signer_xsign").prop('checked') ? 1 : 0
      }
    }
    return data
  }

  function checkForm(id) {
    var data = {}
    switch (id) {
      case 1:
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          data = {
            code: formInsertCode.val(),
            sender: formInsertSenderEmploy.val(),
            receive: formInsertReceive.val(),
            resend: formInsertResend.val(),
            state: getCheckbox('state', formInsertReceiverStateOther),
            receiver: formInsertReceiverEmploy.val(),
            ireceive: formInsertIreceive.val(),
            iresend: formInsertIresend.val(),
            form: getInputs('form'),
            number: formInsertNumber.val(),
            sample: formInsertSample.val(),
            type: getCheckbox('type', formInsertTypeOther),
            samplecode: formInsertSampleCode.val(),
            exam: getExam(),
            xnote: formInsertXnote.val(),
            numberword: formInsertNumberWord.val(),
            signer: checkSigner()
          }
        }
      break;
      case 2: 
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          global.result = []
          $('.results').each((index, item) => {
            global.result.push(item.value)
          })

          data = {
            xcode: getInputs('xcode'),
            isenderunit: formInsertIsenderUnit.val(),
            ireceiverunit: formInsertIreceiverUnit.val(),
            xreceiver: formInsertXreceiver.val(),
            xsender: formInsertXsender.val(),
            xresender: formInsertXresender.val(),
            examdate: formInsertExamDate.val(),
            examdate2: $("#form-insert-exam-date-2").val(),
            iresend: formInsertIresend.val(),
            xreceive: formInsertXreceive.val(),
            xsend: formInsertXsend.val(),
            result: global.result,
            xresend: formInsertXresend.val(),
            note: formInsertCnote.val(),
            page2: formInsertPage2.val(),
            ig: getIgField(),
            signer: checkSigner()
          }
        }
      break;
      case 3:
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          data = {
            xcode: getInputs('xcode'),
            vnote: formInsertVnote.val(),
            xexam: formInsertXexam.val(),
            xresender: formInsertXresender.val(),
            page3: formInsertPage3.val(),
            ig: getIgField(),
            signer: checkSigner()
          }
        }
      break;            
      case 4:
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          global.result = []
          $('.results').each((index, item) => {
            global.result.push(item.value)
          })
          data = {
            receive: formInsertReceive.val(),
            xcode: getInputs('xcode'),
            receivehour: formInsertSampleReceiveHour.val(),
            receiveminute: formInsertSampleReceiveMinute.val(),
            type: getCheckbox('type', formInsertTypeOther),
            number: formInsertNumber.val(),
            status: getCheckbox('status'),
            samplecode5: formInsertSampleCode5.val(),
            isenderunit: formInsertIsenderUnit.val(), 
            address: formInsertAddress.val(),
            fax: formInsertFax.val(),
            xphone: formInsertXphone.val(),
            samplereceive: formInsertSampleReceive.val(),
            samplereceiver: formInsertSampleReceiver.val(),
            examdate: formInsertExamDate.val(),
            examdate2: $("#form-insert-exam-date-2").val(),
            result: global.result,
            sample: formInsertSample.val(),
            note: formInsertNote.val(),
            ireceiveremploy: formInsertIreceiverEmploy.val(),
            numberword: formInsertNumberWord.val(),
            page4: formInsertPage4.val(),
            xexam: formInsertXexam.val(),
            xresender: formInsertXresender.val(),
            exam: getExam(),
            signer: checkSigner()
          }
        }
      break;
      case 5:
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          global.result = []
          $('.results').each((index, item) => {
            global.result.push(item.value)
          })

          data = {
            xcode: getInputs('xcode'),
            sender: formInsertSenderEmploy.val(),
            resend: formInsertNoticeTime.val(),
            xaddress: formInsertXaddress.val(),
            number: formInsertNumber.val(),
            samplecode5: formInsertSampleCode5.val(),
            examsample: formInsertExamSample.val(),
            target: formInsertTarget.val(),
            note: formInsertNote.val(),
            mcode: formInsertMcode.val(),
            receivedis: formInsertReceiveDis.val(),
            receiveleader: formInsertReceiveLeader.val(),
            noticetime: $("#form-insert-notice-time").val(),
            sampleplace: formInsertSamplePlace.val(),
            sample: formInsertSample.val(),
            owner: formInsertOwner.val(),
            exam: getExam(),
            result: global.result,
            receive: formInsertReceive.val(),
            ownerphone: formInsertOwnerPhone.val(),
            ownermail: formInsertOwnerMail.val(),
            numberword: formInsertNumberWord.val(),
            type: getCheckbox('type', formInsertTypeOther),
            samplereceive: formInsertSampleReceive.val(),
            signer: checkSigner(),
            xsign: $("#signer_xsign").prop('checked') ? 1 : 0,
            locker: $("#signer_locker").val()
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
          parseData(data)

          // if (String(global_printer - 1).indexOf(permist) >= 0) {
          //   global_form = global_printer
          //   global_saved = data['form']['printer']
          // }
          // else if (permist[0] < data['form']['printer']) {
          //   global_form = permist[0]
          //   global_saved = data['form']['printer']
          // }
          // else {
          //   global_form = 6
          //   global_saved = -1
          // }
          
          $('a[href="#menu1"]').tab('show')
        }, () => {})
      }
    )
  }

  function parseData(data) {
    parseSaved()
    if (permist[0] && data['form']['printer'] >= (permist[0] + 1)) {
      parseBox(permist[0] + 1)
    }
    else {
      parseBox(-1)
    }
    infoData = {1: [], 2: [], 3: []}
    installSignerTemplate(JSON.parse(data['form']['signer']))

    if (data['form']['printer'] >= 1) {
      try {
        temp = JSON.parse(data['form']['exam'])
        global_exam = temp
      }
      catch (e) {
        global_exam = [{
          method: '',
          symbol: '',
          exam: ['']
        }]
      }
      parseExam(global_exam)
      
      formInsertCode.val(data['form']['code'])
      formInsertSenderEmploy.val(data['form']['sender'])
      formInsertReceiverEmploy.val(data['form']['receiver'])
      formInsertReceive.val(data['form']['receive'])
      formInsertResend.val(data['form']['resend'])
      formInsertIreceive.val(data['form']['ireceive'])
      formInsertIresend.val(data['form']['iresend'])
      formInsertNumber.val(data['form']['number'])
      formInsertExamSample.val(data['form']['number'])
      formInsertSample.val(data['form']['sample'])
      formInsertSampleCode.val(data['form']['samplecode'])
      formInsertSampleCode5.val(data['form']['samplecode'])
      formInsertXnote.val(data['form']['xnote'])
      formInsertNumberWord.val(data['form']['numberword']),

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
      $(".status").prop('checked', false)
      $(".status-" + data['form']['status']['index']).prop('checked', true)
      global.result = data['form']['result']
      reloadResult()

      var xcode = data['form']['xcode'].split(',')
      formInsertCnote.val(data['form']['note'])
      formInsertPage2.val(data['form']['page2'])
      formInsertXcode1.val(xcode[0])
      formInsertXcode2.val(xcode[1])
      formInsertXcode3.val(xcode[2])
      formInsertIsenderUnit.val(data['form']['isenderunit'])
      formInsertIreceiverUnit.val(data['form']['ireceiverunit'])
      parseField(JSON.parse(data['form']['ig']))
      formInsertExamDate.val(data['form']['examdate'])
      $("#form-insert-exam-date-2").val(data['form']['examdate2'])
      formInsertIresend.val(data['form']['iresend'])
      formInsertXreceive.val(data['form']['xreceive'])
      formInsertXreceiver.val(data['form']['xreceiver'])
      formInsertXresend.val(data['form']['xresend'])
      formInsertXresender.val(data['form']['xresender'])
      formInsertXsend.val(data['form']['xsend'])
      formInsertXsender.val(data['form']['xsender'])
    }

    if (data['form']['printer'] >= 3) {
      formInsertPage3.val(data['form']['page3'])
      formInsertXexam.val(data['form']['xexam'])
      formInsertVnote.val(data['form']['vnote'])
    }

    if (data['form']['printer'] >= 4) {
      formInsertPage4.val(data['form']['page4'])
      formInsertNote.val(data['form']['note'])
      formInsertIreceiverEmploy.val(data['form']['ireceiveremploy'])
      formInsertXphone.val(data['form']['xphone'])
      formInsertSampleReceiver.val(data['form']['samplereceiver'])
      formInsertSampleReceive.val(data['form']['samplereceive'])
      formInsertAddress.val(data['form']['address'])
      formInsertFax.val(data['form']['fax'])
      formInsertSampleCode5.val(data['form']['samplecode5'])
    }

    if (data['form']['printer'] >= 5) {
      formInsertOwnerPhone.val(data['form']['ownerphone'])
      formInsertOwnerMail.val(data['form']['ownermail'])
      formInsertReceiveLeader.val(data['form']['receiveleader'])
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
      formInsertExamSample.val(data['form']['examsample'])
      formInsertMcode.val(data['form']['mcode'])
      $("#signer_xsign").prop('checked', Number(data['form']['xsign']))
      lock = Number(data['form']['locker'])
      if (lock) {
        $("#signer_locking").text('Đã khóa')
        $("#locker_button").attr('class', 'btn btn-warning')
      }
      else {
        $("#locker_button").attr('class', 'btn btn-info')
        $("#signer_locking").text('Chưa khóa')
      }
      $("#signer_locker").val(lock)
    }
  }

  function insertSubmit() {
    if (global_clone) {
      var data = checkAllForm()
    }
    else {
      var data = checkForm(global_form)
    }
    if (Object.keys(data).length) {
      $.post(
        strHref,
        {action: 'insert', form: global_form, id: global_id, data: data, page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val(), other: getFilter(), clone: global_clone, signer: checkSigner()},
        (response, status) => {
          checkResult(response, status).then(data => {
            remind = JSON.parse(data['remind'])
            remindv2 = JSON.parse(data['remindv2'])
            // defaultData = JSON.parse(data['default'])
            if (global_clone) {
              global_clone = 0
            }
            else if (global_form > global_saved) {
              if (global_form == 1) {
                formInsertExamSample.val(formInsertNumber.val())
                formInsertSampleCode5.val(formInsertSampleCode.val())
              }
              global_saved = global_form
            }
            parseSaved()
            content.html(data['html'])
            global_id = data['id']
          }, () => {})
        }
      )
    }
    else {
      
    }
  }

  function locker(type) {
    if (type) {
      $("#signer_locking").text('Đã khóa')
      $("#locker_button").attr('class', 'btn btn-warning')
    }
    else {
      $("#locker_button").attr('class', 'btn btn-info')
      $("#signer_locking").text('Chưa khóa')
    }

    $("#signer_locker").val(type)
    $("#modal-locker").modal('hide')
  }

  function filter(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: 'filter', page: 1, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val(), other: getFilter(), xcode: filterXcode.val(), owner: filterOwner.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global_page = 1
          global_printer = filterPrinter.val()
          content.html(data['html'])
        }, () => {})
      }
    )
  }

  function getSecretaryFilter() {
    var data = {
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
    return data
  }

  function getSecretaryFilter2(page) {
    var data = {
      page: page,
      keyword: sfilter2Keyword.val(),
      xcode: sfilter2Xcode.val(),
      limit: sfilter2Limit.val(),
      unit: sfilter2Unit.val(),
      exam: sfilter2Exam.val(),
      sample: sfilter2Sample.val(),
      pay: sfilter2Pay.val(),
      from: sfilter2From.val(),
      end: sfilter2End.val(),
      owner: sfilter2Owner.val()
    }
    return data
  }

  function secretaryFilter(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: 'secretaryfilter', page: 1, filter: getSecretaryFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global['secretary']['page'] = 1
          secretaryList.html(data['html'])
          installSelect()
          if (global['select']) {
            $(".select-button").prop('disabled', false)
          }
          else {
            $(".select-button").prop('disabled', true)
          }
        }, () => {})
      }
    )
  }

  function secretaryFilter2(e) {
    e.preventDefault()
    goPage(1)
  }

  function goPage(page) {
    var secret_tab = trim($('.nav-tabs .active').text()).toLowerCase()
    if (secret_tab == 'kế toán') {
      $.post(
        strHref,
        {action: 'secretaryfilter', page: page, filter: getSecretaryFilter()},
        (response, status) => {
          checkResult(response, status).then(data => {
            global['secretary']['page'] = page
            secretaryList.html(data['html'])
            installSelect()
          }, () => {})
        }
      )
    }
    else if (secret_tab == 'văn thư') {
      $.post(
        strHref,
        {action: 'secretaryfilter2', filter: getSecretaryFilter2(page)},
        (response, status) => {
          checkResult(response, status).then(data => {
            global['secretary2']['page'] = page
            secretaryList2.html(data['html'])
            installSelect()
          }, () => {})
        }
      )
    }
    else {
      $.post(
        strHref,
        // page: 1, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val(), other: getFilter(), xcode: filterXcode.val()
        {action: 'filter', page: page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val(), other: getFilter(), xcode: filterXcode.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            global_page = page
            content.html(data['html'])
          }, () => {})
        }
      )
    }
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

  function preview(id, printercount) {
    $.post(
      strHref,
      {action: 'preview', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          data['form']['exam'] = JSON.parse(data['form']['exam'])
          data['form']['ig'] = JSON.parse(data['form']['ig'])
          data['form']['signer'] = JSON.parse(data['form']['signer'])
          data['form']['form'] = data['form']['form'].split(', ')
          printer(printercount, data['form'], 1)
        }, () => {})
      }
    )
  }

  function clone(id) {
    $.post(
      strHref,
      {action: 'preview', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          newForm()
          global_clone = 1
          global_id = 0
          global_form = 5
          global_saved = 5
          data['form']['locker'] = 0
          parseData(data)
          
          $('a[href="#menu1"]').tab('show')
        }, () => {})
      }
    )
  }

  function extractExam(data, tag) {
    var list = []
    var result = []
    var index = 0

    data.forEach(main => {
      main['exam'].forEach(item => {
        list.push(item)
      })
    })
    var length = list.length
    list.forEach(item => {
      
      if (length > 1 && tag) {
        index ++
        result.push(index + tag + ' ' + item)
      }
      else {
        result.push(item)
      }
    })
    return result
  }

  function printer(id, data = {}, prev = 0) {
    if (Object.keys(data).length || visible[global_saved][2].search(id) >= 0) {
      if (!Object.keys(data).length) {
        var data = checkForm(id)
      }
      
      if (Object.keys(data).length) {
        var tabbed = '&emsp;&emsp;'
        var html = former[id]
        id = Number(id)
        var prop = 0
        switch (id) {
          case 1:
            html = html.replace('code', data['code'])
            html = html.replace('senderemploy', data['sender'])
            html = html.replace('receiveremploy', data['receiver'])
            html = html.replace('receive', data['receive'])
            html = html.replace('resend', data['resend'])
            html = html.replace('ireceive', data['ireceive'])
            html = html.replace('iresend', data['iresend'])
            html = html.replace('status-0', data['state']['index'] == 0 ? '&#9745;' : '&#9744;')
            html = html.replace('status-1', data['state']['index'] == 1 ? '&#9745;' : '&#9744;')
            html = html.replace('status-2', data['state']['index'] == 2 ? data['state']['value'] : '')
            html = html.replace('numberword', data['numberword'])
            var exam = extractExam(data['exam'], ')')
            var temp = []
            
            if (data['form'].length > 1) {
              data['form'].forEach((item, index) => {
                data['form'][index] = (index + 1) + ') ' + item
              })
            }

            html = html.replace('formcontent', (data['form'].join('<br>') + '<br>Số lượng mẫu: ' + data['number'] + ', loại mẫu: ' + (data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text())) + ', loài động vật: ' + data['sample'] + '<br> Ký hiệu mẫu: ' + data['samplecode'] + '<br>Yêu cầu xét nghiệm:<br>' + (exam.join('<br>') + (trim(data['xnote']).length ? '<br>' + data['xnote'].replace(/\n/g, '<br>') : ''))))
          break;
          case 2:
            if (typeof(data['xcode']) == 'string') {
              data['xcode'] = data['xcode'].split(',')
            }
            prop = 1
            resend = data['iresend'].split('/')
            xresend = data['xresend'].split('/')
            xreceive = data['xreceive'].split('/')
            xsend = data['xsend'].split('/')

            html = html.replace('(xresender-signer)', Number(data['signer']['xresender']) ? '<img src="'+ global['signer'][data['signer']['xresender']]['url'] +'">' : '<br><br><br>')
            html = html.replace('(xreceiver-signer)', Number(data['signer']['xreceiver']) ? '<img src="'+ global['signer'][data['signer']['xreceiver']]['url'] +'">' : '<br><br><br>')
            html = html.replace('(xsender-signer)', Number(data['signer']['xsender']) ? '<img src="'+ global['signer'][data['signer']['xsender']]['url'] +'">' : '<br><br><br>')
            
            html = html.replace('(page)', data['page2'])
            html = html.replace('isenderunit', data['isenderunit'])
            html = html.replace('ireceiverunit', data['ireceiverunit'])
            html = html.replace('xcode-0', trim(data['xcode'][0]))
            html = html.replace('xcode-1', trim(data['xcode'][1]))
            html = html.replace('xcode-2', trim(data['xcode'][2]))
            html = html.replace('resend-0', (resend[0] ? resend[0] : '&emsp;'))
            html = html.replace('resend-1', (resend[1] ? resend[1] : '&emsp;'))
            html = html.replace('resend-2', (resend[2] ? resend[2] : '&emsp;&emsp;&emsp;'))
            html = html.replace('xresend-0', (xresend[0] ? xresend[0] : '&emsp;'))
            html = html.replace('xresend-1', (xresend[1] ? xresend[1] : '&emsp;'))
            html = html.replace('xresend-2', (xresend[2] ? xresend[2] : '&emsp;&emsp;&emsp;'))
            html = html.replace('xreceive-0', (xreceive[0] ? xreceive[0] : '&emsp;'))
            html = html.replace('xreceive-1', (xreceive[1] ? xreceive[1] : '&emsp;'))
            html = html.replace('xreceive-2', (xreceive[2] ? xreceive[2] : '&emsp;&emsp;&emsp;'))
            html = html.replace('xsend-0', (xsend[0] ? xsend[0] : '&emsp;'))
            html = html.replace('xsend-1', (xsend[1] ? xsend[1] : '&emsp;'))
            html = html.replace('xsend-2', (xsend[2] ? xsend[2] : '&emsp;&emsp;&emsp;'))
            examdate = data['examdate']
            if (data['examdate2'] && data['examdate'] != data['examdate2']) {
              examdate = data['examdate'] + ' đến ' + data['examdate2']
            }
            html = html.replace('examdate', examdate)
            html = html.replace('iresend', data['iresend'])
            html = html.replace('xsender', data['xsender'])
            html = html.replace('xreceiver', data['xreceiver'])
            html = html.replace('xresender', data['xresender'])

            global.result = []
            $('.results').each((index, item) => {
              global.result.push(item.value)
            })

            if (trim(data['result'])) {
              html = html.replace('(result)', '<br>- Kết quả: <br>' + global.result.join('<br>'))
            }
            else {
              html = html.replace('(result)', '<br>- Kết quả: .........................................................................................................................................................................................................................<br>..........................................................................................................................................................................................................................................')
            }
            html = html.replace('xtable', parseFieldTable(data['ig']))
            data['note'] = trim(data['note'])
            if (data['note']) {
              html = html.replace('(note)', data['note'].replace(/\n/g, '; ') + '<br>')
            }
            else {
              html = html.replace('(note)', '')
            }
          break;
          case 3:
            if (typeof(data['xcode']) == 'string') {
              data['xcode'] = data['xcode'].split(',')
            }

            html = html.replace('(xexam-signer)', Number(data['signer']['xexam']) ? '<img src="'+ global['signer'][data['signer']['xexam']]['url'] +'">' : '<br><br><br>')
            html = html.replace('(receiveleader-signer)', Number(data['signer']['xresender']) ? '<img src="'+ global['signer'][data['signer']['xresender']]['url'] +'">' : '<br><br><br>')

            html = html.replace('(page)', data['page3'])
            html = html.replace(/xexam/g, data['xexam'])
            html = html.replace(/receiveleader/g, data['xresender'])
            html = html.replace(/xcode-0/g, trim(data['xcode'][0]))
            html = html.replace(/xcode-1/g, trim(data['xcode'][1]))
            html = html.replace(/xcode-2/g, trim(data['xcode'][2]))
            html = html.replace('(page)', trim(data['page']))

            html = html.replace('xtable', parseFieldTable2(data['ig'], data.xcode))
            html = html.replace('(vnote)', data['vnote'].replace(/\n/g, '<br>'))
          break;
          case 4:
            if (typeof(data['xcode']) == 'string') {
              data['xcode'] = data['xcode'].split(',')
            } 

            html = html.replace('(xexam-signer)', Number(data['signer']['xexam']) ? '<img src="'+ global['signer'][data['signer']['xexam']]['url'] +'">' : '<br><br><br>')
            html = html.replace('(xresender-signer)', Number(data['signer']['xresender']) ? '<img src="'+ global['signer'][data['signer']['xresender']]['url'] +'">' : '<br><br><br>')

            var receive = data['receive'].split('/')
            var examdate = data['examdate'].split('/')
            html = html.replace('(page)', data['page4'])
            html = html.replace('(xexam)', data['xexam'])
            html = html.replace('(xresender)', data['xresender'])
            // html = html.replace('page', data['page'])
            html = html.replace(/xcode-0/g, trim(data['xcode'][0]))
            html = html.replace(/xcode-1/g, trim(data['xcode'][1]))
            html = html.replace(/xcode-2/g, trim(data['xcode'][2]))
            html = html.replace('(customer)', data['isenderunit'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['samplecode5'])
            
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(sample)', data['sample'])
            html = html.replace('(receiveHour)', data['receivehour'])
            html = html.replace('(receiveMinute)', data['receiveminute'])
            html = html.replace('(address)', data['address'])
            html = html.replace('(phone)', data['xphone'])
            html = html.replace('(fax)', data['fax'])
            html = html.replace('(type)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            // if (typeof(data['status']) == 'number') {
            //   var temp = data['status']
            //   data['status'] = {}
            //   data['status']['index'] = temp
            // }
            html = html.replace('(status)', ticked[data['status']['index']] + ' yêu cầu xét nghiệm')
            html = html.replace('(sampleReceive)', data['samplereceive'])
            html = html.replace('(sampleReceiver)', data['samplereceiver'])
            html = html.replace('(ireceive)', data['receive'])
            html = html.replace('(ireceiver)', data['ireceiveremploy'])
            examdate = data['examdate']
            xdate = data['examdate']
            if (data['examdate2'] && data['examdate'] != data['examdate2']) {
              examdate = data['examdate'] + ' đến ' + data['examdate2']
              xdate = data['examdate2']
            }
            html = html.replace('(examDate)', examdate)
            examdate = xdate.split('/')

            // html = html.replace('(examDate)', data['examdate'])
            html = html.replace(/examdate-0/g, examdate[0])
            html = html.replace(/examdate-1/g, examdate[1])
            html = html.replace(/examdate-2/g, examdate[2])

            var res = ''
            $('.results').each((index, item) => {
              if (item.value) res += '<p> '+ tabbed + item.value +' </p>'
            })
            html = html.replace('(result)', res)

            var noteString = ''
            if (trim(data['note'])) {
              // (note)
              var note = data['note'].split('\n');
              var notes = []
              note.forEach(item => {
                notes.push('<i>' + item + '</i>')
              })
              noteString += '<i> <b style="float: left; width: 80px;">Ghi chú:</b> </i> <div style="float: left; width: calc(100% - 80px);">' + notes.join('<br>') + '</div>'
            }
            html = html.replace('(note)', noteString)

            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var parse = ''
            var examS = extractExam(data['exam']).length
            var index = 1
            data['exam'].forEach(main => {
              main['exam'].forEach(exam => {
                var temp = part 
                if (examS > 1) {
                  temp = temp.replace('(index)', (index++) + '. ')
                }
                else {
                  temp = temp.replace('(index)', '')
                }
                
                temp = temp.replace('(exam-content)', exam)
                temp = temp.replace('(method)', main['method'])
                temp = temp.replace('(symbol)', main['symbol'])
                parse += temp
              })
            })
            html = html.replace('(parse)', parse)
          break;
          case 5:
            if (typeof(data['xcode']) == 'string') {
              data['xcode'] = data['xcode'].split(',')
            }
            var iresend = data['noticetime'].split('/')
            
            html = html.replace('(receiveleader-signer)', Number(data['signer']['receiveleader']) ? '<img src="'+ global['signer'][data['signer']['receiveleader']]['url'] +'">' : '<br><br><br>')
            
            html = html.replace('xcode-0', trim(data['xcode'][0]))
            html = html.replace('xcode-1', trim(data['xcode'][1]))
            html = html.replace('xcode-2', trim(data['xcode'][2]))
            
            html = html.replace('(code)', data['code'])
            html = html.replace('noticetime-0', iresend[0])
            html = html.replace('noticetime-1', iresend[1])
            html = html.replace('noticetime-2', iresend[2])
            html = html.replace('senderemploy', data['sender'])
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('xaddress', data['xaddress'])
            html = html.replace('samplecode', data['samplecode5'])
            html = html.replace('(examsample)', data['examsample'])
            html = html.replace('samplereceive', data['samplereceive'])
            html = html.replace('(sample)', data['sample'])
            html = html.replace(/sampletime/g, data['receive'])
            html = html.replace('(sampletype)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('number', data['number'])
            
            if (trim(data['target']).length) {
              html = html.replace('target', '<p class="p14"> &emsp;&emsp; Mục đích xét nghiệm: '+ data['target']) +' </p>'
            }
            else {
              html = html.replace('target', '')
            }

            var temp = ''
            if (data['owner']) {
              temp += '<p class="p14"> &emsp;&emsp;&emsp; Chủ hộ: '+data['owner']+'</p>'
            }
            if (data['sampleplace']) {
              temp += '<p class="p14"> &emsp;&emsp;&emsp; Nơi lấy mẫu: '+data['sampleplace']+'</p>'
            }
            if (temp) {
              temp = '<p class="p14"> &emsp;&emsp; Thông tin mẫu:</p>' + temp
            }

            html = html.replace('owner', temp)

            var length = data['exam'].length
            var part = '<p>&emsp;&emsp; (index)(content), Phương pháp xét nghiệm: (method); Ký hiệu phương pháp: (symbol)(dot)</p>'
            var parse = ''
            var examS = extractExam(data['exam']).length
            var index = 1
            
            data['exam'].forEach(main => {
              main['exam'].forEach(exam => {
                var temp = part 
                if (examS > 1) {
                  if (index == examS) {
                    temp = temp.replace('(dot)', '.')
                  }
                  else {
                    temp = temp.replace('(dot)', ';')
                  }
                  temp = temp.replace('(index)', (index ++) + '. ')
                }
                else {
                  temp = temp.replace('(index)', '')
                  temp = temp.replace('(dot)', '.')
                }
                temp = temp.replace('(content)', exam)
                temp = temp.replace('(method)', main['method'])
                temp = temp.replace('(symbol)', main['symbol'])
                parse += temp
              })
            })
            
            html = html.replace('(exam)', parse)
            html = html.replace('(mcode)', data['mcode'])

            var res = ''
            $('.results').each((index, item) => {
              if (item.value) res += '<p> '+ tabbed + item.value +' </p>'
            })
            html = html.replace('result', res)

            // html = html.replace('result', tabbed + data['result'].replace(/\n/g, '<br>' + tabbed))
            var owner = ''
            if (trim(data['ownermail']) || trim(data['ownerphone'])) {
              owner += '<p class="p14"> &emsp;&emsp; Số điện thoại: '+data['ownerphone']+'</p><p class="p14"> &emsp;&emsp; Email: '+data['ownermail']+'</p>'
            }
            html = html.replace('(info)', owner)
            var noteString = ''
            if (trim(data['note'])) {
              // (note)
              var note = data['note'].split('\n');
              var notes = []
              note.forEach(item => {
                notes.push('<i>' + item + '</i>')
              })
              noteString += '<div class="p14"> <i> <b style="float: left; width: 80px;">Ghi chú:</b> </i> <span style="float: left; width: calc(100% - 80px);">' + notes.join('<br>') + '</span></div>'
            }
            if (data['xsign']) {
              html = html.replace('(xsigner)', 'KT CHI CỤC TRƯỞNG<br>PHÓ CHI CỤC TRƯỞNG<br>')
            }
            else {
              html = html.replace('(xsigner)', 'CHI CỤC TRƯỞNG <br>')
            }
            html = html.replace('note', noteString)
            html = html.replace('receivedis', data['receivedis'].replace(/\n/g, '<br>'))
            receiveleader = data['receiveleader']
            // receiveleader = trim().replace(/\b[a-z]/g, function(letter) {
            //   return letter.toUpperCase();
            // });
            html = html.replace('receiveleader', receiveleader)
          break;
        }
        
        var html = '<style>' + style + profile[prop] + '</style>' + html
        var winPrint = window.open(origin + '/index.php?nv=' + nv_module_name + '&hash=' + (new Date()).getTime(), '_blank', 'left=0,top=0,width=800,height=600');
        winPrint.focus()
        winPrint.document.write(html);
        // if (!prev) {
          setTimeout(() => {
            winPrint.print()
            winPrint.close()
          }, 300)
        // }
      }
    }
  }

  function ucword(str) {
  str = str.toLowerCase();
  return str.replace(/(^([a-zA-Z\p{M}]))|([ -][a-zA-Z\p{M}])/g,
  	function(s){
  	  return s.toUpperCase();
	});
};
</script>
<!-- END: main -->