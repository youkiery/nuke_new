var vremind = {
  install: (inputSelector, suggestSelector, excuteFunction, inputDelay = 0, suggestDelay = 0, track = 0) => {
    var input = $(inputSelector)
    var suggest = $(suggestSelector)
    suggest.hide()
    var delay = 0
    var hover = 0
    var previous = 'init'

    $(document).on('keyup', inputSelector, () => {
      clearTimeout(delay)
      delay = setTimeout(() => {
        if (input.val() != previous) {
          excuteFunction(input.val()).then((html) => {
            previous = input.val()
            suggest.html(html)
          })
        } 
      }, inputDelay);
    })
    $(document).on('focus', inputSelector, () => {
      setTimeout(() => {
        suggest.show()
      }, suggestDelay);
    })
    $(document).on('blur', inputSelector, () => {
      clearInterval(hover)
      hover = setInterval(() => {
        check = 1
        if (track) {
          if (suggest.is(':hover') || input.is(':hover')) {
            check = 0
          }
        }
        if (check) {
          suggest.hide()
          clearInterval(hover)
        } 
      }, suggestDelay);
    })
  }
}
