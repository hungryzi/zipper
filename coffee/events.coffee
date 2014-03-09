jQuery ->
  $('#create').on 'click', zipper.indexedDB.open
  $('#download').on 'click', zipper.downloadStructure
  $('#drop').on 'click', zipper.indexedDB.drop

