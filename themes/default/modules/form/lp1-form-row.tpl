<!-- BEGIN: main -->
    <!-- BEGIN: col -->
    <td rowspan="{row}"> {gindex} {data} </td>
    <!-- END: col -->
    <td> <select class="form-control cashcode print-cashcode-{id}" rel="{id}" index="{index}">{select}</select> </td>
    <td> <input type="text" class="form-control print-result-{id}" index="{index}" value="{result}"> </td>
    <td> <input type="text" class="form-control print-serotype-{id}" index="{index}" value="{serotype}"> </td>
    <td> <input type="text" class="form-control number print-number-{id}" rel="{id}" index="{index}" value="{number}"> </td>
    <td> <input type="text" class="form-control price print-price-{id}" rel="{id}" index="{index}" value="{price}"> </td>
    <td> <input type="text" class="form-control print-total-{id}" index="{index}" value="{total}"> </td>
    <!-- BEGIN: col2 -->
    <td rowspan="{row}"> <input type="text" class="form-control" id="datetime-{id}" value="{datetime}"> </td>
    <td rowspan="{row}"> <button class="btn btn-info" onclick="reload({id}, {gindex})"> <span class="glyphicon glyphicon-refresh"></span> </button> </td>
    <!-- END: col2 -->
<!-- END: main -->
