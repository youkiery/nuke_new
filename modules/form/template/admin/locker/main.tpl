<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
    src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<div class="form-group row">
    <div class="col-sm-4">
        <input type="text" class="form-control" id="filter-keyword" placeholder="Mẫu phiếu" autocomplete="off">
    </div>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="filter-xcode" placeholder="Số ĐKXN" autocomplete="off">
    </div>
    <div class="col-sm-4">
        <select class="form-control" id="filter-limit">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="75">75</option>
            <option value="100">100</option>
        </select>
    </div>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="filter-unit" placeholder="Đơn vị">
    </div>
</div>
<div class="form-group row">
    <div class="col-sm-4">
        <input type="text" class="form-control" id="filter-owner" placeholder="Chủ hộ">
    </div>

    <div class="col-sm-4">
        <input type="text" class="form-control" id="filter-exam" placeholder="Kết quả xét nghiệm">
    </div>

    <div class="col-sm-4">
        <input type="text" class="form-control" id="filter-sample" placeholder="Loại động vật">
    </div>
    <div class="col-sm-4">
        <input type="text" class="form-control date" id="filter-from">
    </div>

    <div class="col-sm-4">
        <input type="text" class="form-control date" id="filter-end">
    </div>
</div>

<div class="text-center form-group">
    <button class="btn btn-info" onclick="goPage(1)"><span class="glyphicon glyphicon-search"></span></button>
</div>

<div id="content">
    {content}
</div>

<script>
    var global = {
        page: 1
    }

    $(".date").datepicker({
        format: 'dd/mm/yyyy',
        changeMonth: true,
        changeYear: true
    });

    function checkFilter() {
        return {
            page: global['page'],
            limit: $("#filter-limit").val(),
            keyword: $("#filter-keyword").val(),
            xcode: $("#filter-xcode").val(),
            unit: $("#filter-unit").val(),
            owner: $("#filter-owner").val(),
            exam: $("#filter-exam").val(),
            sample: $("#filter-sample").val(),
            from: $("#filter-from").val(),
            end: $("#filter-end").val()
        }
    }

    function goPage(page) {
        global['page'] = page
        $.post(
            '', { action: 'filter', filter: checkFilter() },
            (reponse, status) => {
                checkResult(reponse, status).then(data => {
                    $("#content").html(data['html'])
                }, () => { })
            }
        )
    }

    function lockSubmit(itemid, lockValue) {
        $.post(
            '', { action: 'lock', id: itemid, type: lockValue, filter: checkFilter() },
            (reponse, status) => {
                checkResult(reponse, status).then(data => {
                    $("#content").html(data['html'])
                }, () => { })
            }
        )
    }
</script>
<!-- END: main -->