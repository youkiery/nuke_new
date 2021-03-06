<!-- BEGIN: main -->
<div class="modal" id="preview-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Thông tin chi tiết
          <div type="button" class="close" data-dismiss="modal"> &times; </div>
        </div>

        <div id="preview-content">

        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Chỉnh sửa thông tin
          <div type="button" class="close" data-dismiss="modal"> &times; </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Họ tên </div>
          <div class="col-9">
            <input type="text" class="form-control" id="fullname">
          </div>
        </div>
        
        <div class="form-group row-x">
          <div class="col-3"> Địa chỉ </div>
          <div class="col-9">
            <input type="text" class="form-control" id="address">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Số điện thoại <span style="color:red; font-size: 1.2em">(*)</span> </div>
          <div class="col-9">
            <input type="text" class="form-control" id="mobile">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Ghi chú </div>
          <div class="col-9">
            <textarea class="form-control" id="note" rows="3"></textarea>
          </div>
        </div>

        <div class="text-center">
          <span id="image-list"></span>
        </div>

        <div style="clear: both;"></div>
        <div class="text-center">
          <button class="btn btn-success" onclick="editSubmit()">
            Chỉnh sửa thông tin
          </button>
          <div id="notify" style="color: red; font-size: 1.3em; font-weight: bold;"> </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->