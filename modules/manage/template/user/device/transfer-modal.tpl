<!-- BEGIN: main -->
<div class="modal" id="transfer-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <p> Chọn phòng ban chuyển thiết bị đến </p>
        <div id="transfer-content">
          <select class="form-control form-group" id="transfer-depart">
            <!-- BEGIN: depart -->
            <option value="{id}"> {name} </option>
            <!-- END: depart -->
          </select>
        </div>

        <div class="form-group text-center">
          <button type="submit" class="btn btn-success" onclick="transferSubmit()"> Chuyển đơn vị </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->