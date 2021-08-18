import 'package:test1/movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {

  static Database _database;
  final String table = 'movie';
  final int version = 2;

  Future<Database> get database async{
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async{
    var dir = await getDatabasesPath();
    String path = join(dir,'moviedb.db');
    var database = await openDatabase(path,version: version, onCreate: (Database db, int version){
      db.execute('CREATE TABLE $table(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, date TEXT)');
    });
    return database;
  }

  Future<void> save(Movie movie)async{
    Database db = await database;
    await db.insert(table, movie.toMap());
  }

  Future<void> update(Movie movie)async{
    Database db = await database;
    await db.update(table, movie.toMap(),where: 'id = ? ',whereArgs: [movie.id]);
  }

  Future<void> delete(Movie movie)async{
    Database db = await database;
    await db.delete(table, where: 'id = ? ', whereArgs: [movie.id]);
  }

  Future<List<Movie>> getMovie() async{
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(table);
    List<Movie> movieList = List<Movie>();
    for(var map in maps){
      movieList.add(Movie.fromMap(map));
    }
    return movieList;
  }


}