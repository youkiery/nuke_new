<!-- BEGIN: main -->
  <p> Hiển thị {from} - {end} trên {total} kết quả </p>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th> <input type="checkbox" id="checkall" onchange="change()"> </th>
        <th> Số thông báo </th>
        <th> Ngày thông báo </th>
        <th> Số ĐKXN </th>
        <th> Tên đơn vị </th>
        <th> Số lượng mẫu </th>
      </tr>
    </thead>
    <!-- BEGIN: row -->
    <tbody>
      <tr>
        <td> <input class="check" type="checkbox" id="{id}"> </td>
        <td> {notice} </td>
        <td> {noticetime} </td>
        <td> {xcode} </td>
        <td> {unit} </td>
        <td> {number} </td>
      </tr>
    </tbody>
    <!-- END: row -->
  </table>
  {nav}
<!-- END: main -->