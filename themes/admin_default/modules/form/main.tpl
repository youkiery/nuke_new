<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<style>
  .block {
    display: block;
  }
</style>

<div class="modal" id="permission" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <p> Tick danh sách mẫu </p>
        <label class="block">
          Mẫu 1
          <input type="checkbox" class="permist">
        </label>
        <label class="block">
          Mẫu 2
          <input type="checkbox" class="permist">
        </label>
        <label class="block">
          Mẫu 3
          <input type="checkbox" class="permist">
        </label>
        <label class="block">
          Mẫu 4
          <input type="checkbox" class="permist">
        </label>
        <label class="block">
          Mẫu 5
          <input type="checkbox" class="permist">
        </label>
        <button class="btn btn-success" onclick="savePermission()">
          Lưu
        </button>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-sm-12">
    <div class="input-group">
      <input type="text" class="form-control" id="form-keyword" placeholder="Từ khóa" autocomplete="off">
      <div class="input-group-btn">
        <button class="btn btn-info" onclick="search()"> <span class="glyphicon glyphicon-search"></span> </button>
      </div>
    </div>
  </div>
  <div class="relative col-sm-12">
    <input type="text" class="form-control" id="form-employ" placeholder="Thêm nhân viên" autocomplete="off">
    <div class="suggest" id="form-employ-suggest"></div>
  </div>
</div>

<div id="content">
  {content}
</div>

<script>
  var formKeyword = $("#form-keyword")
  var formEmploy = $("#form-employ")
  var formEmploySuggest = $("#form-employ-suggest")
  var permission = $("#permission")
  var permist = $(".permist")
  var content = $("#content")
  var timeout
  var global_id

  formEmploy.keyup(() => {
    clearTimeout(timeout)
    setTimeout(() => {
      $.post(
        strHref,
        {action: 'filterEmploy', key: formEmploy.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            formEmploySuggest.html(data['html'])
          }, () => {  })
        }
      )
    }, 200);
  })
  
  formEmploy.focus(() => {
    formEmploySuggest.show()
  })
  formEmploy.blur(() => {
    setTimeout(() => {
      formEmploySuggest.hide()
    }, 200);
  })

  function getPermission(id) {
    $.post(
      strHref,
      {action: 'getPermission', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          global_id = id
          parsePermission(data)
          permission.modal('show')
        }, () => {  })
      }
    )
  }

  function gatherPermission() {
    var data = []
    permist.each((index, item) => {
      if (item.checked) {
        data.push(index)
      }
    })
    return data.join(',')
  }

  function admin(userid, type) {
    $.post(
      strHref,
      {action: 'admin', userid: userid, type: type, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {  })
      }
    )
  } 

  function savePermission() {
    $.post(
      strHref,
      {action: 'savePermission', permissionData: gatherPermission(), userid: global_id},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          permission.modal('hide')
        }, () => {  })
      }
    )
  }

  function parsePermission(data) {
    permist.each((index, item) => {
      item.checked = false
    })
    if (data['permist']) {
      dataPermist = data['permist'].split(',')
      if (dataPermist.length) {
        dataPermist.forEach(item => {
          permist[item].checked = true
        })
      }
    }
  }

  function search(userid) {
    $.post(
      strHref,
      {action: 'search', key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {  })
      }
    )
  }

  function addEmploy(userid) {
    $.post(
      strHref,
      {action: 'addEmploy', userid: userid, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {  })
      }
    )
  }

  function removeUser(userid) {
    $.post(
      strHref,
      {action: 'removeUser', userid: userid, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {  })
      }
    )
  }


  function salary(userid, type) {
    $.post(
      '',
      {action: 'salary', userid: userid, type: type, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {  })
      }
    )
  }

  function upUser(userid) {
    $.post(
      strHref,
      {action: 'upUser', userid: userid, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {  })
      }
    )
  }

  function downUser(userid) {
    $.post(
      strHref,
      {action: 'downUser', userid: userid, key: formKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {  })
      }
    )
  }
</script>
<!-- END: main -->