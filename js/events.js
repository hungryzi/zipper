// Generated by CoffeeScript 1.6.3
(function() {
  jQuery(function() {
    var databaseName;
    databaseName = function() {
      return $('#database').val();
    };
    $('#bootstrap').on('click', zipper.indexedDB.bootstrap);
    $('#download').on('click', function() {
      return zipper.backupStructure(databaseName());
    });
    $('#downloadBoth').on('click', function() {
      return zipper.backupStructureAndData(databaseName());
    });
    $('#drop').on('click', function() {
      return zipper.indexedDB.drop(databaseName());
    });
    return $('#restore').on('click', function() {
      var jsonString;
      jsonString = $('#json').val();
      return zipper.indexedDB.restore(jsonString);
    });
  });

}).call(this);
