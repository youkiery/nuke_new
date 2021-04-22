<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Mã hàng </th>
      <th> Tên hàng </th>
      <th> Số lượng </th>
      <th> Giá vốn </th>
      <th> Giá bán </th>
      <th></th>
    </tr>
  </thead>
  <tbody style="font-size: 0.8em;">
    <!-- BEGIN: row -->
    <tr>
      <td> {code} </td>
      <td> {name} {unit} </td>
      <td> {number} </td>
      <td> {buy_price} </td>
      <td> {sell_price} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="update({id})">
          cập nhật
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main -->
