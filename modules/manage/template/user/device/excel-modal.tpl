<!-- BEGIN: main -->
<div class="modal" id="excel-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <p> Chọn phòng ban xuất excel </p>
        <select class="form-control form-group" id="excel-depart">
          <!-- BEGIN: depart -->
          <option value="{id}"> {name} </option>
          <!-- END: depart -->
        </select>

        <div class="form-group text-center">
          <button type="submit" class="btn btn-success" onclick="excelDepartSelected()"> Xuất excel phòng ban </button>
          <button type="submit" class="btn btn-success" onclick="excelAll()"> Xuất excel tất cả phòng ban </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->
