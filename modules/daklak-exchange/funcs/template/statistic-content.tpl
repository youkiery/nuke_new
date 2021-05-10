<!-- BEGIN: main -->
<link rel="stylesheet" href="/assets/css/style.css">
<link rel="stylesheet" type="text/css" href="/assets/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/assets/js/language/jquery.ui.datepicker-vi.js"></script>

<a href="/daklak-exchange/" class="btn btn-default"> 
  Hàng hóa
</a>
<a href="/daklak-exchange/import" class="btn btn-default"> 
  Phiếu nhập
</a>
<a href="/daklak-exchange/export" class="btn btn-default"> 
  Phiếu xuất
</a>
<a href="/daklak-exchange/statistic" class="btn btn-primary"> 
  Thống kê
</a>

<!--
  Chọn thời gian
  Tổng nhập
  Tổng xuất
  Tổng lợi nhuận
-->
<div class="form-group"></div>
<div id="content">
  <p> <b> Tổng toa nhập: </b> {import_count} </p>
  <p> <b> Tổng tiền nhập: </b> {import} </p>
  <p> <b> Tổng toa xuất: </b> {export_count} </p>
  <p> <b> Tổng tiền xuất: </b> {export} </p>
  <p> <b> Lợi nhuận: </b> {total} </p>
</div>

<!-- END: main -->