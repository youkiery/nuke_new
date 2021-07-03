<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> <input type="checkbox" id="device-check-all"> </th>
      <th> Tên thiết bị </th>
      <th> Phòng ban </th>
      <th> Công ty </th>
      <th> Tình trạng </th>
      <th> Số lượng </th>
      <!-- BEGIN: v1 -->
      <th></th>
      <!-- END: v1 -->
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <th> <input type="checkbox" class="device-checkbox" id="device-checkbox-{id}"> </th>
      <td> {name} </td>
      <td> {depart} </td>
      <td> {company} </td>
      <td> {status} </td>
      <td> {number} </td>
      <!-- BEGIN: v2 -->
      <td> 
        <button class="btn btn-info btn-xs" onclick="transfer({id}, {departid})">
          <span class="glyphicon glyphicon-transfer"></span>
        </button>  
        <button class="btn btn-info btn-xs" onclick="deviceEdit({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>  
        <button class="btn btn-danger btn-xs" onclick="deviceRemove({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>  
      </td>
      <!-- END: v2 -->
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<div class="form-group">
  {nav}
</div>
<!-- END: main -->