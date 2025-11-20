abstract class SavelastData {
  Future<void> putDataInDatabase({
    required List<String> data,
  });
  Future<List<String>> getDataFromDatabase();
}
