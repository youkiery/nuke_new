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
  .big {
    font-size: 1.5em;
  }
</style>

<p class="big text-center"> <b> DANH SÁCH GỬI BƯU PHẨM ĐẾN CÁC ĐƠN VỊ </b> </p>

<table>
  <tr>
    <th> STT </th>
    <th> Ngày tháng </th>
    <th> Tên đơn vị </th>
    <th> Ký nhận </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td class="text-center"> {index} </td>
    <td> {date} </td>
    <td> {unit} </td>
    <td>  </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->