<!-- BEGIN: main -->
<!-- BEGIN: row -->
<div class="thumb-gallery">
  <div class="xleft">
    <img src="{image}" class="thumbnail">
  </div>
  <div class="xright">
    <p> Tên thú cưng: {name} </p>
    <p> Loài: {species} </p>
    <p> Giống: {breeder} </p>
    <p> Chủ sở hữu: {owner} </p>
    <p> Thời gian: {time} </p>
    <button class="btn btn-success" onclick="confirm({id})">
      Đồng ý
    </button>
    <button class="btn btn-danger" onclick="cancel({id})">
      Hủy
    </button>
  </div>
</div>
<div style="clear: both;"></div>
<!-- END: row -->
{nav}
<!-- END: main -->
