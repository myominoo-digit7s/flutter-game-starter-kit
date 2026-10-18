import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Keep release credentials in android/key.properties (ignored by Git).
val releaseSigningPropertiesFile = rootProject.file("key.properties")
val releaseSigningProperties = Properties().apply {
    if (releaseSigningPropertiesFile.isFile) {
        releaseSigningPropertiesFile.inputStream().use { load(it) }
    }
}
val requiredReleaseSigningProperties = listOf(
    "storeFile",
    "storePassword",
    "keyAlias",
    "keyPassword",
)
val missingReleaseSigningProperties = requiredReleaseSigningProperties.filter {
    releaseSigningProperties.getProperty(it).isNullOrBlank()
}
val releaseKeystoreFile = releaseSigningProperties.getProperty("storeFile")
    ?.takeIf { it.isNotBlank() }
    ?.let { rootProject.file(it) }
val releaseSigningConfigured =
    missingReleaseSigningProperties.isEmpty() && releaseKeystoreFile?.isFile == true

gradle.taskGraph.whenReady {
    val releaseBuildRequested = allTasks.any { task ->
        task.name in setOf("assembleRelease", "bundleRelease", "installRelease")
    }
    if (releaseBuildRequested && !releaseSigningConfigured) {
        val reason = if (missingReleaseSigningProperties.isNotEmpty()) {
            "Missing values: ${missingReleaseSigningProperties.joinToString()}."
        } else {
            "The configured storeFile does not point to an existing keystore."
        }
        throw GradleException(
            "Release signing is not configured. $reason Add storeFile, " +
                "storePassword, keyAlias, and keyPassword to android/key.properties. " +
                "Release builds never use the debug signing key.",
        )
    }
}

android {
    namespace = "com.example.flutter_game_starter_kit"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    signingConfigs {
        create("release") {
            if (releaseSigningConfigured) {
                storeFile = releaseKeystoreFile
                storePassword = releaseSigningProperties.getProperty("storePassword")
                keyAlias = releaseSigningProperties.getProperty("keyAlias")
                keyPassword = releaseSigningProperties.getProperty("keyPassword")
            }
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_game_starter_kit"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
