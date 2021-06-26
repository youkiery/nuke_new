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
  }

  .dropdown-check-list .anchor {
    position: relative;
    cursor: pointer;
    display: inline-block;
    padding: 5px 50px 5px 10px;
    width: 100%;
  }

  .dropdown-check-list .anchor:after {
    position: absolute;
    content: "";
    border-left: 2px solid black;
    border-top: 2px solid black;
    padding: 5px;
    right: 10px;
    top: 20%;
    -moz-transform: rotate(-135deg);
    -ms-transform: rotate(-135deg);
    -o-transform: rotate(-135deg);
    -webkit-transform: rotate(-135deg);
    transform: rotate(-135deg);
  }

  .dropdown-check-list .anchor:active:after {
    right: 8px;
    top: 21%;
  }

  .dropdown-check-list ul.items {
    padding: 2px;
    display: none;
    margin: 0;
    border: 1px solid #ccc;
    border-top: none;
  }

  .dropdown-check-list ul.items li {
    list-style: none;
  }

  .dropdown-check-list.visible .anchor {
    color: #0094ff;
  }

  .dropdown-check-list.visible .items {
    display: block;
    max-height: 200px;
    background: white;
    overflow: scroll;
  }
  .items label {
    width: 100%;
    border-top: 1px solid lightgray;
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
    <label> Loại động vật </label>
    <div id="list1" class="form-control dropdown-check-list col-4" tabindex="100">
      <span class="anchor"> Chọn loại động vật </span>
      <ul class="items">
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
    checkList.getElementsByClassName('anchor')[0].onclick = function (evt) {
      if (checkList.classList.contains('visible'))
        checkList.classList.remove('visible');
      else
        checkList.classList.add('visible');
    }
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

    vhttp.checkelse('', {
      action: 'filter',
      from: $('#from').val(),
      end: $('#end').val(),
      province: $('#province').val(),
      disease: $('#disease').val(),
      species: species,
    }).then(resp => {
      $('#content').html(resp.html)
    })
    return false
  }
</script>
<!-- END: main -->