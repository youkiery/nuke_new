<!-- BEGIN: main -->
<style>
  th, td {
    padding: 5px;
    border: 1px solid gray;
  }
  table {
    width: 100%;
    border-collapse: collapse;
  }
  .text-center {
    text-align: center;
  }
</style>
<table>
  <tr>
    <th> STT </th>
    <th> Ngày tháng </th>
    <th> Tên đơn vị </th>
    <th> Số lượng </th>
    <th> Ký nhận </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td class="text-center"> {index} </td>
    <td> {date} </td>
    <td> {unit} </td>
    <td class="text-center"> {number} </td>
    <td>  </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->