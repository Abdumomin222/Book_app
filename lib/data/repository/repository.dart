import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppRepository {
  static final AppRepository _instance = AppRepository._internal();

  factory AppRepository() => _instance;

  AppRepository._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;

  /// REGISTER
  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  /// LOGIN
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    try {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      await _auth.signOut();
    }
  }

  /// Delete Account
  Future<String?> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return "Foydalanuvchi topilmadi";
      }

      // Google akkauntni disconnect qilish
      await _googleSignIn.disconnect();

      await user.delete();
      return null;
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  /// Forgot Password
  Future<String?> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  /// GOOGLE SIGN IN
  Future<String?> signInWithGoogle() async {
    try {
      // Avvalgi sessionni tozalash (ixtiyoriy)
      await _googleSignIn.signOut();

      // Google Sign In dialog ochish
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Foydalanuvchi bekor qilgan bo'lsa
      if (googleUser == null) {
        return "Google login bekor qilindi";
      }

      // Google authentication ma'lumotlarini olish
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Firebase credential yaratish
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase ga kirish
      await _auth.signInWithCredential(credential);
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      // Google Sign In xatolarini boshqarish
      if (e.toString().contains('network_error')) {
        return "Internet bilan bog'lanishda xatolik";
      } else if (e.toString().contains('sign_in_canceled')) {
        return "Google login bekor qilindi";
      } else if (e.toString().contains('sign_in_failed')) {
        return "Google login amalga oshmadi. Qaytadan urinib ko'ring";
      }
      return "Google login xatosi: ${e.toString()}";
    }
  }

  /// Xatoliklarni foydalanuvchiga tushunarli qilib qaytarish
  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'weak-password':
          return 'Parol juda zaif';
        case 'email-already-in-use':
          return 'Bu email allaqachon ro\'yxatdan o\'tgan';
        case 'invalid-email':
          return 'Email noto\'g\'ri formatda';
        case 'user-not-found':
          return 'Foydalanuvchi topilmadi';
        case 'wrong-password':
          return 'Parol noto\'g\'ri';
        case 'user-disabled':
          return 'Bu akkount o\'chirilgan';
        case 'too-many-requests':
          return 'Juda ko\'p urinish. Keyinroq qaytadan urinib ko\'ring';
        case 'operation-not-allowed':
          return 'Bu operatsiya ruxsat etilmagan';
        case 'requires-recent-login':
          return 'Iltimos qaytadan kiring';
        case 'account-exists-with-different-credential':
          return 'Bu email boshqa usul bilan ro\'yxatdan o\'tgan';
        default:
          return 'Xatolik: ${error.message ?? error.code}';
      }
    }
    return error.toString();
  }

  /// Profile
  Future<Map<String, dynamic>?> getProfile() async {
    final user = _auth.currentUser;

    if (user == null) return null;

    final email = user.email;
    final name = user.displayName;
    final fullName = user.displayName;
    final username = email?.split('@').first;

    return {
      "email": email,
      "name": name,
      "fullName": fullName,
      "username": username,
    };
  }

}
