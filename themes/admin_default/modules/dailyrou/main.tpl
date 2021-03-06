<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div class="msgshow" id="msgshow"></div>

<div id="summary" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Bản thống kê ngày nghỉ tháng </h2>
        <br>
        <div class="form-inline">
          <div class="form-group">
            <label>
              Từ ngày
            </label>
            <input type="text" class="form-control" id="summary-date-from" value="{startDate}" autocomplete="off">
          </div>
          <div class="form-group">
            <label>
              Đến ngày
            </label>
            <input type="text" class="form-control" id="summary-date-end" value="{endDate}" autocomplete="off">
          </div>
          <button class="btn btn-info" onclick="summarySubmit()">
            Xem tổng kết
          </button>
        </div>
        <div id="summary-content">
          {summary}
        </div>
        <div class="text-center">
          <button class="btn btn-danger" data-dismiss="modal">
            Trở về
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-sm-4">
    <input class="form-control" id="start-date" type="text" value="{this_week}" autocomplete="off">
  </div>
  <div class="col-sm-4">
    <button class="btn btn-warning" onclick="prevWeek()">
      <span class="glyphicon glyphicon-chevron-left"></span>
    </button>
    <button class="btn btn-warning" onclick="nextWeek()">
      <span class="glyphicon glyphicon-chevron-right"></span>
    </button>
  </div>
  <div class="col-sm-12">

  </div>
  <div class="col-sm-4">
    <button class="btn btn-info" onclick="showSummary()">
      Tổng kết cuối tháng
    </button>
  </div>
</div>

<div id="content">
  {content}
</div>

<script>
  var startDate = $("#start-date")
  var dateType = $("#date-type")
  var summary = $("#summary")
  var content = $("#content")
  var summaryContent = $("#summary-content")
  var summaryDateFrom = $("#summary-date-from")
  var summaryDateEnd = $("#summary-date-end")

  $("#start-date, #end-date, #summary-date-from, #summary-date-end").datepicker({
		format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function nextWeek() {
    var dateVal = startDate.val().split("/")
    var date = new Date(dateVal[2], dateVal[1], dateVal[0])
    date.setDate(date.getDate() + 7)

    startDate.val(dateToString(date))
    filterData()
  }

  function prevWeek() {
    var dateVal = startDate.val().split("/")
    var date = new Date(dateVal[2], dateVal[1], dateVal[0])
    date.setDate(date.getDate() - 7)

    startDate.val(dateToString(date))
    filterData()
  }

  function showSummary() {
    summary.modal("show")
    // freeze()
    // $.post(
    //   strHref,
    //   {action: "summary", date: startDate.val()},
    //   (response, status) => {
    //     checkResult(response, status).then((data) => {
    //       summary.modal("show")
    //       summaryContent.html(data["html"])
    //       defreeze()
    //     }, () => {
    //       defreeze()
    //     })
    //   }
    // )
  }

  function summarySubmit() {
    freeze()
    $.post(
      strHref,
      {action: "summary", startDate: summaryDateFrom.val(), endDate: summaryDateEnd.val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          summary.modal("show")
          summaryContent.html(data["html"])
          defreeze()
        }, () => {
          defreeze()
        })
      }
    )
  }
  
  function filterData() {
    freeze()
    $.post(
      strHref,
      {action: "filter_data", date: startDate.val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data["html"])
          defreeze()
        }, () => {
          defreeze()
        })        
      }
    )
  }
</script>
<!-- END: main -->