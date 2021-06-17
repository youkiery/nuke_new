<!-- BEGIN: main -->
<style>
  @page {
    size: A4 portrait;
    margin: 10mm 15mm;
  }
  * {
    font-size: 14pt;
  }
  p {
    margin: 5pt;
  }
  th, td {
    padding: 5pt;
  }
</style>

<div id="content">
  <div style="float: left; text-align: center;">
    <p>CỤC THÚ Y</p>
    <p style="margin-bottom: 0px;"> <b>CHI CỤC THÚ Y VÙNG V</b> </p>
    <p style="line-height: 0; margin: 0px;"> _________________ </p>
  </div>
  <div style="float: right; text-align: center;">
    <p> <b> CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM </b> </p>
    <p style="margin-bottom: 0px;"> <b> Độc lập - Tự Do - Hạnh phúc </b> </p>
    <p style="line-height: 0px; margin: 0px;"> _________________ </p>
  </div>
  <div style="clear: both;"></div><br><br>
  <p style="text-align: center; font-size: 16pt;"> <b> BẢNG KÊ CHI PHÍ XÉT NGHIỆM </b> </p> <br>
  <p> - Đơn vị nộp phí: <b> Chi cục Chăn nuôi và Thú y  Đăk Lăk </b> </p>
  <p> - Địa chỉ: <b> Số 105 Lê Thị Hồng Gấm, thành phố Buôn Ma Thuột, tỉnh ĐăkLăk </b> </p>
  <p> - Đơn vị thu phí: <b> Chi cục Thú y vùng V </b>  </p>
  <p> - Địa chỉ: <b> Số 36 đường Phạm Hùng,  phường Tân An, thành phố Buôn Ma Thuột, tỉnh Đăk Lăk </b> </p>
  <p>
    <span style="float: left">
      - Điện thoại: <b> 0262 3979791 </b>
    </span>
    <span style="float: left; margin-left: 20pt;">
      - Fax: <b> 0262 3877794 </b>
    </span>
    <span style="margin-left: 20pt;">
      - MST: <b> 6000630820 </b>
    </span>
  </p>
  <span style="clear: both;"></span>
  <p> - Số tài khoản: <b> 5220201004526 tại  Ngân hàng nông nghiệp và PTNT. Chi nhánh Tân Lập - Bắc Đăk Lăk </b> </p>
  <table border="1" style="width: 100%; border-collapse: collapse;">
    <tr>
      <th> STT </th>
      <th style="width: 30%;"> Nội dung thu </th>
      <th style="width: 10%;"> Xác định một serotype </th>
      <th style="width: 9%;"> Số lượng mẫu xét nghiệm </th>
      <th style="width: 30%;">  Thu giá dịch vụ theo Thông tư 283/2016/TT-BTC ngày 14/11/2016 & Quyết định số 29 & 29a/QĐ -TYV5 ngày 30/12/2016 </th>
      <th style="width: 9%;">  Thành tiền  </th>
      <th style="width: 20%;">  Số và ngày thông báo kết quả xét nghiệm </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
      <!-- BEGIN: index -->
      <td style="text-align: center;" rowspan="{row}"> {index} </td>
      <!-- END: index -->
      <td> {result} </td>
      <td style="text-align: center;"> {serotype} </td>
      <td style="text-align: center;"> {number} </td>
      <td style="text-align: center;"> {price} </td>
      <td style="text-align: center;"> {total} </td>
      <!-- BEGIN: datetime -->
      <td style="text-align: center;" rowspan="{row}"> {datetime} </td>
      <!-- END: datetime -->
    </tr>
    <!-- END: row -->
  </table>
</div>
<!-- END: main -->
