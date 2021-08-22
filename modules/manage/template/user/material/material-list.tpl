<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Vật tư, hóa chất </th>
      <th> Số lượng </th>
      <th> HSD </th>
      <th> Mô tả </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr class="{color}">
      <td> {index} </td>
      <td> {name} {unit} </td>
      <td> {number} </td>
      <td> {expire} </td>
      <td> {description} </td>
      <td>
        <!-- BEGIN: manager -->
        <button class="btn btn-info btn-xs" onclick="detailItem({id})">
          chi tiết
        </button>  
        <button class="btn btn-info btn-xs" onclick="updateItem({id})">
          sửa
        </button>  
        <button class="btn btn-danger btn-xs" onclick="removeItem({id})">
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
