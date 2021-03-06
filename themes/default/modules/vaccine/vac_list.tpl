<!-- BEGIN: main -->
<div id="msgshow" class="msgshow"></div>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<ul style="list-style-type: circle; padding: 10px;">
  <li>
    <a href="/index.php?nv={nv}&op={op}"> {lang.list} </a>
  </li>
  <li>
    <a href="/index.php?nv={nv}&op={op}&page=list"> {lang.list2} </a>
    <img src="/themes/default/images/dispatch/new.gif">
  </li>
</ul>

<div id="premiscustom" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div>
          {lang.miscustom_prequest}
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-danger" onclick="miscustom_submit()">
          {lang.submit}
        </button>
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="miscustom" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form onsubmit="return change_custom(event)">
          <div class="row">
            <div class="form-group col-md-12">
              <label> {lang.customer} </label>
              <input type="text" class="form-control" id="vaccustom">
            </div>
            <div class="form-group col-md-12">
              <label> {lang.phone} </label>
              <input type="text" class="form-control" id="vacphone">
            </div>
          </div>
          <div class="form-group">
            <label> {lang.address} </label>
            <input type="text" class="form-control" id="vacaddress">
          </div>
          <button class="btn btn-info">
            {lang.g_edit}
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-danger" data-toggle="modal" data-target="#premiscustom">
          {lang.remove}
        </button>
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="deadend" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div>
          {lang.deadend_prequest}
        </div>
      </div>
      <div class="modal-footer">
        <button data-dismiss="modal" onclick="deadend_submit()">
          {lang.submit}
        </button>
        <button data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="detail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-8">
            {lang.customer}
          </div>
          <div class="col-md-16" id="detail_custom"> </div>
        </div>
        <div class="row">
          <div class="col-md-8">
            {lang.phone}
          </div>
          <div class="col-md-16" id="detail_phone"> </div>
        </div>
        <div class="row">
          <div class="col-md-8">
            {lang.petname}
          </div>
          <div class="col-md-16" id="detail_pet"> </div>
        </div>
        <div class="row">
          <div class="col-md-8">
            {lang.disease}
          </div>
          <div class="col-md-16" id="detail_disease"> </div>
        </div>
        <div class="row">
          <div class="col-md-8">
            {lang.doctor}
          </div>
          <div class="col-md-16" id="detail_doctor"> </div>
        </div>
      </div>
      <div class="modal-footer">
        <button data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="vaccinedetail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.confirm_mess}</h4>
      </div>
      <div class="modal-body">
          <form>
            <div class="form-group">
              <label>{lang.recall}</label>
              <div class="input-group date" data-provide="datepicker">
                <input type="text" class="form-control" id="confirm_recall" readonly>
                <div class="input-group-addon">
                    <span class="glyphicon glyphicon-th"></span>
                </div>
              </div>
            </div>
            <div class="form-group">
      				<label>{lang.doctor}</label>
              <select class="form-control" id="doctor_select">
                <!-- BEGIN: doctor -->
                <option value="{doctorid}">
                  {doctorname}
                </option>
                <!-- END: doctor -->
              </select>      
            </div>
            <div class="form-group text-center">
              <input class="btn btn-info" id="btn_save_vaccine" type="button" onclick="save_form()" value="{lang.save}" data-dismiss="modal">
            </div>
          </form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>

<!-- BEGIN: filter -->
<button class="filter btn {check}" id="chatter_{ipd}" onclick="change_data({ipd})">
  {vsname}
</button>
<!-- END: filter -->
<div class="right">
  <button class="btn btn-info" id="exall">
    Hi???n ghi ch??
  </button>
</div>

<table class="table table-striped table-border">
  <thead>
    <tr>
      <th colspan="9" class="vng_vacbox_title" style="text-align: center">
        {title}
      </th>
    </tr>
    <tr>
      <!-- <th>
        {lang.index}
      </th>   -->
      <!-- <th>
        {lang.petname}
      </th>   -->
      <th>
        {lang.customer}
      </th>  
      <th>
        {lang.phone}
      </th>  
      <!-- <th>
        {lang.disease}
			</th>   -->
      <!-- <th>
        {lang.vaccome}
      </th>   -->
      <th>
        {lang.vaccall}
      </th>  
      <th>
        {lang.vacconfirm}
      </th>
    </tr>
  </thead>
  <tbody id="content">
    {content}
  </tbody>
</table>
<script>
  var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=";
  var g_miscustom = -1;
  var g_filter = 0;
  var g_index = -1;
  var g_vacid = -1;
  var g_disease = -1;
  var g_petid = -1;
  var g_customer  = -1;
  var page = '{page}';

  var note = ["Hi???n ghi ch??", "???n ghi ch??"]
  var note_s = 0;
  $("#exall").click(() => {
    if (note_s) {
      $(".note").hide()
      note_s = 0
    }
    else {
      $(".note").show()
      note_s = 1
    }
    $("#exall").text(note[note_s])
  })

  $(".detail").click((e) => {
    var id = e.target.parentElement.getAttribute("id");
    $("#detail").modal("toggle")
    $.post(
      script_name,
      {action: "vac_detail", id: id},
      (response, status) => {
        var data = JSON.parse(response)

      }
    )
  })
  
  $('#confirm_recall').datepicker({
   	format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
	});

  function change_custom(e) {
    e.preventDefault()
    var name = $("#vaccustom").val()
    var phone = $("#vacphone").val()
    var address = $("#vacaddress").val()
    var msg = "";

    if (!name.length) {
      msg = "{lang.no_custom_name}"
    }
    else if (phone.length < 4 || phone.length > 15) {
      msg = "{lang.no_custom_phone}"
    }
    else {
      $.post(
        strHref,
        {action: "change_custom", name: name, phone: phone, address: address, cid: g_miscustom, filter: g_filter, page: page},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            $("#miscustom").modal("toggle")
            $("#content").html(data["list"])
            alert_msg(data["notify"])
          }
          else {
            alert_msg(data["notify"])
          }
        }
      )
    }
    if (msg) {
      alert_msg(msg)
    }
  }

  function change_data(id) {
    g_filter = id;
    console.log(g_filter);
    
    $.post(link + "main", 
    {action: "change_data", keyword: $("#customer_key").val(), filter: g_filter, page: page},
    (response, status) => {
      var data = JSON.parse(response);

      $(".filter").removeClass("btn-info")
      $("#chatter_" + id).addClass("btn-info")
      $("#content").html(data["data"]["html"])
      note_s = 0
      $("#exall").text(note[note_s])
    })
  }

  function miscustom(id) {
    g_vacid = id
    $.post(
      strHref,
      {action: "get_miscustom", id: id},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          g_miscustom = data["id"]
          $("#miscustom").modal("toggle")
          $("#vaccustom").val(data["name"])
          $("#vacphone").val(data["phone"])
          $("#vacaddress").val(data["address"])
        }
      }
    )
  }

  function miscustom_submit() {
    $.post(
      script_name,
      {action: "miscustom", vacid: g_vacid, filter: g_filter, page: page},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#miscustom").modal("toggle")
          $("#premiscustom").modal("toggle")
          $("#content").html(data["list"])
          note_s = 0
          $("#exall").text(note[note_s])
          alert_msg("{lang.complete}")
        }
        else {
          alert_msg("{lang.error}")
        }
      }
    )
  }

  function deadend(id) {
    g_vacid = id
    $("#deadend").modal("toggle")
  }
  function deadend_submit(id) {
    $.post(
      script_name,
      {action: "deadend", vacid: g_vacid, filter: g_filter, page: page},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          alert_msg("{lang.complete}")
          note_s = 0
          $("#exall").text(note[note_s])
        }
        else {
          alert_msg("{lang.error}")
        }
      }
    )
  }

  function confirm_upper(index, vacid, petid, diseaseid) {
    var value = document.getElementById("vac_confirm_" + diseaseid + "_" + index);
    value = trim(value.innerText)
    if (value == "???? G???i") {
      recall(index, vacid, petid, diseaseid)      
      $("#btn_save_vaccine").attr("disabled", "disabled");
      $("#vaccinedetail").modal("toggle")
    }
    else {
      $.post(
        link + "confirm",
        {act: 'up', value: value, vacid: vacid, diseaseid: diseaseid, filter: g_filter, page: page},
        (response, status) => {
          response = JSON.parse(response);
          change_color(value, response, index, vacid, petid, diseaseid);
        }
      )
    }
  }

  function confirm_lower(index, vacid, petid, diseaseid) {
    var value = document.getElementById("vac_confirm_" + diseaseid + "_" + index);
    value = trim(value.innerText)
    if (value == "???? Ti??m") {
      
    }
    else {
      $.post(
        link + "confirm",
        {act: 'low', value: value, vacid: vacid, diseaseid: diseaseid, filter: g_filter, page: page},
        (response, status) => {
          response = JSON.parse(response);
          change_color(value, response, index, vacid, petid, diseaseid);
        }
      )
    }
  }

  function change_color(e, response, index, vacid, petid, diseaseid) {
    if (response["status"]) {

      alert_msg('{lang.changed}');
      $("#content").html(response["data"]["html"])
      note_s = 0
      $("#exall").text(note[note_s])
    }
  }

  function save_form() {
    $.post(
      link + "main&act=post",
      {action: "save", petid: g_petid, recall: $("#confirm_recall").val(), doctor: $("#doctor_select").val(), vacid: g_vacid, diseaseid: g_disease, filter: g_filter, page: page},
      (data, status) => {
				data = JSON.parse(data);
				if (data["status"]) {
          $("#content").html(data["data"]["html"])
          note_s = 0
          $("#exall").text(note[note_s])
					g_vacid = -1;
					g_disease = -1;
					g_petid = -1;
					g_index = -1;
				}
        alert_msg(data["notify"]);
			}
    )
  }

  function recall(index, vacid, petid, diseaseid) {
    $("#btn_save_vaccine").attr("disabled", true);
    $.post(
			link + "main&act=post",
      {action: "getrecall", vacid: vacid, diseaseid: diseaseid, filter: g_filter, page: page},
      (data, status) => {
				data = JSON.parse(data);
				g_vacid = vacid
				g_disease = diseaseid
				g_petid = petid
				g_index = index
				if (data["status"]) {
          if (data["data"]["doctor"]) {
            $("#doctor_select").html(data["data"]["doctor"]);
            $("#confirm_recall").val(data["data"]["calltime"]);
            if (data["data"]["recall"] == 0) {
              $("#btn_save_vaccine").attr("disabled", false);
            }
          }
				}
			}
    )
  }

  function search() {
    var key = document.getElementById("customer_key").value;
    fetch(link + "search&key=" + key, []).then(response => {
      document.getElementById("content").innerHTML = response;
    })
    return false;
  }

  function editNote(index, diseaseid) {
    var answer = prompt("Ghi ch??: ", trim($("#note_v" + diseaseid + "_" + index).text()));
    if (answer) {
      $.post(
        link + "main&act=post",
        {action: "editNote", note: answer, id: index, diseaseid: diseaseid},
        (data, status) => {
          data = JSON.parse(data);
          if(data["status"]) {
            $("#note_v" + diseaseid + "_" + index).text(answer);
          }
        }
      )
    }
  }

  function viewNote(index, diseaseid) {
    $("#note_" + diseaseid + "_" + index).toggle(500);
  }

</script>
<!-- END: main -->