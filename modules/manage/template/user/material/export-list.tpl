<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Ngày xuất </th>
      <th> Hóa chất </th>
      <th> Số lượng </th>
      <th></th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {index} </td>
      <td> {time} </td>
      <td> {material} </td>
      <td> {total} </td>
      <td>
        <!-- BEGIN: manager -->
        <button class="btn btn-info btn-xs" onclick="updateExport({id})">
          sửa
        </button>  
        <button class="btn btn-danger btn-xs" onclick="removeExport({id})">
          xóa
        </button>  
        <!-- xóa -->
        <!-- END: manager -->
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
