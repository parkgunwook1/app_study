import '../modules/position.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 싱글톤 패턴을 구현한 데이터베이스 헬퍼 클래스
class DatabaseHelper {
  // 싱글톤 인스턴스 생성
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  // 데이터베이스 인스턴스를 저장할 정적 변수
  static Database? _database;

  // 싱글톤 패턴 구현을 위한 팩토리 생성자
  factory DatabaseHelper() => _instance;
  // 프라이빗 생성자
  DatabaseHelper._internal();

  // 데이터베이스 getter - 없으면 생성하고, 있으면 기존 것을 반환
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // 데이터베이스 초기화 메서드
  Future<Database> _initDatabase() async {
    // 데이터베이스 파일 경로 설정
    String path = join(await getDatabasesPath(), 'positions.db');
    // 데이터베이스 생성 및 열기
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // 테이블 생성 쿼리 실행
        await db.execute(Position.createTableQuery);
      },
    );
  }

  // === CRUD 작업 구현 ===

  // Create: 새로운 position 데이터 삽입
  Future<int> insertPosition(Position position) async {
    final db = await database;
    return await db.insert('positions', position.toMap());
  }

  // Read: 모든 position 데이터 조회
  Future<List<Position>> getAllPositions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('positions');
    // 맵 형태의 데이터를 Position 객체로 변환하여 리스트로 반환
    return List.generate(maps.length, (i) => Position.fromMap(maps[i]));
  }

  // Read: 특정 ID의 position 데이터 조회
  Future<Position?> getPosition(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'positions',
      where: 'id = ?',
      whereArgs: [id],
    );
    // 결과가 없으면 null 반환, 있으면 Position 객체로 변환하여 반환
    if (maps.isEmpty) return null;
    return Position.fromMap(maps.first);
  }

  // Update: position 데이터 수정
  Future<int> updatePosition(Position position) async {
    final db = await database;
    return await db.update(
      'positions',
      position.toMap(),
      where: 'id = ?',
      whereArgs: [position.id],
    );
  }

  // Delete: position 데이터 삭제
  Future<int> deletePosition(int id) async {
    final db = await database;
    return await db.delete(
      'positions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}