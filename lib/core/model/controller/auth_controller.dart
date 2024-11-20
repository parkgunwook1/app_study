import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../vo/User.dart';
import '../../../HomeScreen.dart'; 
  

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  
  // 상태 관리
  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // 로그인 처리
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // 서비스 호출
      final result = await _authService.login(email, password);
      
      // 사용자 정보 저장
      user.value = User.fromMap(result);
      
      // 로그인 성공 후 처리 (예: 화면 이동)
      Get.offAll(() => HomeScreen());
      
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}