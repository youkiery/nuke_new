<!-- BEGIN: main -->
<div class="modal" id="remove-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Thông tin chi tiết
          <div type="button" class="close" data-dismiss="modal"> &times; </div>
        </div>

        <div class="text-center">
          <p> Sau khi xác nhận, thông tin sẽ bị xóa vĩnh viễn </p>
          <button class="btn btn-danger" onclick="removeSubmit()">
            Xác nhận
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

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

<div class="modal" id="edit-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Chỉnh sửa thông tin
          <div type="button" class="close" data-dismiss="modal"> &times; </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Chủ nuôi </div>
          <div class="col-9">
            <input type="text" class="form-control" id="edit-fullname">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Tên thú cưng </div>
          <div class="col-9">
            <input type="text" class="form-control" id="edit-name">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Giống loài </div>
          <div class="col-9">
            <input type="text" class="form-control" id="edit-species">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Số điện thoại <span style="color:red; font-size: 1.2em">(*)</span> </div>
          <div class="col-9">
            <input type="text" class="form-control" id="edit-mobile">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Địa chỉ </div>
          <div class="col-9">
            <input type="text" class="form-control" id="edit-address">
          </div>
        </div>

        <div class="form-group row-x">
          <div class="col-3"> Ghi chú </div>
          <div class="col-9">
            <textarea class="form-control" id="edit-note" rows="3"></textarea>
          </div>
        </div>

        <div class="text-center form-group">
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

<div class="modal" id="manager-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b style="font-size: 1.5em;"> Tìm kiếm nhân viên </b>
          <div class="close" type="button" data-dismiss="modal"> &times; </div>
        </div>

        <div class="form-group" style="text-align:right;">
          <button class="btn btn-success" onclick="employModal()">
            Thêm quản lý
          </button>
        </div>

        <div id="manager-content">
          {manager_content}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="employ-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b style="font-size: 1.5em;"> Tìm kiếm nhân viên </b>
          <div class="close" type="button" data-dismiss="modal"> &times; </div>
        </div>

        <div class="form-group input-group">
          <input type="text" class="form-control" id="employ-name" placeholder="Nhập tên nhân viên">
          <div class="input-group-btn">
            <button class="btn btn-success" onclick="employFilter()">
              Tìm kiếm
            </button>
          </div>
        </div>

        <div id="employ-content">

        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->