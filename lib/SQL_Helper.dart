import 'package:sqflite/sqflite.dart' as sql;

class SqlHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE ListTable(
    indexId INTEGER,
    details TEXT,
    dateTime TEXT,
    completed INTEGER
    )""");
  }

  // Database executor
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'todo.db',
      version: 5,
      onCreate: (sql.Database database, int version) async {
        print("Creating database init database");
        await createTables(database);
      }
    );
  }

  // add data to the database
  static Future<bool> insertTasks(int index, String details, String dateTime) async {
    final db = await SqlHelper.db();
    final data = {
      'indexId': index,
      'details': details,
      'dateTime': dateTime,
      'completed': 0
    };
    final id = await db.insert('ListTable', data);
    print('ID: $id');
    return (id.bitLength > 0);
  }

  // Get all the data
  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SqlHelper.db();
    return db.query('ListTable');
  }

  static void changeState(int no, indexNo) async{
    final db = await SqlHelper.db();
    db.rawUpdate("UPDATE ListTable SET completed = ? WHERE indexId = ?", [no, indexNo]);
  }

  static Future<List<Map<String, Object?>>?> getOne(int indexNo) async {
    final db = await SqlHelper.db();
    return db.query("ListTable", where: 'indexId = ?', whereArgs: [indexNo]);
  }

  static Future<void> updateDetails(int indexNo, String updateDetails) async {
    final db = await SqlHelper.db();
    db.rawUpdate("UPDATE ListTable SET details = ? WHERE indexId = ?", [updateDetails, indexNo]);
  }

  static Future<void> deleteRecord(int indexNo) async {
    final db = await SqlHelper.db();
    db.rawDelete("DELETE FROM ListTable WHERE indexId = ?", [indexNo]);
  }
}