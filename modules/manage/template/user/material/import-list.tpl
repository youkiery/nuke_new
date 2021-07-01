<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Ngày nhập </th>
      <th> Tổng loại </th>
      <th> Số lượng </th>
      <th></th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {index} </td>
      <td> {time} </td>
      <td> {number} </td>
      <td> {total} </td>
      <td>
        <!-- BEGIN: manager -->
        <button class="btn btn-info btn-xs" onclick="updateImport({id})">
          sửa
        </button>  
        <button class="btn btn-danger btn-xs" onclick="removeImport({id})">
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
