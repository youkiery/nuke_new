<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/modules/core/js/vhttp.js"></script>
<script type="text/javascript"
	src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>

<style>
	.btn-default {
		color: #333 !important;
	}
</style>

{modal}

<div class="form-group" style="float: right;">
	<!-- <button class="btn btn-info" onclick="overflowModal()">
		Danh sách quá ngày
	</button> -->
	<!-- <button class="btn btn-info" onclick="filterModal()">
		Lọc danh sách
	</button> -->
	<button class="btn btn-info" onclick="insertModal()">
		Thêm phiếu siêu âm
	</button>
</div>
<div style="clear: both;"></div>

<div class="form-group">
	<a href="/{module_name}/{op}/?type=1{filter_param}" class="{type_button1} btn" role="button">
		Danh sách gần sinh
	</a>
	<a href="/{module_name}/{op}/?type=2{filter_param}" class="{type_button2} btn" role="button">
		Danh sách đã sinh
	</a>
	<a href="/{module_name}/{op}/?type=3{filter_param}" class="{type_button3} btn" role="button">
		Danh sách tiêm phòng
	</a>
	<!-- BEGIN: manager -->
	<a href="/{module_name}/{op}/?type=4{filter_param}" class="{type_button4} btn" role="button">
		Danh sách quản lý
	</a>
	<!-- END: manager -->
</div>

<div id="html_content">
	{content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>
<script>
	var g_id = -1
	var g_customerid = -1
	var g_petid = -1
	var g_pet = ""
	var blur = true;
	var g_customer = -1;
	var customer_data = [];
	var customer_list = [];
	var customer_name = document.getElementById("customer_name");
	var customer_phone = document.getElementById("customer_phone");
	var customer_address = document.getElementById("customer_address");
	var pet_info = document.getElementById("pet_info");
	var pet_note = document.getElementById("pet_note");
	var suggest_name = document.getElementById("customer_name_suggest");
	var suggest_phone = document.getElementById("customer_phone_suggest");
	var esc = encodeURIComponent;

	var global = {
	// 	type: {select_status},
		id: 0,
	// 	recall: '{recall_date}'
  }
  
  $(document).ready(() => {
    vremind.install('#customer_phone', '#customer_phone_suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', { action: 'customer-remind', name: input, type: 1 }).then(data => {
          resolve(data['html'])
        })
      })
    }, 500, 300)
    $('.date').datepicker({
      format: 'dd-mm-yyyy'
    });
  })

  function selectCustomer(id, customer, phone, pet_option) {
    g_customer = id
    $("#customer_name").val(customer)
    $("#customer_phone").val(phone)
    $("#pet_info").html(pet_option)
  }

	function insertModal() {
		$("#insert-modal").modal('show')
	}
	function filterModal() {
		$("#filter-modal").modal('show')
	}
	function overflowModal() {
		$("#overflow-modal").modal('show')
	}

	$("#vaccine_status").change((e) => {
		if (e.currentTarget.value == 4) {
			$("#recall").attr("disabled", false);
		}
		else {
			$("#recall").attr("disabled", true);
		}
	})

	$("#birthnumber").change((e) => {
		if (e.currentTarget.value.length > 0) {
			$("#firstvac").attr("disabled", false);
			$("#vaccine_status").attr("disabled", false);
		}
	})

	function noteToggle() {
		$(".note").toggle()
	}

	function editNote(id) {
		var answer = prompt("Ghi chú: ", trim($("#note_v" + id).text()));
		if (answer) {
			$.post(
				"",
				{action: "edit-note", note: answer, id: id},
				(response, status) => {
					checkResult(response, status).then(data => {
						$("#note_v" + id).text(answer);
					})
				}
			)
		}
	}

	function removeUsg(id) {
		var answer = confirm("Xóa bản ghi này?");
		if (answer) {
			$.post(
				"",
				{ action: "remove-usg", id: id },
				(response, status) => {
					checkResult(response, status).then(data => {
						$("#html_content").html(data['html'])
					})
				}
			)
		}
	}

	function overflowFilter() {
		$.post(
			"",
			{ action: "overflow", data: {
					keyword: $("#overflow-keyword").val(),
					from: $("#overflow-from").val(),
					end: $("#overflow-end").val()
				} 
			},
			(response, status) => {
				checkResult(response, status).then(data => {
					$("#overflow-content").html(data['html'])
				})
			}
		)
	}

	function checkData() {
		return {
      name: $("#customer_name").val(),
      phone: $("#customer_phone").val(),
      address: $("#customer_address").val(),
			customer: g_customer,
			pet: $("#pet_info").val(),
			usgtime: $("#ngaysieuam").val(),
			expecttime: $("#calltime").val(),
			expectnumber: $("#expectnumber").val(),
			doctor: $("#doctor").val(),
			note: $("#note").val()
		}
    if (!data['name'].length) return 'Nhập tên khách hàng trước'
    else if (!data['phone'].length) return 'Nhập tên số điện thoại trước'
    else if (g_customer && !data['pet']) return 'Thêm thú cưng trước'
    else if (!data['usgtime'].length) return 'Chọn ngày siêu âm trước'
    else if (!data['expecttime'].length) return 'Chọn ngày dự sinh trước'
    else if (!data['doctor']) return 'Chưa có bác sĩ, xin cấu hình trong admin'
	}

	// thêm siêu âm
	// khách hàng và thú cưng bắt buộc phải chọn
	function usgInsertSubmit() {
		sdata = checkData()
    if (!sdata['phone']) alert_msg(vaccine)
		else {
			vhttp.checkelse('', { action: 'insert-usg', data: sdata }).then(data => {
				$("#content").html(data['html'])
				// xóa dữ liệu
				$("#customer_name").val('')
				$("#customer_phone").val('')
				$("#customer_address").val('')
				$("#pet_info").html('')
				$("#ghichu").val('')
				g_customer = -1
				$("#html_content").html(data['html'])
				$("#usg-new-content").html(data['html2'])
			})
		}
	}

	function changeRecall(id, type) {
		vhttp.checkelse('', { action: 'change-recall', id: id, type: type }).then(data => {
			$("#html_content").html(data['html'])
		})
	}

	function birth(id) {
		global.id = id
		$("#birth-modal").modal('show')
	}

	function birthSubmit() {
		vhttp.checkelse('',
			{
				action: 'birth',
				id: global['id'],
				number: $("#birth-number").val(),
				time: $("#birth-time").val()
			}
		).then(data => {
			$("#html_content").html(data['html'])
			$("#birth-modal").modal('hide')
		})
	}

	function vaccineRecall(id) {
		global['id'] = id
		$("#vaccine-modal").modal('show')
	}

	function vaccineSubmit() {
		vhttp.checkelse('',
			{
				action: 'vaccine',
				id: global['id'],
				disease: $("#birth-disease").val(),
				doctor: $("#birth-doctor").val(),
				time: $("#birth-time").val()
			}
		).then(data => {
			$("#html_content").html(data['html'])
			$("#vaccine-modal").modal('hide')
		})
	}

	function rejectRecall(id) {
		global['id'] = id
		$("#reject-modal").modal('show')
	}

	function rejectSubmit() {
		vhttp.checkelse('',
			{
				action: 'reject',
				id: global['id']
			}
		).then(data => {
			$("#html_content").html(data['html'])
			$("#reject-modal").modal('hide')
		})
	}

	function changeStatus(id, type) {
		if ((global['type'] == 0 && type == 0)) {
			// alert_msg('');
		}
		else if ((global['type'] == 2 && type == 1)) {
			recall(id)
		}
		else {
			$.post(
				"",
				{ action: "change-status", data: {
						id: id,
						type: type
					}
				},
				(response, status) => {
					checkResult(response, status).then(data => {
						alert_msg('Đã thay đổi trạng thái');
						$("#html_content").html(data['html'])
					})
				}
			)
		}
	}

	function recall(id, disease) {
		global.id = id
		global.disease = disease
		$("#recall-recall").val(global.recall)
		$("#recall-modal").modal('show')
	}

	function recallSubmit() {
		sdata = {
			id: global.id,
			birth: $("#recall-birth").val(),
			doctor: $("#recall-doctor").val(),
			recall: $("#recall-recall").val()
		}
		$.post(
			"",
			{ action: "recall", data: sdata
			},
			(response, status) => {
				checkResult(response, status).then(data => {
					alert_msg('Đã thay đổi trạng thái');
					$("#html_content").html(data['html'])
					$("#recall-modal").modal('hide')
				})
			}
		)
	}

	function changeVaccineStatus(id, type) {
		if (global['type'] == 0 && type == 0) {
			// alert_msg('');
		}
		else if (global['type'] == 2 && type == 1) {
			birth(id);
			// $("#usgrecall").modal("toggle")
		}
		else {
			$.post(
				"",
				{ action: "change-vaccine-status", data: {
						id: id,
						type: type
					}
				},
				(response, status) => {
					checkResult(response, status).then(data => {
						alert_msg('Đã thay đổi trạng thái');
						$("#html_content").html(data['html'])
					})
				}
			)
		}
	}

	function birthRecall() {
		sdata = {
			id: global.id,
			doctor: $("#birth-doctor").val(),
			disease: $("#birth-disease").val(),
			petname: $("#birth-petname").val(),
			recall: $("#birth-recall").val()
		}
		if (!sdata['petname'].length) {
			sdata['petname'] = 'Chưa đề tên'
		}
		$.post(
			"",
			{ action: "birth-recall", data: sdata
			},
			(response, status) => {
				checkResult(response, status).then(data => {
					alert_msg('Đã thay đổi trạng thái');
					$("#html_content").html(data['html'])
					$("#birth-modal").modal('hide')
				})
			}
		)
	}

	function filterSubmit() {
		keyList = (window.location.search.slice(1, window.location.search.length)).split('&')
		http = {}
		keyList.forEach(keystring => {
			data = keystring.split('=')
			http[data[0]] = data[1]
		});
		$(".filter").each((index, item) => {
			http[item.getAttribute('name')] = item.value
			// http[item.getAttribute('name')] = item.value.replace(/\//g, '-')
		})
		
		http = window.location.origin + window.location.pathname + '?' + Object.keys(http).map(k => esc(k) + '=' + esc(http[k])).join('&')
		window.location.replace(http)
	}

	function update(id) {
		global['id'] = id
		$.post(
			"",
			{ action: "get-update", id: id },
			(response, status) => {
				checkResult(response, status).then(data => {
					
					$("#cometime2").val(data["data"]["cometime"])
					$("#calltime2").val(data["data"]["calltime"])
					$("#doctor2").val(data["data"]["doctorid"])
					$("#note2").val(data["data"]["note"])
					$("#image2").val(data["data"]["image"])
					$("#birthnumber").val(data["data"]["birth"])
					$("#birth").val(data["data"]["birthday"])
					$("#exbirth").val(data["data"]["exbirth"])
					$("#vaccine_status").html(data["data"]["vaccine"])
					// if (data["data"]["birth"] > 0) {
					// 	$("#firstvac").attr("disabled", false);
						$("#firstvac").val(data["data"]["firstvac"]);
					// 	$("#vaccine_status").attr("disabled", false);
					// 	if (data["data"]["recall"] > 0 || data["data"]["vacid"] == 4) {
					// 		$("#recall").attr("disabled", false);
							$("#recall").val(data["data"]["recall"])
					// 	}
					// }
					$("#update-modal").modal('show')
				})
			}
		)
	}

	function update_usg() {
		sdata = {
			cometime: $("#cometime2").val(),
			calltime: $("#calltime2").val(),
			doctorid: $("#doctor2").val(),
			note: $("#note2").val(),
			birth: $("#birthnumber").val(),
			expectbirth: $("#exbirth").val(),
			recall: $("#recall").val(),
			vaccine: $("#vaccine_status").val(),
			birthday: $("#birth").val(),
			firstvac: $("#firstvac").val()
		}
		$.post(
			"",
			{ action: "update-usg", id: global['id'], data: sdata },
			(response, status) => {
				var data = JSON.parse(response)
				if (data["status"]) {
					window.location.reload()
				}
			}
		)
	}
</script>
<!-- END: main -->