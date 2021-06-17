<!-- BEGIN: main -->
  <p> Hiển thị {from} - {end} trên {total} kết quả </p>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th> Số thông báo </th>
        <th> Ngày thông báo </th>
        <th> Số ĐKXN </th>
        <th> Tên đơn vị </th>
        <th> Số lượng mẫu </th>
        <th> Trạng thái </th>
        <th></th>
      </tr>
    </thead>
    <!-- BEGIN: row -->
    <tbody class="selectable" id="{id}">
      <tr>
        <td> {notice} </td>
        <td> {noticetime} </td>
        <td> {xcode} </td>
        <td> {unit} </td>
        <td> {number} </td>
        <td> {state} </td>
        <td>
          <button class="btn btn-info" onclick="editSecret({id})">
            <span class="glyphicon glyphicon-edit"></span>
          </button>  
        </td>
      </tr>
    </tbody>
    <!-- END: row -->
  </table>
  {nav}
<!-- END: main -->