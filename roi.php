<?php
		// $db = new mysqli('localhost', 'root', '', 'petcoffee');
		// $db->query('SET NAMES "utf8"');

		// $sql = 'select * from pet_test_vaccine where status = 0 order by calltime desc';
		// $query = $db->query($sql);
		// while ($row = $query->fetch_assoc()) {
		// 	echo date('d/m/Y', $row['calltime']) . '<br>';
		// }
		// die();
	if (isset($_POST['data'])) {
		$data = $_POST['data'];
	}
	
	if (!empty($data)) {
		$db = new mysqli('localhost', 'root', '', 'petcoffee');
		$db->query('SET NAMES "utf8"');
		$db->query('delete from astora_1');
		$db->query('delete from astora_2');
		foreach($data['bv'] as $row) {
			$sql = "insert into astora_1 (code, name, cate, price, num) values('$row[code]', '$row[name]', '$row[cate]', '$row[price]', $row[num])";			
			$db->query($sql);		
		}

		foreach($data['kho'] as $row) {
			$sql = "insert into astora_2 (code, num) values('$row[code]', $row[num])";
			$db->query($sql);		
		}
	}
?>

<input type="file" id="bv" />
<input type="file" id="kho" />
<div id='my_file_output'></div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xls/0.7.4-a/xls.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
var xdata = {}
var bv, kho

$(function() {
	$("#bv").change((e) => {
		filePicked(e, bv, 'bv')
	})
	$("#kho").change((e) => {
		filePicked(e, kho, 'kho')
	})
});

function filePicked(oEvent, tail, nid) {
    // Get The File From The Input
    var oFile = oEvent.target.files[0];
    var sFilename = oFile.name;
    // Create A File Reader HTML5
    var reader = new FileReader();

    // Ready The Event For When A File Gets Selected
    reader.onload = function(e) {
        var data = e.target.result;
        var cfb = XLS.CFB.read(data, {type: 'binary'});
        var wb = XLS.parse_xlscfb(cfb);
        // Loop Over Each Sheet
        wb.SheetNames.forEach(function(sheetName) {
            // Obtain The Current Row As CSV
            var sCSV = XLS.utils.make_csv(wb.Sheets[sheetName]);   
            var oJS = XLS.utils.sheet_to_row_object_array(wb.Sheets[sheetName]);   

			xdata[nid] = oJS
        });
    };

    // Tell JS To Start Reading The File.. You could delay this if desired
    reader.readAsBinaryString(oFile);
}

function update() {
	$.post(
		'/roi.php',
		{data: xdata},
		(response, status) => {
			console.log(status)
		}
	)
}

function checkSoldOut() {
	var list = [], html = ''
	var dx = {}, dy = {}
	xdata['bv'].forEach(item => {
		dx[item['code']] = item
	})
	xdata['kho'].forEach(item => {
		dy[item['code']] = item
	})
	for (const code in dx) {
		if (dx.hasOwnProperty(code)) {
			if (dx[code] && dy[code]) {
				var itemDx = dx[code]
				var itemDy = dy[code]
				itemDx['num'] = Number(itemDx['num'])
				itemDy['num'] = Number(itemDy['num'])
				var x = (itemDx['num'] <= 5 && itemDy['num'] > 0)
				if (x) {
					var block = "Bệnh viện còn " + parseInt(itemDx['num']) + " " + itemDx['name'] + ",  lấy thêm " + (itemDy['num'] > 10 ? 10 : parseInt(itemDy['num'])) + "<br>"
					html += block
					list[code] = block				
				}
			}
		}
	}
	$("#my_file_output").html(html)
}

function checkSoldOut2() {
	var list = [], html = ''
	var dx = {}, dy = {}
	xdata['bv'].forEach(item => {
		dx[item['code']] = item
	})
	xdata['kho'].forEach(item => {
		dy[item['code']] = item
	})
	for (const code in dx) {
		if (dx.hasOwnProperty(code)) {
			if (dx[code] && dy[code]) {
				var itemDx = dx[code]
				var itemDy = dy[code]
				itemDx['num'] = Number(itemDx['num'])
				itemDy['num'] = Number(itemDy['num'])
				var x = (itemDx['num'] <= 0 && itemDy['num'] <= 0 && itemDx['cate'] != 'SHOP>>Áo quần')
				if (x) {
					var block = "Bệnh viện còn " + parseInt(itemDx['num']) + " " + itemDx['name'] + ",  lấy thêm " + (itemDy['num'] > 10 ? 10 : parseInt(itemDy['num'])) + "<br>"
					html += block
					list[code] = block				
				}
			}
		}
	}
	$("#my_file_output").html(html)
}
</script>