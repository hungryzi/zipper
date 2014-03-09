jQuery ->
  $('#create').on 'click', zipper.indexedDB.open
  $('#download').on 'click', zipper.backupStructure
  $('#downloadBoth').on 'click', zipper.backupStructureAndData
  $('#drop').on 'click', zipper.indexedDB.drop
  $('#restore').on 'click', ->
    jsonString = $('#json').val()
    zipper.indexedDB.restore jsonString

