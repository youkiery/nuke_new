<!-- BEGIN: main -->
<style>
  .rows::after {
    content: "";
    clear: both;
    display: table;
  }

  #msgshow {
    position: fixed;
    top: 0px;
    right: 0px;
    background: white;
    padding: 10px;
    z-index: 100;
    border: 1px solid gray;
    border-top-left-radius: 10px;
    border-bottom-left-radius: 10px;
    display: none;
    z-index: 10000;
  }

  .col-3,
  .col-4,
  .col-6 {
    float: left;
    padding: 0px 5px;
  }

  .col-3 {
    width: 25%;
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

  .table-small,
  td {
    font-size: 0.9em;
  }

  .click {
    cursor: pointer;
    text-decoration: underline;
    color: blue;
  }
</style>
<link rel="stylesheet" type="text/css" href="/assets/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/assets/js/language/jquery.ui.datepicker-vi.js"></script>
<div id="msgshow"></div>

{modal}

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

<div class="rows form-group">
  <div class="col-3">
    <label> Từ ngày </label>
    <input class="form-control date" id="from" value="{from}" autocomplete="off">
  </div>
  <div class="col-3">
    <label> Đến ngày </label>
    <input class="form-control date" id="end" value="{end}" autocomplete="off">
  </div>
  <div class="col-3">
    <label> Theo đơn vị </label>
    <input class="form-control" id="province" autocomplete="off">
  </div>
  <div class="col-3">
    <label> Giói hạn trang </label>
    <select class="form-control" id="limit">
      <option value="10"> 10 </option>
      <option value="20" selected> 20 </option>
      <option value="50"> 50 </option>
      <option value="100"> 100 </option>
      <option value="150"> 150 </option>
      <option value="200"> 200 </option>
    </select>
  </div>
</div>
<div class="row form-group">
  <div class="col-6">
    <label> Theo loại bệnh </label>
    <div class="input-group">
      <input class="form-control form-checkbox" id="disease" autocomplete="off">
      <div class="input-group-btn">
        <button class="btn btn-success" onclick="insertRemind('disease')">
          Thêm
        </button>
      </div>
    </div>
    <ul class="items suggest" id="disease-checkbox"> </ul>
    <div> Đã chọn: <span id="context-disease"> </span> </div>
  </div>
  <div class="col-6">
    <label> Loại động vật </label>
    <div class="input-group">
      <input class="form-control form-checkbox" id="species" autocomplete="off">
      <div class="input-group-btn">
        <button class="btn btn-success" onclick="insertRemind('species')">
          Thêm
        </button>
      </div>
    </div>
    <ul class="items suggest" id="species-checkbox"> </ul>
    <div> Đã chọn: <span id="context-species"></span> </div>
  </div>
</div>
<button class="btn btn-info btn-block" onclick="goPage(1)">
  Thống kê
</button>

<div class="form-group" style="float: right;">
  <button class="btn btn-info" onclick="excel()"> Xuất Excel </button>
</div>

<div style="clear: both;"></div>

<div id="content" style="min-height: 200px;">

</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vcheck.js"></script>
<script>
  var style = '.table-bordered {border-collapse: collapse;}.table-wider td, .table-wider th {padding: 10px;}table {width: 100%;}table td {padding: 5px;}.no-bordertop {border-top: 1px solid white; }.no-borderleft {border-left: 1px solid white; }.c20, .c25, .c30, .c35, .c40, .c45, .c50, .c80 {display: inline-block;}.c20 {width: 19%;}.c25 {width: 24%;}.c30 {width: 29%;}.c35 {width: 34%;}.c40 {width: 39%;}.c45 {width: 44%;}.c50 {width: 49%;}.c80 {width: 79%;}.p11 {font-size: 11pt}.p12 {font-size: 12pt}.p13 {font-size: 13pt}.p14 {font-size: 14pt}.p15 {font-size: 15pt}.p16 {font-size: 16pt}.text-center, .cell-center {text-align: center;}.cell-center {vertical-align: inherit;} p {margin: 5px 0px;}'
  var profile = ['@page { size: A4 portrait; margin: 20mm 10mm 10mm 25mm; }', '@page { size: A4 landscape; margin: 20mm 10mm 10mm 25mm;}']

  var checkList = document.getElementById('list1');
  var global = {
    id: '',
    disease: JSON.parse('{disease}'),
    species: JSON.parse('{species}'),
    select: ''
  }

  $(document).ready(() => {
    vcheck.install('#species', '#species-checkbox', 'species', (input) => { return install(input, 'species') }, 300, 300, 1)
    vcheck.install('#disease', '#disease-checkbox', 'disease', (input) => { return install(input, 'disease') }, 300, 300, 1)

    $("#species-checkbox").html(search('', 'species'))
    $("#disease-checkbox").html(search('', 'disease'))

    $('.date').datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function excel() {
    $('#excel').modal('show')
  }

  function preview(id) {
    vhttp.check('', {
      action: 'preview',
      id: id
    }).then(resp => {
      var html = '<style>' + style + profile[0] + '</style>' + resp.html
      var winPrint = window.open(origin + '/index.php?nv=' + nv_module_name + '&hash=' + (new Date()).getTime(), '_blank', 'left=0,top=0,width=800,height=600');
      winPrint.focus()
      winPrint.document.write(html);
      setTimeout(() => {
        winPrint.print()
        winPrint.close()
      }, 300)
    })
  }

  function insertRemind(name) {
    global.id = name
    $('#remind').val('')
    $('#remind-modal').modal('show')
  }

  function insertRemindSubmit() {
    vhttp.check('', {
      action: 'insert-remind',
      name: global.id,
      remind: $('#remind').val()
    }).then(resp => {
      global[global.id] = resp.data
      keyword = $('#' + global.id).val()
      $('#' + global.id + '-checkbox').html(search(keyword, global.id))
      $('#remind-modal').modal('hide')
    }, (e) => {
      alert_msg(e.messenger)
    })
  }

  function install(key, name) {
    return new Promise(resolve => {
      var html = search(key, name)
      resolve(html)
    })
  }

  function search(key, name) {
    html = ''
    key = xoa_dau(key)
    global[name].forEach((item, index) => {
      if (item.alias.search(key) >= 0)
        html += '<li> <label> <input class="' + name + '-checkbox" type="checkbox" onchange="reload(event, \''+ name +'\')" value="' + index + '" ' + (item.checked ? 'checked' : '') + '> ' + item.name + '</label> </li>'
    })
    return html
  }

  function alert_msg(msg) {
    $('#msgshow').html(msg); 
    $('#msgshow').show('slide').delay(2000).hide('slow'); 
  }

  function reload(e, name) {
    var index = e.currentTarget.value
    global[name][index].checked = e.currentTarget.checked      
    var list = []
    global[name].forEach(item => {
      if (item.checked) list.push(item.name)
    })

    $('#context-'+ name).text(list.join(', '))
  }

  function download() {
    var link = '/form/?excel=1&excelf=' + $('#from').val() + '&excelt=' + $('#end').val() + '&data=' + (checkExcel().join(','))
    window.open(link)
  }

  function checkExcel() {
    var list = []
    $('.po').each((index, checkbox) => {
      if (checkbox.checked) {
        list.push(checkbox.getAttribute('id'))
      }
    })
    return list
  }

  function goPage(page) {
    var species = []
    global.species.forEach(item => {
      if (item.checked) species.push(item.name)
    })

    var disease = []
    global.disease.forEach(item => {
      if (item.checked) disease.push(item.name)
    })

    vhttp.checkelse('', {
      page: page,
      action: 'filter',
      limit: $('#limit').val(),
      from: $('#from').val(),
      end: $('#end').val(),
      province: $('#province').val(),
      disease: disease,
      species: species,
    }).then(resp => {
      $('#content').html(resp.html)
    })
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