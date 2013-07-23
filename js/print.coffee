zipper.indexedDB.print = ->
  renderRecord = (record) ->
    debugger
    row = $('<div/>').addClass('record').text(JSON.stringify(record))
    $('.data').append(row)

  dbOperation = ->
    db = zipper.indexedDB.db
    objectStoreNames = db.objectStoreNames
    transaction = db.transaction objectStoreNames, 'readonly'

    for name in objectStoreNames
      store = transaction.objectStore name
      cursorRequest = store.openCursor()
      cursorRequest.onsuccess = (e) ->
        result = e.target.result
        if result?
          renderRecord(result.value)
          result.continue()

      cursorRequest.onerror = zipper.indexedDB.onerror

  zipper.indexedDB.open dbOperation

