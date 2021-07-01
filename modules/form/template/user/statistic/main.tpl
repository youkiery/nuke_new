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

  .table-small, td {
    font-size: 0.9em;
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
      <input class="form-control form-checkbox" id="disease">
      <ul class="items suggest" id="disease-checkbox"> </ul>
    </div>
    <div class="col-6">
      <label> Loại động vật </label>
      <input class="form-control form-checkbox" id="species">
      <ul class="items suggest" id="species-checkbox">
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
<script src="/modules/core/js/vcheck.js"></script>
<script>
  var checkList = document.getElementById('list1');
  var global = {
    disease: JSON.parse('{disease}'),
    species: JSON.parse('{species}'),
    select: ''
  }

  $(document).ready(() => {
    vcheck.install('#species', '#species-checkbox', 'species', (input) => { return install(input, 'species')}, 300, 300, 1)
    vcheck.install('#disease', '#disease-checkbox', 'disease', (input) => { return install(input, 'disease')}, 300, 300, 1)

    $('.date').datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function install(key, name) {
    return new Promise(resolve => {
      var html = ''
      key = xoa_dau(key)
      global[name].forEach((item, index) => {
        if (item.alias.search(key) >= 0)
            html += '<li> <label> <input class="' + name + '-checkbox" type="checkbox" value="' + index + '" '+ ( item.checked ? 'checked' : '' ) +'> ' + item.name + '</label> </li>'
      })
      resolve(html)
    })
  }

  function filter(e) {
    e.preventDefault()
    var species = []
    global.species.forEach(item => {
      if (item.checked) species.push(item.name)
    })
    
    var disease = []
    global.disease.forEach(item => {
      if (item.checked) disease.push(item.name)
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

  function xoa_dau(str) {
    str = str.toLowerCase()
    str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
    str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
    str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
    str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
    str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
    str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
    str = str.replace(/đ/g, "d");
    return str;
  }
</script>
<!-- END: main -->