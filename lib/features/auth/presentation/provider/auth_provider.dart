import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saveload_app/features/auth/screens/login_screen.dart';
import '../../domain/auth_model.dart';

final authProvider = NotifierProvider<AuthController, AuthModel?>(
  () => AuthController(),
);

class AuthController extends Notifier<AuthModel?> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  AuthModel? build() {
    return null;
  }

  Future<AuthModel?> login({
    required String email,
    required String password,
  }) async {
    print("🔑 [AuthController] Starting login for: $email");

    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("✅ [AuthController] Firebase sign-in success");

      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        print("⚠️ [AuthController] Firebase returned null user");
        return null;
      }

      print("📄 [AuthController] Fetching Firestore user data...");
      final userDoc = await firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!userDoc.exists) {
        print(
          "⚠️ [AuthController] No Firestore user found for ${firebaseUser.uid}",
        );
      }

      final data = userDoc.data() ?? {};

      final authModel = AuthModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: data['name'] ?? firebaseUser.displayName ?? 'No Name',
      );

      // Save locally
      await storage.write(key: "auth", value: jsonEncode(authModel.toJson()));
      state = authModel;

      print(
        "🎯 [AuthController] Login completed successfully for ${authModel.email}",
      );
      return authModel;
    } on FirebaseAuthException catch (e) {
      print(
        "❌ [AuthController] FirebaseAuthException: ${e.code} - ${e.message}",
      );
      return null;
    } catch (e, st) {
      print("💥 [AuthController] Unexpected error: $e");
      print(st);
      return null;
    }
  }

  /// SIGNUP
  Future<AuthModel?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCred.user!.uid;

      await firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        'userRole': 'user',
        'createdAt': FieldValue.serverTimestamp(),
      });

      final authModel = AuthModel(uid: uid, email: email, name: name);

      await storage.write(key: "auth", value: jsonEncode(authModel.toJson()));
      state = authModel;

      print("✅ Signup successful for $email");
      return authModel;
    } on FirebaseAuthException catch (e) {
      print("❌ FirebaseAuthException during signup: ${e.message}");
      rethrow;
    } catch (e, st) {
      print("❌ General signup error: $e");
      print(st);
      return null;
    }
  }

  /// CHECK LOGIN STATUS
  Future<AuthModel?> checkLoginStatus() async {
    final data = await storage.read(key: "auth");
    if (data != null) {
      state = AuthModel.fromJson(jsonDecode(data));
    } else {
      state = null;
    }
    return state;
  }

  /// LOGOUT
  Future<void> logout(BuildContext context) async {
    await auth.signOut();
    await storage.delete(key: "auth");
    state = null;

    // Navigate to LoginScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }
}
