<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Ngày nhập </th>
      <th> Hóa chất </th>
      <th> Số lượng </th>
      <th> Ghi chú </th>
      <th></th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {index} </td>
      <td> {date} </td>
      <td> {material} </td>
      <td> {total} </td>
      <td> {note} </td>
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
