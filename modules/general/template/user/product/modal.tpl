<!-- BEGIN: main -->
<div id="item-modal" class="modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Hàng hóa
          <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Mã hàng </div>
          <div class="col-8">
            <input type="text" class="form-control" id="item-code">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Tên hàng </div>
          <div class="col-8">
            <input type="text" class="form-control" id="item-name">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Giá </div>
          <div class="col-8">
            <input type="number" class="form-control" id="item-price">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Chuyển đổi </div>
          <div class="col-4">
            <div class="relative">
              <input type="text" class="form-control" id="item-parent" placeholder="parent">
              <div class="suggest" id="item-parent-suggest"></div>
            </div>
          </div>
          <div class="col-4">
            <input type="number" class="form-control" id="item-value" placeholder="value">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Giới hạn </div>
          <div class="col-4">
            <input type="number" class="form-control" id="item-down" placeholder="lấy hàng">
          </div>
          <div class="col-4">
            <input type="number" class="form-control" id="item-up" placeholder="nhập hàng">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Vị trí kho </div>
          <div class="col-8">
            <input type="text" class="form-control" id="item-position">
          </div>
        </div>

        <label style="width: 100px; height: 100px;">
          <div style="margin: auto; width: 100px; height: 100px; border: 1px solid lightgray;">
            <img style="width: 100px; height: 100px;" id="item-image">
            <input type="file" id="item-image-file" style="display: none;" onchange="selectImage('item-image')">
          </div>
        </label>

        <div class="form-group"></div>

        <button class="btn btn-success btn-block" onclick="insertItemSubmit()">
          Thêm mặt hàng
        </button>
      </div>
    </div>
  </div>
</div>

<div id="item-update-modal" class="modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Cập nhật hàng hóa
          <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Mã hàng </div>
          <div class="col-8">
            <input type="text" class="form-control" id="item-update-code">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Tên hàng </div>
          <div class="col-8">
            <input type="text" class="form-control" id="item-update-name">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Giá </div>
          <div class="col-8">
            <input type="number" class="form-control" id="item-update-price">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Chuyển đổi </div>
          <div class="col-4">
            <div class="relative">
              <input type="text" class="form-control" id="item-update-parent" placeholder="parent">
              <div class="suggest" id="item-update-parent-suggest"></div>
            </div>
          </div>
          <div class="col-4">
            <input type="number" class="form-control" id="item-update-value" placeholder="value">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Giới hạn </div>
          <div class="col-4">
            <input type="number" class="form-control" id="item-update-down" placeholder="lấy hàng">
          </div>
          <div class="col-4">
            <input type="number" class="form-control" id="item-update-up" placeholder="nhập hàng">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-4"> Vị trí kho </div>
          <div class="col-8">
            <input type="text" class="form-control" id="item-update-position">
          </div>
        </div>

        <label style="width: 100px; height: 100px;">
          <div style="margin: auto; width: 100px; height: 100px; border: 1px solid lightgray;">
            <img style="width: 100px; height: 100px;" id="item-update-image">
            <input type="file" id="item-update-image-file" style="display: none;" onchange="selectImage('item-update-image')">
          </div>
        </label>

        <div class="form-group"></div>

        <button class="btn btn-success btn-block" onclick="updateItemSubmit()">
          Cập nhật thông tin
        </button>
      </div>
    </div>
  </div>
</div>

<div id="statistic-modal" class="modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Thống kê
          <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>
        </div>

        <div class="form-group rows">
          <div class="col-3">
            <input type="text" class="form-control" id="statistic-keyword" placeholder="Tìm kiếm theo tên">
          </div>
          <div class="col-6">
            <div class="relative">
              <input type="text" class="form-control" id="statistic-tag"
                placeholder="VD: dây dắt, vòng cổ, xích inox, cổ xanh đỏ đen,...">
              <div class="suggest" id="statistic-tag-suggest"></div>
            </div>
          </div>
          <div class="col-3">
            <button class="btn btn-info" onclick="statisticContent()">
              Thống kê
            </button>
          </div>
        </div>

        <div id="statistic-content"></div>
      </div>
    </div>
  </div>
</div>

<div id="update-modal" class="modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

        <div class="text-center" id="insert-box" style="margin: auto;">
          <label class="filebutton">
            <div class="upload">
              +
            </div>

            <span>
              <input type="file" id="insert-file" style="display: none;"
                accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
            </span>
          </label>
          <br>
          Chọn file Excel
          <br>
          <label>
            <input type="checkbox" id="insert-check"> Thêm mặt hàng chưa có
          </label>
          <br>
          <button class="btn btn-info" onclick="excel()">
            Tải excel
          </button>
          <br>
          <button class="btn btn-info" onclick="process('insert')">
            Xử lý
          </button>
          <div id="insert-notify" class="error"></div>
        </div>

      </div>
    </div>
  </div>
</div>
<!-- END: main -->
