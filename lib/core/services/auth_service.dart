import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient _auth = Supabase.instance.client.auth;

  Stream<AuthState> get authStateChanges => _auth.onAuthStateChange;

  User? get currentUser => _auth.currentUser;

  Future<void> signUp(String email, String password) async {
    await _auth.signUp(email: email, password: password);
  }

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}