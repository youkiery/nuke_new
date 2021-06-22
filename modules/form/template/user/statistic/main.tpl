<!-- BEGIN: main -->
<style>
  .rows::after {
    content: "";
    clear: both;
    display: table;
  }

  .col-4,
  .col-6 {
    float: left;
    padding: 0px 5px;
  }

  .col-4 {
    width: 33.33%;
  }

  .col-6 {
    width: 50%;
  }
</style>
<link rel="stylesheet" type="text/css" href="/assets/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/assets/js/language/jquery.ui.datepicker-vi.js"></script>

<ul class="nav nav-tabs">
  <!-- BEGIN: user -->
  <li><a href="/form/#home"> Danh sách </a></li>
  <!-- END: user -->
  <!-- BEGIN: super_user -->
  <li><a href="/form/#menu1"> Thêm văn bản </a></li>
  <!-- END: super_user -->
  <li><a href="/form/#menu2"> Xuất ra excel </a></li>
  <!-- BEGIN: secretary -->
  <li><a href="/form/lp1"> Kế toán </a></li>
  <!-- END: secretary -->
  <!-- BEGIN: printx -->
  <li><a href="/form/#menu4"> Văn thư </a></li>
  <!-- END: printx -->
  <li class="active"><a href="/form/statistic"> Thống kê </a></li>
</ul>

<form class="form-group" onsubmit="return filter(event)">
  <div class="rows form-group">
    <div class="col-6">
      <label> Từ ngày </label>
      <input class="form-control date" id="from" value="{from}">
    </div>
    <div class="col-6">
      <label> Đến ngày </label>
      <input class="form-control date" id="end" value="{end}">
    </div>
  </div>
  <div class="row form-group">
    <div class="col-4">
      <label> Theo đơn vị </label>
      <input class="form-control" id="province">
    </div>
    <div class="col-4">
      <label> Theo loại bệnh </label>
      <input class="form-control" id="disease">
    </div>
    <div class="col-4">
      <label> Loại động vật </label>
      <select class="form-control" id="species">
        <!-- BEGIN: species -->
        <option value="{name}"> {name} </option>
        <!-- END: species -->
      </select>
    </div>
  </div>
  <button class="btn btn-info btn-block">
    Thống kê
  </button>
</form>

<div id="content">

</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
  $('.date').datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function filter(e) {
    e.preventDefault()

    vhttp.checkelse('', {
      action: 'filter',
      from: $('#from').val(),
      end: $('#end').val(),
      province: $('#province').val(),
      disease: $('#disease').val(),
      species: $('#species').val(),
    }).then(resp => {
      $('#content').html(resp.html)
    })
    return false
  }
</script>
<!-- END: main -->