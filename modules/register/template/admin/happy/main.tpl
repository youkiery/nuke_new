<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/core/css/style.css">

<div id="msgshow"></div>

{modal}

<form>
  <input type="hidden" name="nv" value="register">
  <input type="hidden" name="op" value="happy">
  <div class="form-group row-x">
    <div class="col-4">
      <input type="text" class="form-control" id="filter-keyword" value="{keyword}" placeholder="Nhập tên người, SĐT">
    </div>
    <div class="col-4">
      <select class="form-control" name="status">
        <option value="0" {active_0}> Tất cả </option>
        <option value="1" {active_1}> Chưa xác nhận </option>
        <option value="2" {active_2}> Đã xác nhận </option>
      </select>
    </div>
    <div class="col-4">
      <button class="btn btn-info">
        Lọc danh sách
      </button>
    </div>
  </div>
</form>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
  var global = {
    id: 0,
    image: []
  }

  function done(id) {
    vhttp.checkelse('', { action: 'done', id: id }).then(data => {
      $("#content").html(data['html'])
    })
  }

  function preview(id) {
    vhttp.checkelse('', { action: 'preview', id: id }).then(data => {
      $("#preview-content").html(data['html'])
      $("#preview-modal").modal('show')
    })
  }

  function edit(id) {
    vhttp.checkelse('', { action: 'get-info', id: id }).then(data => {
      global['id'] = id
      refreshImage(data['data']['image'])
      $("#edit-fullname").val(data['data']['fullname'])
      $("#edit-mobile").val(data['data']['mobile'])
      $("#edit-address").val(data['data']['address'])
      $("#edit-name").val(data['data']['name'])
      $("#edit-species").val(data['data']['species'])
      $("#edit-note").val(data['data']['note'])
      $("#edit-modal").modal('show')
    })
  }

  function checkData() {
    var data = {
      fullname: $("#edit-fullname").val(),
      name: $("#edit-name").val(),
      species: $("#edit-species").val(),
      address: $("#edit-address").val(),
      mobile: $("#edit-mobile").val(),
      note: $("#edit-note").val()
    }
    if (!data.mobile.length) return 'Số điện thoại không được để trống'
    return data
  }

  function editSubmit(id) {
    sdata = checkData()
    if (!sdata['name']) notify(sdata)
    else {
      vhttp.checkelse('', { action: 'edit', data: sdata, id: global['id'] }).then(data => {
        $("#content").html(data['html'])
        $("#edit-modal").modal('hide')
      })
    }
  }

  function refreshImage(list) {
    html = ''
    list.forEach((item, index) => {
      html += `
      <div class="thumb">
        <img src="`+ item + `">
      </div>`
    })
    $("#image-list").html(html)
  }

  function notify(text) {
    $("#notify").show()
    $("#notify").text(text)
    $("#notify").delay(1000).fadeOut(1000)
  }

</script>
<!-- END: main -->