<!-- BEGIN: main -->
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
            <input type="text" class="form-control" id="statistic-tag" placeholder="VD: dây dắt, vòng cổ, xích inox, cổ xanh đỏ đen,...">
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


<div id="product-modal" class="modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Chỉnh sửa mặt hàng
          <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>
        </div>

        <p>
          <b> Mã hàng: </b> <span id="product-code"></span>
        </p>
        <p>
          <b> Tên hàng: </b> <span id="product-name"></span>
        </p>
        <div class="form-group rows">
          <div class="col-3"> Giới hạn </div>
          <div class="col-9">
            <input type="text" class="form-control" id="product-low">
          </div>
        </div>

        <div class="form-group rows">
          <div class="col-3"> Tag </div>
          <div class="col-9">
            <div class="input-group">
              <input type="text" class="form-control" id="product-tag"
                placeholder="VD: dây dắt, vòng cổ, xích inox, cổ xanh đỏ đen,...">
              <div class="input-group-btn">
                <button class="btn btn-success" onclick="insertTag()">thêm</button>

              </div>
            </div>
            <div style="margin-top: 5px;" id="product-tag-list"></div>
          </div>
        </div>

        <div class="text-center">
          <button class="btn btn-info" onclick="editProductSubmit()">
            Cập nhật
          </button>
        </div>
      </div>
    </div>
  </div>
</div>


<div id="insert-modal" class="modal" role="dialog">
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