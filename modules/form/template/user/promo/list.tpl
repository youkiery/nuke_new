<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th class="cell-center"> STT </th>
      <th class="cell-center"> Họ và tên </th>
      <th class="cell-center"> Ngày bổ nhiệm </th>
      <th class="cell-center"> Ngày bổ nhiệm lại </th>
      <th class="cell-center"> Ghi chú </th>
      <!-- <th class="cell-center"> File đính kèm </th> -->
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr rel="{id}">
      <td> {index} </td>
      <td> {name} </td>
      <td> {last_promo} </td>
      <td> {next_promo} </td>
      <td> {ghichu} </td>
      <!-- <td> {file} </td> -->
      <td> 
        <button class="btn btn-info btn-xs" onclick="promoUpModal({employid})">
          bổ nhiệm
        </button>  
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
<!-- END: main -->