import '../../database/DatabaseService.dart';


class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class AuthService {
  final DatabaseService _dbService;
  
  AuthService(this._dbService);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      return await _dbService.getUserByCredentials(email, password);
    } catch (e) {
      throw AuthException('로그인 실패: $e');
    }
  }
}