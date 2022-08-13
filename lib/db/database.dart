import 'package:raftlab_assignment/models/api_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class APIDetailsDatabase {
  static final APIDetailsDatabase instance = APIDetailsDatabase._init();

  static Database? _database;

  APIDetailsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('api_details.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableDetails ( 
  ${DetailsFields.id} $idType,
  ${DetailsFields.name} $textType, 
  ${DetailsFields.description} $textType,
  ${DetailsFields.isHttps} $boolType,
  ${DetailsFields.auth} $textType,
  ${DetailsFields.cors} $textType,
  ${DetailsFields.link} $textType,
  ${DetailsFields.category} $textType
  )
''');
  }

  Future<APIDetails> create(APIDetails apiDetails) async {
    final db = await instance.database;
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    final id = await db.insert(tableDetails, apiDetails.toJson());
    return apiDetails.copy(id: id);
  }

  Future<List<int>> createBulk(List<APIDetails> apiDetails) async {
    final db = await instance.database;
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    List<int> ids = [];
    apiDetails.forEach((apiDetails) async {
      final id = await db.insert(tableDetails, apiDetails.toJson());
      ids.add(id);
    });
    return ids;
    // final id = await db.insert(tableDetails, apiDetails.toJson());
    // return apiDetails.copy(id: id);
  }

  Future<APIDetails> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableDetails,
      columns: DetailsFields.values,
      where: '${DetailsFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return APIDetails.fromDB(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<APIDetails>> readAllNotes(String category) async {
    final db = await instance.database;

    final orderBy = '${DetailsFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = category.isNotEmpty
        ? await db.query(
            tableDetails,
            where: 'Category = ?',
            whereArgs: [category],
            orderBy: orderBy,
          )
        : await db.query(
            tableDetails,
            orderBy: orderBy,
          );

    return result.map((json) => APIDetails.fromDB(json)).toList();
  }

  Future<int> update(APIDetails apiDetails) async {
    final db = await instance.database;

    return db.update(
      tableDetails,
      apiDetails.toJson(),
      where: '${DetailsFields.id} = ?',
      whereArgs: [apiDetails.id],
    );
  }

  Future<List<String>> getCategories() async {
    final db = await instance.database;

    final result = await db.query(
      tableDetails,
      distinct: true,
      columns: ['Category'],
    );
    return result.map((data) {
      return data['Category'].toString();
    }).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableDetails,
      where: '${DetailsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> clear() async {
    final db = await instance.database;
    try {
      return await db.delete(tableDetails);
    } catch (e) {
      return 0;
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
