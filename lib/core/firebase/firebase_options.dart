import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static const apiKey = String.fromEnvironment(
    'FIREBASE_API_KEY',
    defaultValue: 'AIzaSyD2zHkd7shuM8xOROhYt24i4KIijgl9KXg',
  );
  static const webApiKey = String.fromEnvironment(
    'FIREBASE_WEB_API_KEY',
    defaultValue: 'AIzaSyB4m82IHSyb5NT5LV-YdZUsSu8KVCyhIOI',
  );
  static const appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const androidAppId = String.fromEnvironment(
    'FIREBASE_ANDROID_APP_ID',
    defaultValue: '1:1047017686121:android:5a61dd50be9bba386a4ef8',
  );
  static const iosAppId = String.fromEnvironment('FIREBASE_IOS_APP_ID');
  static const webAppId = String.fromEnvironment(
    'FIREBASE_WEB_APP_ID',
    defaultValue: '1:1047017686121:web:2d8049382e315b916a4ef8',
  );
  static const messagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
    defaultValue: '1047017686121',
  );
  static const projectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
    defaultValue: 'backstage-prototipo',
  );
  static const authDomain = String.fromEnvironment('FIREBASE_AUTH_DOMAIN');
  static const storageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
    defaultValue: 'backstage-prototipo.firebasestorage.app',
  );
  static const measurementId = String.fromEnvironment(
    'FIREBASE_MEASUREMENT_ID',
    defaultValue: 'G-461JBX219Y',
  );
  static const iosBundleId = String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID');

  static bool get isConfigured {
    return apiKeyForCurrentPlatform.isNotEmpty &&
        appIdForCurrentPlatform.isNotEmpty &&
        messagingSenderId.isNotEmpty &&
        projectId.isNotEmpty;
  }

  static String get apiKeyForCurrentPlatform {
    if (kIsWeb && webApiKey.isNotEmpty) return webApiKey;

    return apiKey;
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
      apiKey: apiKeyForCurrentPlatform,
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
