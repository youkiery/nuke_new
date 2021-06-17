<!-- BEGIN: main -->
  <p> Hiển thị {from} - {end} trên {total} kết quả </p>
  <table class="table table-bordered">
    <tr>
      <th> Số phiếu </th>
      <th> Số ĐKXN </th>
      <th> Tên đơn vị </th>
      <th> Số mẫu </th>
      <th> Loại động vật </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
      <td> {code} </td>
      <td> {xcode} </td>
      <td> {unit} </td>
      <td> {number} </td>
      <td> {sample} </td>
      <td>
        <span class="dropdown">
          <button class="btn btn-default dropdown-toggle" type="button" id="menu-{index}" data-toggle="dropdown">
            <span class="glyphicon glyphicon-eye-open"></span>
          </button>
          <ul class="dropdown-menu" role="menu" aria-labelledby="menu-{index}">
            <!-- BEGIN: printer -->
            <li role="presentation" onclick="preview({id}, {printercount})"><a role="menuitem" href="#"> Mẫu {printercount} </a></li>
            <!-- END: printer -->
          </ul>
        </span>

        <!-- BEGIN: mod -->
        <!-- BEGIN: clone -->
        <button class="btn btn-warning" onclick="clone({id})">
          <span class="glyphicon glyphicon-share"></span>
        </button>
        <!-- END: clone -->
        <!-- BEGIN: lockg -->
        <button class="btn btn-info" onclick="edit({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>  
        <button class="btn btn-danger" onclick="remove({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>  
        <!-- END: lockg -->
        <!-- END: mod -->
      </td>
    </tr>
    <!-- END: row -->
  </table>
  {nav}
<!-- END: main -->