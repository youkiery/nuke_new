<!-- BEGIN: main -->
<div class="modal" id="detail-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div id="detail-content"></div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="remove-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="text-center">
          <p> Sau khi xác nhận hóa chất sẽ biến mất, có chắc chắn? </p>
          <button class="btn btn-danger" onclick="removeItemSubmit()">
            Xác nhận
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="remove-source-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="text-center">
          <p> Sau khi xác nhận, nguồn cung sẽ biến mất, có chắc không? </p>
          <button class="btn btn-danger" onclick="removeSourceSubmit()">
            Xác nhận
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="import-remove-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="text-center">
          <p> Sau khi xác nhận phiếu nhập sẽ biến mất, xác nhận xóa? </p>
          <button class="btn btn-danger" onclick="importRemoveSubmit()">
            Xác nhận
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="export-remove-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="text-center">
          <p> Sau khi xác nhận phiếu xuất sẽ biến mất, xác nhận xóa? </p>
          <button class="btn btn-danger" onclick="exportRemoveSubmit()">
            Xác nhận
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="source-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          Nguồn cung
          <input autocomplete="off" type="text" class="form-control" id="source-name">
        </div>
        <div class="form-group">
          Ghi chú
          <textarea class="form-control" id="source-note" rows="3"></textarea>
        </div>
        <div class="text-center">
          <button class="btn btn-success" id="source-insert" onclick="insertSourceSubmit()">
            Thêm nguồn cung
          </button>
          <button class="btn btn-success" id="source-update" onclick="updateSourceSubmit()">
            Sửa nguồn cung
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="report-modal" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <ul class="nav nav-tabs form-group">
          <li class="active"><a data-toggle="tab" href="#m2"> Hóa chất gần hết </a></li>
          <li><a data-toggle="tab" href="#m3"> Hóa chất sắp hết hạn </a></li>
        </ul>

        <div class="tab-content" id="report-tick">
          <div id="m2" class="tab-pane fade in active">
            <div class="form-group rows">
              <div class="col-6">
                Từ khóa
                <input autocomplete="off" class="form-control" id="report-m2-name" type="text" placeholder="Từ khóa">
              </div>
              <div class="col-6">
                Giới hạn thấp nhất
                <input autocomplete="off" class="form-control" id="report-m2-limit" type="text"
                  placeholder="Giới hạn thấp nhất" value="10">
              </div>
            </div>

            <div id="report-limit-content"> </div>
          </div>
          <div id="m3" class="tab-pane fade">
            <div class="form-group rows">
              <div class="col-6">
                Từ khóa
                <input autocomplete="off" class="form-control" id="report-m3-name" type="text" placeholder="Từ khóa">
              </div>
              <div class="col-6">
                Hết hạn trước
                <input autocomplete="off" class="form-control date" id="report-m3-expire" type="text"
                  placeholder="Hết hạn trước" value="{next_half_year}">
              </div>
            </div>

            <div id="report-expire-content"> </div>
          </div>
        </div>

        <div class="form-group text-center">
          <button class="btn btn-info" onclick="reportSubmit()">
            Thống kê
          </button>
        </div>
        <div id="report-content"></div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="material-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div class="form-horizontal">
          <div class="form-group rows">
            <label class="control-label col-3"> Tên mục hàng </label>
            <div class="col-9">
              <input autocomplete="off" type="text" class="form-control" id="material-name">
            </div>
          </div>
          <div class="form-group rows">
            <label class="control-label col-3"> Đơn vị </label>
            <div class="col-9">
              <input autocomplete="off" type="text" class="form-control" id="material-unit">
            </div>
          </div>
          <div class="form-group rows">
            <label class="control-label col-3"> Mô tả </label>
            <div class="col-9">
              <textarea class="form-control" id="material-description" rows="5"></textarea>
            </div>
          </div>
          <div class="text-center">
            <button class="btn btn-success insert" onclick="insertMaterial()">
              Thêm mục hàng
            </button>
            <button class="btn btn-success update" onclick="updateMaterial()">
              Cập nhật thông tin
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="import-modal-insert" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th class="cell-center"> Hóa chất </th>
                <th class="cell-center"> Ngày nhập </th>
                <th class="cell-center" style="width: 20%;"> Nguồn </th>
                <th class="cell-center"> SL </th>
                <th class="cell-center"> HSD </th>
                <th class="cell-center"> Ghi chú </th>
                <th></th>
              </tr>
            </thead>
            <tbody id="import-insert-modal-content"></tbody>
          </table>
        </div>

        <div class="form-group">
          <button class="btn btn-success btn-edit" onclick="insertLine['import']()">
            <span class="glyphicon glyphicon-plus"></span>
          </button>
        </div>
        <div class="text-center">
          <button class="btn btn-info" id="import-button" onclick="importSubmit()"> Thêm phiếu nhập </button>
          <button class="btn btn-info" id="edit-import-button" onclick="updateImportSubmit()"> Sửa phiếu nhập </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="export-modal-insert" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="relative">
          <label for="export-item-time"> Nhập và chọn hóa chất xuất </label>
          <input autocomplete="off" type="text" class="form-control btn-edit" name="export-item-finder"
            id="export-item-finder">
          <div id="export-item-finder-suggest" class="suggest"></div>
        </div>
        <div style="margin-top: 10px;">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th class="cell-center"> Hóa chất </th>
                <th class="cell-center"> Ngày xuất </th>
                <th class="cell-center" style="width: 20%;"> Nguồn </th>
                <th class="cell-center"> Tồn </th>
                <th class="cell-center"> SL xuất </th>
                <th class="cell-center"> HSD </th>
                <th class="cell-center"> Ghi chú </th>
                <th></th>
              </tr>
            </thead>
            <tbody id="export-insert-modal-content"></tbody>
          </table>
        </div>
        <div class="text-center">
          <button class="btn btn-info" id="export-button" onclick="exportSubmit()"> Thêm phiếu xuất </button>
          <button class="btn btn-info" id="edit-export-button" onclick="updateExportSubmit()"> Sửa phiếu xuất </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->