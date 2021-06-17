<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th class="cell-center"> STT </th>
      <th class="cell-center"> Thời gian nâng lương lần cuối </th>
      <th class="cell-center"> Thời gian nâng lương kế tiếp </th>
      <th class="cell-center"> Hình thức khen thưởng </th>
      <th class="cell-center"> Ghi chú </th>
      <th class="cell-center"> File đính kèm </th>
      <!-- <th>  </th> -->
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr rel="{id}">
      <td> {index} </td>
      <td> {last_salary} </td>
      <td> {next_salary} </td>
      <td> {formal} </td>
      <td> {ghichu} </td>
      <td> 
        <!-- BEGIN: file   -->
        <a href="{file}" target="_blank"> 
          <span class="glyphicon glyphicon-download-alt"></span>  
        </a>
        <!-- END: file   -->
      </td>
      <!-- <td> 
        <button class="btn btn-info btn-xs" onclick="promoUpModal({employid})">
          bổ nhiệm
        </button>  
      </td> -->
    </tr>
  </tbody>
  <!-- END: row -->
</table>
<!-- END: main -->