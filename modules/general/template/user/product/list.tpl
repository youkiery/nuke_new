<!-- BEGIN: main -->
<table class="table table-bordered">
    <tr>
        <th> STT </th>
        <th> <input type="checkbox" class="check-product-all"> </th>
        <th> Mã hàng </th>
        <th> Tên hàng </th>
        <th> Loại hàng </th>
        <th></th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
        <td> {index} </td>
        <td> <input type="checkbox" class="check-product" rel="{id}"> </td>
        <td> {code} </td>
        <td> {name} </td>
        <td> {category} </td>
        <td> 
            <!-- <button class="btn btn-info">
                <span class="glyphicon glyphicon-floppy-disk"></span>
            </button>     -->
        </td>
    </tr>
    <!-- END: row -->
</table>
{nav}
<!-- END: main -->