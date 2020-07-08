<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>
      <th>
        {lang.customer_name}
      </th>
      <th>
        {lang.customer_number}
      </th>
      <th>
        {lang.spa_end}
      </th>
      <th>
      </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody style="border-bottom: 2px solid darkgray !important">
    <tr>
      <td rowspan="2" class="cell-center">
        {index}
      </td>
      <td>
        {customer_name}
      </td>
      <td>
        {customer_number}
      </td>
      <td>
        {spa_end}
      </td>
      <td>
        <img src="{image}" width="32px;" onclick="preview('{image}')">
        <button class="btn btn-info btn-xs" onclick="view_detail({id})">
          {lang.spa_edit}
        </button>
        <!-- BEGIN: complete -->
        <button class="btn btn-info btn-xs" onclick="complete({id})">
          <span class="glyphicon glyphicon-ok"></span>
        </button>
        <!-- END: complete -->
        <!-- BEGIN: paid -->
        <button class="btn btn-info btn-xs" onclick="paid({id})">
          <span class="glyphicon glyphicon-usd"></span>
        </button>
        <!-- END: paid -->
        <!-- BEGIN: confirm -->
        <img src='{link}'>
        <!-- END: confirm -->
      </td>
    </tr>
    <tr>
      <td colspan="4"> {note} </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
<!-- END: main -->