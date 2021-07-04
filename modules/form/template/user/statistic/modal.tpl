<!-- BEGIN: main -->
<div class="modal" id="excel" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
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
        <label style="width: 30%"> <input type="checkbox" class="po" id="xresender"> Người phụ trách bộ phận xét nghiệm
        </label>
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
    </div>
  </div>
</div>
<!-- END: main -->