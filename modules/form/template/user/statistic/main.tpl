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

  .dropdown-check-list {
    display: inline-block;
    position: relative;
  }

  ul.items {
    display: none;
    position: absolute;
    width: inherit;
    max-height: 200px;
    background: white;
    overflow-y: scroll;
    padding: 0px;
  }

  .items label {
    width: 100%;
    border-top: 1px solid lightgray;
    white-space: nowrap;
    overflow: hidden;
    font-size: 0.8em;
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
    <div class="col-4">
      <label> Từ ngày </label>
      <input class="form-control date" id="from" value="{from}">
    </div>
    <div class="col-4">
      <label> Đến ngày </label>
      <input class="form-control date" id="end" value="{end}">
    </div>
    <div class="col-4">
      <label> Theo đơn vị </label>
      <input class="form-control" id="province">
    </div>
  </div>
  <div class="row form-group">
    <div class="col-6">
      <label> Theo loại bệnh </label>
      <input class="form-control dropdown-check-list" ref="disease" tabindex="100">
      <ul class="items" id="disease">
        <!-- BEGIN: disease -->
        <li> <label> <input class="dis" type="checkbox" value="{name}" /> {name}</label> </li>
        <!-- END: disease -->
      </ul>
    </div>
    <div class="col-6">
      <label> Loại động vật </label>
      <input class="form-control dropdown-check-list" ref="species" tabindex="100">
      <ul class="items" id="species">
        <!-- BEGIN: species -->
        <li> <label> <input class="spc" type="checkbox" value="{name}" /> {name}</label> </li>
        <!-- END: species -->
      </ul>
    </div>
  </div>
  <button class="btn btn-info btn-block">
    Thống kê
  </button>
</form>

<div id="content" style="min-height: 200px;">

</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
  var checkList = document.getElementById('list1');

  $(document).ready(() => {
    $(document).mouseup(function (e) {
      var container = $(".items")
      if (!container.is(e.target) && container.has(e.target).length === 0) {
        $('.items').hide()
      }
    })

    $('.dropdown-check-list').keyup((e) => {
      var ref = e.currentTarget.getAttribute('ref')
    })

    $('.dropdown-check-list').click((e) => {
      var ref = e.currentTarget.getAttribute('ref')
      if ($('#'+ ref).css('display') == 'block') $('#'+ ref).hide()
      else $('#'+ ref).show()
    })
    $('.date').datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function filter(e) {
    e.preventDefault()
    var species = []
    $('.spc:checked').each((index, item) => {
      species.push(item.value)
    })
    var disease = []
    $('.dis:checked').each((index, item) => {
      disease.push(item.value)
    })

    vhttp.checkelse('', {
      action: 'filter',
      from: $('#from').val(),
      end: $('#end').val(),
      province: $('#province').val(),
      disease: disease,
      species: species,
    }).then(resp => {
      $('#content').html(resp.html)
    })
    return false
  }
</script>
<!-- END: main -->