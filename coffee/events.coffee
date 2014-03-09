jQuery ->
  databaseName = -> $('#database').val()

  $('#bootstrap').on 'click', zipper.indexedDB.bootstrap

  $('#download').on 'click', ->
    zipper.backupStructure databaseName()

  $('#downloadBoth').on 'click', ->
    zipper.backupStructureAndData databaseName()

  $('#drop').on 'click', ->
    zipper.indexedDB.drop databaseName()

  $('#restore').on 'click', ->
    jsonString = $('#json').val()
    zipper.indexedDB.restore jsonString

