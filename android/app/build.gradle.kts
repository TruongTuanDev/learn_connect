
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.learn_connect"
    compileSdk = flutter.compileSdkVersion
<<<<<<< HEAD
//    ndkVersion = flutter.ndkVersion
    ndkVersion = "27.0.12077973"
=======
    ndkVersion=  "27.1.12297006"
>>>>>>> 57291d1bb3e9e57d7b69feab755a3415acbfe478

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
//    externalNativeBuild {
//        cmake {
//            version = "3.31.7"
//            path = file("CMakeLists.txt")
//            // Thêm dòng này để chỉ định Ninja
//
//        }
//    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.learn_connect"

        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }

    }
}

flutter {
    source = "../.."
}
