<!-- BEGIN: main -->
<div class="modal" id="salary-up-modal" role="dialog">
  <div class="modal-dialog modal-fade">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Nâng lương
          <div class="close" role="button" data-dismiss="modal"> &times; </div>
        </div>

        <form onsubmit="return salaryUp(event)">
          <div class="form-group">
            <label> Họ và tên </label>
            <div class="relative">
              <input type="text" class="form-control" id="salary-up-name" required>
              <div class="suggest" id="salary-up-name-suggest"></div>
            </div>
          </div>
          <div class="rows">
            <div class="form-group col-6">
              <label> Ngày nâng lương </label>
              <div class="input-group">
                <input type="text" class="form-control date" id="salary-up-time" value="{time}">
                <div class="input-group-addon"></div>
              </div>
            </div>
            <div class="form-group col-6">
              <label> Ngày nâng lương kế </label>
              <div class="input-group">
                <input type="text" class="form-control date" id="salary-up-next-time" value="{next_salary_time}">
                <div class="input-group-addon"></div>
              </div>
            </div>
          </div>
          <div class="rows">
            <div class="form-group col-6">
              <label> Bậc lương </label>
              <select class="form-control" id="salary-up-level">
                <!-- BEGIN: const -->
                <option value="{value}"> {name} </option>
                <!-- END: const -->
              </select>
            </div>
            <div class="form-group col-6">
              <label> Hệ số lương </label>
              <p id="salary-up-level-const" style="margin: 0px; color: red;">  </p>
            </div>
          </div>
          <div class="form-group">
            <label> Hình thức khen thưởng </label>
            <div class="relative">
              <input type="text" class="form-control" id="salary-up-formal">
              <div class="suggest" id="salary-up-formal-suggest"></div>
            </div>
          </div>
          <div class="form-group">
            <label> 
              File
              <input type="file" id="salary-up-file" onchange="pickFile()" >
            </label>
          </div>
          <div class="form-group">
            <label> Ghi chú </label>
            <textarea class="form-control" id="salary-up-note" rows="4"></textarea>
          </div>

          <button class="btn btn-info btn-block insert">
            Nâng lương
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="promo-up-modal" role="dialog">
  <div class="modal-dialog modal-fade">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Bổ nhiệm
          <div class="close" role="button" data-dismiss="modal"> &times; </div>
        </div>

        <form onsubmit="return promoUp(event)">
          <div class="form-group">
            <label> Họ và tên </label>
            <div class="relative">
              <input type="text" class="form-control" id="promo-up-name" required>
              <div class="suggest" id="promo-up-name-suggest"> </div>
            </div>
          </div>
          <div class="rows">
            <div class="form-group col-6">
              <label> Ngày bổ nhiệm </label>
              <div class="input-group">
                <input type="text" class="form-control date" id="promo-up-time" value="{time}">
                <div class="input-group-addon"></div>
              </div>
            </div>
            <div class="form-group col-6">
              <label> Ngày bổ nhiệm kế </label>
              <div class="input-group">
                <input type="text" class="form-control date" id="promo-up-next-time" value="{next_promo_time}">
                <div class="input-group-addon"></div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label> 
              File
              <input type="file" id="promo-up-file" onchange="pickFile()" >
            </label>
          </div>
          <div class="form-group">
            <label> Ghi chú </label>
            <textarea class="form-control" id="promo-up-note" rows="4"></textarea>
          </div>

          <button class="btn btn-info btn-block">
            Bổ nhiệm
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- <div class="modal" id="history-modal" role="dialog">
  <div class="modal-dialog modal-fade modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Bổ nhiệm
          <div class="close" role="button" data-dismiss="modal"> &times; </div>
        </div>

        <div id="history-content"> </div>
      </div> 
    </div>
  </div>
</div> -->

<div class="modal" id="remove-modal" role="dialog">
  <div class="modal-dialog modal-fade modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Cảnh báo
          <div class="close" role="button" data-dismiss="modal"> &times; </div>
        </div>

        <div class="text-center">
          <p> Xóa nhân viên đồng thời sẽ xóa toàn bộ dữ liệu liên quan </p>
          <button class="btn btn-danger" onclick="remove()">
            Xác nhận
          </button>
        </div>
      </div> 
    </div>
  </div>
</div>
<!-- END: main -->