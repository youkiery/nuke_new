<!-- BEGIN: main -->
<div class="modal" id="filter-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group form-inline">
          Số dòng mỗi trang
          <input type="text" class="form-control" id="filter-limit" value="10">
        </div>

        <div class="form-group form-inline">
          Tìm kiếm hàng hóa
          <input type="text" class="form-control" id="filter-keyword" placeholder="Tìm kiếm theo tên hàng">
        </div>

        <div class="form-group">
          Lọc danh sách phòng ban
          <div class="relative">
            <input type="text" class="form-control" id="filter-depart-input">
          </div>
          <div class="suggest" id="filter-depart-suggest"></div>
        </div>
        <span id="filter-depart"></span>

        <div class="form-group text-center">
          <button type="submit" class="btn btn-info" id="d" onclick="goPage(1)">
            Lọc danh sách
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->