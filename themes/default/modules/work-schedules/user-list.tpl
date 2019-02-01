<!-- BEGIN: main -->
<tr class="{overtime}">
  <td data-toggle="modal" data-target="#detail">
    {index}
  </td>
  <td data-toggle="modal" data-target="#detail">
    {work_name}
  </td>
  <td data-toggle="modal" data-target="#detail">
    {work_starttime}
  </td>
  <td data-toggle="modal" data-target="#detail">
    {work_endtime}
  </td>
  <td data-toggle="modal" data-target="#detail">
    {work_customer}
  </td>
  <td data-toggle="modal" data-target="#detail" id="process_{id}">
    {work_process}%
  </td>
  <td>
    <!-- BEGIN: manager -->
    <button class="btn btn-info" onclick="edit({id})">
      {lang.update}
    </button>
    <!-- END: manager -->
    <button class="btn btn-info" onclick="change_process({id})">
      {lang.change_process}
    </button>
  </td>
</tr>
<!-- END: main -->
