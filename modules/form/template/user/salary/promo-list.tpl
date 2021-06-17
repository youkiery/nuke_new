<!-- BEGIN: main -->
<div class="form-group">
  <button class="btn btn-success" onclick="promoUpModal()">
    <span class="glyphicon glyphicon-plus"></span> Bổ nhiệm
  </button>
</div>

<table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th class="cell-center small"> STT </th>
      <th class="cell-center"> Họ và tên </th>
      <th class="cell-center"> Ngày bổ nhiệm </th>
      <th class="cell-center"> Ngày bổ nhiệm lại </th>
      <th class="cell-center"> Ghi chú </th>
      <th class="cell-center"> File </th>
      <th>  </th>
    </tr>
  </thead>
  <tbody>
  <!-- BEGIN: row -->
    <tr id="row-{id}" class="{color}">
      <td> {index} </td>
      <td> {employ} </td>
      <td> {last_promo} </td>
      <td> {next_promo} </td>
      <td> {note} </td>
      <td> 
        <!-- BEGIN: file -->
        <a href="{file}" target="_blank"> 
          <span class="glyphicon glyphicon-download-alt"></span>  
        </a>
        <!-- END: file -->
      </td>
      <td> 
        <!-- BEGIN: manager -->
        <!-- <button class="btn btn-info btn-xs" onclick="detail({id})">
          <span class="glyphicon glyphicon-eye-open"></span>
        </button>   -->
        <button class="btn btn-info btn-xs" onclick="promoEditModal({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>  
        <button class="btn btn-danger btn-xs" onclick="promoRemoveModal({id})">
          xóa
        </button>  
        <!-- END: manager -->
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
{nav}
<!-- END: main -->