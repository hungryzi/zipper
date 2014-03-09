zipper.download = ->
  rows = []

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
          rows.push JSON.stringify(result.value)
          result.continue()
        else
          content = rows.join("\n")
          url = zipper.generateDownloadUrl content
          tag = $('<a/>').attr('href', url).text('Download here')
          $('body').append(tag)

      cursorRequest.onerror = zipper.indexedDB.onerror

  zipper.indexedDB.open dbOperation

