pushd android
flutter clean
flutter pub get
flutter build apk
./gradlew app:assembleAndroidTest
./gradlew app:assembleDebug -Ptarget=integration_test/login_feature_test.dart
popd

gcloud firebase test android run \
    --type instrumentation \
    --app build/app/outputs/apk/debug/app-debug.apk \
    --test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk \
    --device model=Pixel2,version=30,locale=en_US,orientation=portrait \
    --use-orchestrator