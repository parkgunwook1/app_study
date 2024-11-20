import 'package:sqflite/sqflite.dart';

class DatabaseService {
  final Database db;
  
  DatabaseService(this.db);

  Future<Map<String, dynamic>> getUserByCredentials(String email, String password) async {
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );
    
    if (result.isEmpty) {
      throw Exception('사용자를 찾을 수 없습니다.');
    }
    
    return result.first;
  }
}