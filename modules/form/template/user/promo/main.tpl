<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<style>
  .cell-center {
    text-align: center;
    vertical-align: inherit !important;
  }
</style>

{modal}

<div class="form-group">
  <button class="btn btn-success" onclick="employInsertModal()">
    <span class="glyphicon glyphicon-plus"></span> Thêm nhân viên 
  </button>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
  var global = {
    id: 0
  }

  $(document).ready(() => {
    $('.date').datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function employInsertModal() {
    $('#employ-insert-modal').modal('show')
  }

  function employInsert(e) {
    e.preventDefault()
    vhttp.checkelse('', {
      action: 'employ-insert',
      name: $('#employ-insert-name').val()
    }).then(response => {
      $('#employ-insert-name').val('')
      $('#content').html(response.html)
      $('#employ-insert-content').html(response.html2)
    })
    return false
  }

  function employRemove(id) {
    vhttp.checkelse('', {
      action: 'employ-remove',
      id: id
    }).then(response => {
      $('#content').html(response.html)
      $('#employ-insert-content').html(response.html2)
    })
  }

  function promoUpModal(employid) {
    global.id = employid
    $('#promo-up-modal').modal('show')
  }

  function promoUp(e) {
    e.preventDefault()
    vhttp.checkelse('', {
      action: 'promo-up',
      data: {
        employid: global.id,
        time: $('#promo-up-time').val(),
        note: $('#promo-up-note').val(),
      }
    }).then(response => {
      $('#content').html(response.html)
      $('#promo-up-modal').modal('hide')
    })
    return 0
  }
</script>
<!-- END: main -->