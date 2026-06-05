import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const androidAppId = String.fromEnvironment('FIREBASE_ANDROID_APP_ID');
  static const iosAppId = String.fromEnvironment('FIREBASE_IOS_APP_ID');
  static const webAppId = String.fromEnvironment('FIREBASE_WEB_APP_ID');
  static const messagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
  );
  static const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const authDomain = String.fromEnvironment('FIREBASE_AUTH_DOMAIN');
  static const storageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
  );
  static const measurementId = String.fromEnvironment(
    'FIREBASE_MEASUREMENT_ID',
  );
  static const iosBundleId = String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID');

  static bool get isConfigured {
    return apiKey.isNotEmpty &&
        appIdForCurrentPlatform.isNotEmpty &&
        messagingSenderId.isNotEmpty &&
        projectId.isNotEmpty;
  }

  static String get appIdForCurrentPlatform {
    if (kIsWeb && webAppId.isNotEmpty) return webAppId;

    return switch (defaultTargetPlatform) {
      TargetPlatform.android when androidAppId.isNotEmpty => androidAppId,
      TargetPlatform.iOS when iosAppId.isNotEmpty => iosAppId,
      _ => appId,
    };
  }

  static FirebaseOptions get currentPlatform {
    if (!isConfigured) {
      throw StateError(
        'Firebase nao configurado. Defina FIREBASE_API_KEY, '
        'FIREBASE_APP_ID, FIREBASE_PROJECT_ID e '
        'FIREBASE_MESSAGING_SENDER_ID via --dart-define.',
      );
    }

    return FirebaseOptions(
      apiKey: apiKey,
      appId: appIdForCurrentPlatform,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      authDomain: authDomain.isEmpty
          ? '$projectId.firebaseapp.com'
          : authDomain,
      storageBucket: storageBucket.isEmpty
          ? '$projectId.firebasestorage.app'
          : storageBucket,
      measurementId: measurementId.isEmpty ? null : measurementId,
      iosBundleId: iosBundleId.isEmpty ? null : iosBundleId,
    );
  }
}
