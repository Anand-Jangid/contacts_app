// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyDatabaseException implements Exception {
  final String title;
  final String description;
  MyDatabaseException(this.title, this.description);

  @override
  String toString() => 'DatabaseException(title: $title, description: $description)';
}
