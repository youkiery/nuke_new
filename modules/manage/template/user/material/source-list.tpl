<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Nguồn cung </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {index} </td>
      <td> {name} </td>
      <td>
        <!-- BEGIN: manager -->
        <button class="btn btn-info btn-xs" onclick="updateSource({id})">
          sửa
        </button>  
        <button class="btn btn-danger btn-xs" onclick="removeSource({id})">
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
