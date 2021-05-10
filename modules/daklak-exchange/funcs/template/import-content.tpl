<!-- BEGIN: main -->
<link rel="stylesheet" href="/assets/css/style.css">
<link rel="stylesheet" type="text/css" href="/assets/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/assets/js/language/jquery.ui.datepicker-vi.js"></script>

<div id="remove-modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Xóa phiếu nhập </h4>
      </div>

      <div class="modal-body text-center">
        <p> Xóa phiếu nhập sẽ không thể khôi phục </p>
        <button class="btn btn-danger" onclick="removeSubmit()">
          Xác nhận
        </button>
      </div>
    </div>
  </div>
</div>

<div id="insert-modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm phiếu nhập </h4>
      </div>

      <div class="modal-body">
        <div class="rows">
          <div class="col-9">
            <div class="form-group">
              <div class="relative">
                <div class="input-group">
                  <input type="text" class="form-control" id="insert-item">
                  <div class="input-group-btn">
                    <button class="btn btn-success" onclick="insertItemModal()">
                      thêm sản phẩm
                    </button>
                  </div>
                </div>
                <div class="suggest" id="insert-item-suggest"> </div>
              </div>
            </div>
    
            <div class="error" id="insert-error"></div>
    
            <div style="height: 500px; overflow-y: scroll;">
              <table class="table table-bordered">
                <tr>
                  <th> </th>
                  <th> Mã hàng </th>
                  <th> Tên hàng </th>
                  <th> Giá </th>
                  <th> Số lượng </th>
                  <th> Thành tiền </th>
                </tr>
                <tbody id="insert-content"></tbody>
              </table>
            </div>
          </div>
          <div class="col-3" style="padding-left: 5px;">
            <div class="form-group">
              <div class="relative">
                <div class="input-group">
                  <input type="text" class="form-control" id="insert-source" placeholder="Nhập nguồn cung cấp">
                  <div class="input-group-btn">
                    <button class="btn btn-success" onclick="insertSourceModal()">
                      thêm
                    </button>
                  </div>
                </div>
                <div class="suggest" id="insert-source-suggest"> </div>
              </div>
            </div>

            <div> Nguồn cung: <span id="item-source"></span></div>
            <div> Tổng tiền: <span id="item-total"></span></div>
          </div>
        </div>
        <button class="btn btn-success btn-block" id="insert-button" onclick="insertSubmit()">
          Thêm phiếu nhập
        </button>
        <button class="btn btn-info btn-block" id="update-button" onclick="updateSubmit()" style="display: none;">
          Sửa phiếu nhập
        </button>
      </div>
    </div>
  </div>
</div>


<div id="insert-item-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm hàng hóa </h4>
      </div>

      <div class="modal-body">
        <div class="rows form-group">
          <div class="col-3"> <label> Mã hàng </label> </div>
          <div class="col-9"> <input type="text" class="form-control" id="insert-item-code"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Tên hàng </label> </div>
          <div class="col-9"> <input type="text" class="form-control" id="insert-item-name"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Đơn vị </label> </div>
          <div class="col-9"> <input type="text" class="form-control" id="insert-item-unit"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Giá vốn </label> </div>
          <div class="col-9"> <input type="number" class="form-control" id="insert-item-buy-price"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Giá bán </label> </div>
          <div class="col-9"> <input type="number" class="form-control" id="insert-item-sell-price"> </div>
        </div>

        <div class="error" id="insert-item-error"></div>

        <button class="btn btn-success btn-block" onclick="insertItemSubmit()">
          Thêm hàng hóa
        </button>
      </div>
    </div>
  </div>
</div>

<div id="insert-source-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm nguồn cung cấp </h4>
      </div>

      <div class="modal-body">
        <div class="rows form-group">
          <div class="col-3"> <label> Nguồn cung </label> </div>
          <div class="col-9"> <input class="form-control" id="insert-source-name"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Số điện thoại </label> </div>
          <div class="col-9"> <input class="form-control" id="insert-source-phone"> </div>
        </div>
        <div class="rows form-group">
          <div class="col-3"> <label> Địa chỉ </label> </div>
          <div class="col-9"> <input class="form-control" id="insert-source-addess"> </div>
        </div>

        <div class="error" id="insert-source-error"></div>

        <button class="btn btn-success btn-block" onclick="insertSourceSubmit()">
          Thêm nguồn
        </button>
      </div>
    </div>
  </div>
</div>

<div id="sort-modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Lọc phiếu </h4>
      </div>

      <div class="modal-body">
        <form method="get" class="text-center">
          <div class="form-group">
            <input type="text" class="form-control date" name="from" value="{from}" placeholder="Ngày bắt đầu">
          </div>
          <div class="form-group">
            <input type="text" class="form-control date" name="end" value="{end}" placeholder="Ngày kết thúc">
          </div>
          <div class="form-group">
            <input type="text" class="form-control" name="keyword" value="{keyword}" placeholder="Từ khóa">
          </div>
          <input type="hidden" name="nv" value="daklak-exchange">
          <input type="hidden" name="op" value="import">

          <button class="btn btn-success">
            Lọc phiếu
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<a href="/daklak-exchange/" class="btn btn-default"> 
  Hàng hóa
</a>
<a href="/daklak-exchange/export" class="btn btn-default"> 
  Phiếu xuất
</a>
<a href="/daklak-exchange/import" class="btn btn-primary"> 
  Phiếu nhập
</a>
<a href="/daklak-exchange/statistic" class="btn btn-default"> 
  Thống kê
</a>

<button class="btn btn-info" style="float: right;" onclick="sortModal()">
  Lọc phiếu
</button>
<button class="btn btn-success" style="float: right;" onclick="insertModal()">
  Thêm phiếu
</button>

<div class="form-group" style="clear: right;"> </div>

<div id="content">
  {content}
</div>
{nav}

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-8.js"></script>
<script>
  var global = {
    source: -1,
    id: 0,
    list: {}
  }

  $(document).ready(() => {
    $('.date').datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
    vremind.install('#insert-item', '#insert-item-suggest', (input) => {
      return new Promise(resolve => {
        key = input.toLowerCase()
        vhttp.checkelse('', {
          action: 'get-item',
          keyword: key
        }).then(response => {
          resolve(response.html)
        })
      })
    }, 300, 300)

    vremind.install('#insert-source', '#insert-source-suggest', (input) => {
      return new Promise(resolve => {
        key = input.toLowerCase()
        vhttp.checkelse('', {
          action: 'get-source',
          keyword: key
        }).then(response => {
          resolve(response.html)
        })
      })
    }, 300, 300)
  })

  function sortModal() {
    $('#sort-modal').modal('show')
  }

  function insertSourceModal() {
    $('#insert-source-name').val('')
    $('#insert-source-phone').val('')
    $('#insert-source-address').val('')
    $('#insert-source-modal').modal('show')
  }

  function selectSource(id, name) {
    global.source = id
    $('#item-source').text(name)
  }

  function calTotalRow(cid) {
    price = $('#item-price-'+cid).val()
    number = $('#item-number-'+cid).val()
    $('#item-total-'+cid).text(price * number)
    calTotal()
  }

  function calTotal() {
    total = 0
    $('.item-row').each((index, item) => {
      cid = item.getAttribute('cid')
      price = trim($('#item-price-'+ cid).val())
      number = trim($('#item-number-' + cid).val())
      total += price * number
    })
    $('#item-total').text(total)
  }

  function reloadValue() {
    global.list = {}
    $('.item-row').each((index, item) => {
      cid = item.getAttribute('cid')
      if (!global.list[cid]) global.list[cid] = {
        code: trim($('#item-code-' + cid).text()),
        name: trim($('#item-name-' + cid).text()),
        price: trim($('#item-price-' + cid).val()),
        number: trim($('#item-number-' + cid).val()),
      }
    })
  }

  function putinImport(id, code, name, price) {
    reloadValue()
    if (!global.list[id]) global.list[id] = {
      code: code,
      name: name,
      price: price,
      number: 0
    }
    global.list[id].number = Number(global.list[id].number) + 1
    reload()
  }

  function reload() {
    html = ''
    for (const id in global.list) {
      if (Object.hasOwnProperty.call(global.list, id)) {
        const item = global.list[id];
        total = item.number * item.price
        html += `
        <tr class="item-row" id="item-row-`+ id + `" cid="` + id + `">
          <td> <button class="btn btn-danger btn-xs" onclick="remove('`+ id + `')"> xóa </button> </td>
          <td id="item-code-`+ id + `"> ` + item.code + ` </td>
          <td id="item-name-`+ id + `"> ` + item.name + ` </td>
          <td>
            <input type="number" class="form-control" cid="`+id+`" id="item-price-`+ id + `" onChange="calTotalRow(`+id+`)" value="` + item.price + `">
          </td>
          <td>
            <input type="number" class="form-control" cid="`+id+`" id="item-number-`+ id + `" onChange="calTotalRow(`+id+`)" value="` + item.number + `">
          </td>
          <td id="item-total-`+id+`"> `+ total + ` </td>
        <tr>`
      }
    }
    $('#insert-content').html(html)
    calTotal()
  }

  function sourceSelect(id, name) {
    global.source = id
    $('#item-source').text(name)
  }

  function insertSourceSubmit() {
    data = {
      name: $('#insert-source-name').val(),
      phone: $('#insert-source-phone').val(),
      address: $('#insert-source-address').val()
    }

    if (!data.name.length) alert('insert-source-error', 'không bỏ trống tên')
    else if (!data.phone.length) alert('insert-source-error', 'không bỏ trống số điện thoại')

    vhttp.check('', {
      action: 'insert-source',
      data: data
    }).then(response => {
      global.source = response.id
      $('#item-source').text(response.name)
      $('#insert-source-modal').modal('hide')
    }, error => {
      alert('insert-source-error', error['msg'])
    })
  }

  function remove(key) {
    delete global.list[key]
    $('#item-row-' + key).remove()
    reloadValue()
  }

  function insertItemModal() {
    $('#insert-item-code').val('')
    $('#insert-item-name').val('')
    $('#insert-item-unit').val('')
    $('#insert-item-sell-price').val(0)
    $('#insert-item-buy-price').val(0)
    $('#insert-item-modal').modal('show')
  }

  function insertItemSubmit() {
    data = {
      'code': $('#insert-item-code').val(),
      'name': $('#insert-item-name').val(),
      'unit': $('#insert-item-unit').val(),
      'sell_price': $('#insert-item-sell-price').val(),
      'buy_price': $('#insert-item-buy-price').val(),
    }

    vhttp.check('', {
      action: 'insert-product',
      data: data
    }).then(response => {
      putinImport(response.data.code, response.data.name)
      $('#insert-item-modal').modal('hide')
    }, (error) => {
      console.log(error);
      alert('insert-item-error', error.msg)
    })
  }

  function removeModal(id) {
    global.id = id
    $('#remove-modal').modal('show')
  }

  function removeSubmit() {
    vhttp.checkelse('', {
      action: 'remove-import',
      id: global.id
    }).then(response => {
      $('#content').html(response.html)
      $('#remove-modal').modal('hide')
    })
  }

  function updateModal(id) {
    global.id = id
    vhttp.checkelse('', {
      action: 'get-import',
      id: id
    }).then(response => {
      global.list = response.list
      global.source = response.source.id
      reload()
      $('#item-source').text(response.source.name)
      $('#item-total').text(response.total)
      $('#insert-button').hide()
      $('#update-button').show()
      $('#insert-modal').modal('show')
    })
  }

  function updateSubmit() {
    reloadValue()
    if (!Object.keys(global.list).length) alert('insert-error', 'Phiếu nhập không có sản phẩm')
    else if (global.source < 0) alert('insert-error', 'Chưa chọn nguồn cung cấp')
    else {
      vhttp.check('', {
        action: 'update-import',
        data: global.list,
        source: global.source,
        id: global.id
      }).then(response => {
        $('#content').html(response.html)
        $('#insert-modal').modal('hide')
      }, (error) => {
        alert('insert-error', error.msg)
      })
    }
  }

  function insertModal() {
    global.list = []
    global.source = -1
    $('#insert-content').html('')
    $('#item-source').text('')
    $('#item-total').text('0')
    $('#insert-button').show()
    $('#update-button').hide()
    $('#insert-modal').modal('show')
  }

  function insertSubmit() {
    reloadValue()
    if (!Object.keys(global.list).length) alert('insert-error', 'Phiếu nhập không có sản phẩm')
    else if (global.source < 0) alert('insert-error', 'Chưa chọn nguồn cung cấp')
    else {
      vhttp.check('', {
        action: 'insert-import',
        data: global.list,
        source: global.source
      }).then(response => {
        $('#content').html(response.html)
        $('#insert-modal').modal('hide')
      }, (error) => {
        alert('insert-error', error.msg)
      })
    }
  }

  function alert(id, msg) {
    $('#' + id).text(msg)
    $('#' + id).show()
    $('#' + id).fadeOut(2000)
  }
</script>
<!-- END: main -->