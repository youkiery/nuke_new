<!-- BEGIN: main  -->
<style>
  .underline {
    border-bottom: 1px solid lightgray;
    padding: 5px;
  }

  .tag {
    cursor: pointer;
    background: #9dF;
    border: 1px solid lightgrey;
    border-radius: 10px;
    margin: 1px;
    padding: 1px 3px;
  }
</style>

<div id="modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <img class="img-responsive KT3" id="KT3-K1" src="/assets/images/storage/KT3.K1.png" alt="sơ đồ kho">
        <img class="img-responsive KT3" id="KT3-K2" src="/assets/images/storage/KT3.K2.png" alt="sơ đồ kho">
        <img class="img-responsive KT3" id="KT3-K3" src="/assets/images/storage/KT3.K3.png" alt="sơ đồ kho">
        <img class="img-responsive KT3" id="KT3-K4" src="/assets/images/storage/KT3.K4.png" alt="sơ đồ kho">
        <img class="img-responsive KT3" id="KT3-K4RY" src="/assets/images/storage/KT3.K4RY.png" alt="sơ đồ kho">
        <img class="img-responsive KT3" id="KT3-K5" src="/assets/images/storage/KT3.K5.png" alt="sơ đồ kho">
        <img class="img-responsive KT3" id="KT3-K6" src="/assets/images/storage/KT3.K6.png" alt="sơ đồ kho">
        <img class="img-responsive KT3" id="KT3-K7" src="/assets/images/storage/KT3.K7.png" alt="sơ đồ kho">
      </div>
    </div>
  </div>
</div>

<div class="form-group">
  <input type="text" class="form-control" id="keyword" onkeyup="filter()" placeholder="Nhập tên hàng hóa để tìm kiếm...">
</div>

<div id="content">

</div>

<script>
var map = {
  'KT3.K1.1': 'KT3-K1',
  'KT3.K1.2': 'KT3-K1',
  'KT3.K1.3': 'KT3-K1',
  'KT3.K2.1': 'KT3-K2',
  'KT3.K2.2': 'KT3-K2',
  'KT3.K3.1': 'KT3-K3',
  'KT3.K3.2': 'KT3-K3',
  'KT3.K3.3': 'KT3-K3',
  'KT3.K4RY.1': 'KT3-K4RY',
  'KT3.K4RY.2': 'KT3-K4RY',
  'KT3.K4RY.3': 'KT3-K4RY',
  'KT3.K4RY.4': 'KT3-K4RY',
  'KT3.K4.1': 'KT3-K4',
  'KT3.K4.2': 'KT3-K4',
  'KT3.K4.3': 'KT3-K4',
  'KT3.K5.1': 'KT3-K5',
  'KT3.K5.2': 'KT3-K5',
  'KT3.K5.3': 'KT3-K5',
  'KT3.K6.1': 'KT3-K6',
  'KT3.K6.2': 'KT3-K6',
  'KT3.K6.3': 'KT3-K6',
  'KT3.K7.1': 'KT3-K7',
  'KT3.K7.2': 'KT3-K7',
}
var data = JSON.parse('{list}')
var delay = null

$(document).ready(() => {
  $('.KT3').hide()
  filter()
})

function filter() {
  if (!interval) {
    delay = setTimeout(() => {
      var html = ''
      var keyword = alias($('#keyword').val())

      data.forEach(item => {
        if (item.alias.search(keyword) >= 0) {
          var temp = []
          item.position.forEach(pos => {
            temp.push(`Vị trí: <span class="tag" onclick="position('`+ pos +`')"> `+ pos +` </span>`)
          });

          html += `
          <p class="underline">
            <span> Hàng hóa: `+ item.name +` </span> <br>
            `+ temp.join(', ') +`
          </p>
          `
        }
      });

      if (!html.length) html = '<p> <b> Không tìm thấy hàng hóa nào </b> </p>'
      $('#content').html(html)
      clearTimeout(delay)
    }, 300);
  }
}


function position(pos) {
  $('.KT3').hide()
  $('#'+ map[pos]).show()
  $('#modal').modal('show')
}

function alias(str) {
  str = str.toLowerCase()
  str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g,"a"); 
  str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g,"e"); 
  str = str.replace(/ì|í|ị|ỉ|ĩ/g,"i"); 
  str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g,"o"); 
  str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g,"u"); 
  str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g,"y"); 
  str = str.replace(/đ/g,"d");
  str = str.replace(/\u0300|\u0301|\u0303|\u0309|\u0323/g, ""); // ̀ ́ ̃ ̉ ̣  huyền, sắc, ngã, hỏi, nặng
  str = str.replace(/\u02C6|\u0306|\u031B/g, ""); // ˆ ̆ ̛  Â, Ê, Ă, Ơ, Ư
  str = str.replace(/ + /g," ");
  str = str.trim();
  return str;
}
</script>
<!-- END: main  -->