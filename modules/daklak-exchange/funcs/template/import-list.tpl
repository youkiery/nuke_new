<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Thời gian tạo </th>
      <th> Nguồn cung </th>
      <th> Người tạo </th>
      <th> Tổng tiền </th>
      <th>  </th>
    </tr>
  </thead>
  <tbody style="font-size: 0.8em;">
    <!-- BEGIN: row -->
    <tr>
      <td> {time} </td>
      <td> {source} </td>
      <td> {user} </td>
      <td> {total} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="updateModal({id})">
          cập nhật
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
{nav}
<!-- END: main -->
