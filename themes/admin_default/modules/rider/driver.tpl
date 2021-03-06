<!-- BEGIN: main -->
<div class="msgshow" id="msgshow"></div>

<div class="row">
  <div class="col-lg-11 user-list" id="driver-suggest-list">
    {driver_suggest_list}
  </div>
  <div class="col-lg-2">

  </div>
  <div class="col-lg-11 user-list" id="driver-list">
    {driver_list}
  </div>
</div>

<script>
  driverSuggestList = $("#driver-suggest-list")
  driverList = $("#driver-list")

  function remove(id) {
    $(".btn").attr("disabled", true)
    $.post(
      strHref,
      {action: "driver-remove", driverId: id},
      (response, status) => {
        checkResult(response, status).then((data) => {
          driverSuggestList.html(data["driverSuggestList"])
          driverList.html(data["driverList"])
          $(".btn").attr("disabled", false)
        }, () => {
          $(".btn").attr("disabled", false)
        })
      }
    )
  }

  function insert(id) {
    $(".btn").attr("disabled", true)
    $.post(
      strHref,
      {action: "driver-insert", driverId: id},
      (response, status) => {
        checkResult(response, status).then((data) => {
          driverSuggestList.html(data["driverSuggestList"])
          driverList.html(data["driverList"])
          $(".btn").attr("disabled", false)
        }, () => {
          $(".btn").attr("disabled", false)
        })
      }
    )
  }
</script>
<!-- END: main -->