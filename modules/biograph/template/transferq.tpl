<!-- BEGIN: main -->
<style>
.xleft {
  width: auto;
}
.xright {
  width: auto;
  margin: 20px;
}
.thumb-gallery {
  min-height: 240px;
  margin: 20px 0px;
}
</style>
<div class="container">
  <div class="modal" id="modal-cancel" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-body">
          <button class="close" data-dismiss="modal">&times;</button>
          <p> Xác nhận hủy yêu cầu chuyển nhượng? </p>
          <div class="text-center" onclick="cancelSubmit()">
            <button class="btn btn-danger"> Hủy </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="modal" id="modal-confirm" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-body">
          <button class="close" data-dismiss="modal">&times;</button>
          <p> Xác nhận yêu cầu chuyển nhượng? </p>

          <div class="text-center" onclick="confirmSubmit()">
            <button class="btn btn-success"> Xác nhận </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <a href="/biograph/">
    <img src="/modules/biograph/src/banner.png" style="width: 200px;">
  </a>

  <div style="float: right;">
    <a href="/biograph/logout"> Đăng xuất </a>
  </div>
  <div class="separate"></div>
  <a href="/biograph/login" style="margin: 8px 0px; display: block;"> <span class="glyphicon glyphicon-chevron-left">  </span> Trở về </a>
  <div id="content">
    {content}
  </div>
</div>

<script>
  var global = {
    url: '{url}',
    page: 1
  }
  var content = $("#content")
  var modalCancel = $("#modal-cancel")
  var modalConfirm = $("#modal-confirm")

  function checkFilter() {
    return {
      id: global['id'],
      page: global['page'],
      limit: 10
    }
  }

  function goPage(page) {
    $.post(
      global['url'],
      {action: 'filter', filter: checkFilter()},
      (result, statatus) => {
        checkResult(result, statatus).then(data => {
          content.html(data['html'])
        }, () => {})
      }
    )
  }

  function cancel(id) {
    global['id'] = id
    modalCancel.modal('show')
  }

  function confirm(id) {
    global['id'] = id
    modalConfirm.modal('show')
  }

  function cancelSubmit() {
    $.post(
      global['url'],
      {action: 'cancel', filter: checkFilter()},
      (result, statatus) => {
        checkResult(result, statatus).then(data => {
          modalCancel.modal('hide')
          content.html(data['html'])
        }, () => {})
      }
    )
  }

  function confirmSubmit() {
    $.post(
      global['url'],
      {action: 'confirm', filter: checkFilter()},
      (result, statatus) => {
        checkResult(result, statatus).then(data => {
          modalConfirm.modal('hide')
          content.html(data['html'])
        }, () => {})
      }
    )
  }
</script>
<!-- END: main -->
