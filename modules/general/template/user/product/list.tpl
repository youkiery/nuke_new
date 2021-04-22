<!-- BEGIN: main -->
<table class="table table-bordered">
    <tr>
        <th> <input type="checkbox" class="check-product-all"> </th>
        <th> Mã hàng </th>
        <th> Tên hàng </th>
        <th> Vị trí </th>
        <th> Số lượng </th>
        <th></th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> <input type="checkbox" class="check-product" rel="{id}"> </td>
        <td> {code} </td>
        <td> {name} </td>
        <td> {position} </td>
        <td> {number} </td>
        <td> 
          <button class="btn btn-info btn-xs" onclick="updateItem({id})">
            sửa
          </button>    
        </td>
    </tr>
    <!-- END: row -->
</table>
{nav}
<!-- END: main -->
