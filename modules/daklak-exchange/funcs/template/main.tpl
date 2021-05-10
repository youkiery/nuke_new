<!-- BEGIN: main -->
<link rel="stylesheet" href="/assets/css/style.css">

<div id="insert-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm hàng hóa </h4>
      </div>

      <div class="modal-body">
        <div class="rows form-group">
          <div class="col-3"> <label> Mã hàng </label> </div>
          <div class="col-9"> <input type="text" class="form-control" id="insert-code"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Tên hàng </label> </div>
          <div class="col-9"> <input type="text" class="form-control" id="insert-name"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Đơn vị </label> </div>
          <div class="col-9"> <input type="text" class="form-control" id="insert-unit"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Giá vốn </label> </div>
          <div class="col-9"> <input type="number" class="form-control" id="insert-buy-price"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Giá bán </label> </div>
          <div class="col-9"> <input type="number" class="form-control" id="insert-sell-price"> </div>
        </div>

        <div class="error" id="insert-error"></div>

        <button class="btn btn-success btn-block" onclick="insertSubmit()">
          Thêm hàng hóa
        </button>
      </div>
    </div>
  </div>
</div>

<div id="update-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Cập nhật hàng hóa </h4>
      </div>

      <div class="modal-body">
        <div class="rows form-group">
          <div class="col-3"> <label> Mã hàng </label> </div>
          <div class="col-9"> <input type="text" class="form-control" id="update-code"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Tên hàng </label> </div>
          <div class="col-9"> <input type="text" class="form-control" id="update-name"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Đơn vị </label> </div>
          <div class="col-9"> <input type="text" class="form-control" id="update-unit"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Giá vốn </label> </div>
          <div class="col-9"> <input type="number" class="form-control" id="update-buy-price"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Giá bán </label> </div>
          <div class="col-9"> <input type="number" class="form-control" id="update-sell-price"> </div>
        </div>

        <div class="error" id="update-error"></div>

        <button class="btn btn-info btn-block" onclick="updateSubmit()">
          Cập nhật
        </button>
      </div>
    </div>
  </div>
</div>

<a href="/daklak-exchange/" class="btn btn-primary"> 
  Hàng hóa
</a>
<a href="/daklak-exchange/import" class="btn btn-default"> 
  Phiếu nhập
</a>
<a href="/daklak-exchange/export" class="btn btn-default"> 
  Phiếu xuất
</a>
<a href="/daklak-exchange/statistic" class="btn btn-default"> 
  Thống kê
</a>

<button class="btn btn-success" style="float: right;" onclick="insertModal()">
  Thêm sản phẩm
</button>

<div class="form-group" style="clear: right;"> </div>

<div id="content">
  {content}
</div>
{nav}

<script src="/modules/core/js/vhttp.js"></script>
<script>
  var global = {
    id: 0
  }

  function insertModal() {
    $('#insert-code').val('')
    $('#insert-name').val('')
    $('#insert-unit').val('')
    $('#insert-sell-price').val(0)
    $('#insert-buy-price').val(0)
    $('#insert-modal').modal('show')
  }

  function insertSubmit() {
    data = {
      'code': $('#insert-code').val(),
      'name': $('#insert-name').val(),
      'unit': $('#insert-unit').val(),
      'sell_price': $('#insert-sell-price').val(),
      'buy_price': $('#insert-buy-price').val(),
    }

    vhttp.check('', {
      action: 'insert-product',
      data: data
    }).then(response => {
      $('#content').html(response.data)
      $('#insert-modal').modal('hide')
    }, (error) => {
      alert('insert-error', error.msg)
    })
  }

  function update(id) {
    global.id = id

    vhttp.checkelse('', {
      action: 'get-product',
      id: global.id,
    }).then(response => {
      data = response.data
      $('#update-code').val(data['code'])
      $('#update-name').val(data['name'])
      $('#update-unit').val(data['unit'])
      $('#update-sell-price').val(data['sell_price'])
      $('#update-buy-price').val(data['buy_price'])
      $('#update-modal').modal('show')
    })
  }

  function updateSubmit() {
    data = {
      'code': $('#update-code').val(),
      'name': $('#update-name').val(),
      'unit': $('#update-unit').val(),
      'sell_price': $('#update-sell-price').val(),
      'buy_price': $('#update-buy-price').val(),
    }

    vhttp.check('', {
      action: 'update-product',
      id: global.id,
      data: data
    }).then(response => {
      $('#content').html(response.data)
      $('#update-modal').modal('hide')
    }, (error) => {
      alert('update-error', error.msg)
    })
  }

  function alert(id, msg) {
    $('#'+ id).text(msg)
    $('#'+ id).show()
    $('#'+ id).fadeOut(2000)
  }
</script>
<!-- END: main -->
