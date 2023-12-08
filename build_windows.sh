RELEASE=C:/Users/yoshi/project/flutter_animalize/build/windows/x64/runner/Release
flutter build windows
cp C:/Windows/System32/msvcp140.dll $RELEASE/
cp C:/Windows/System32/vcruntime140.dll $RELEASE/
cp C:/Windows/System32/vcruntime140_1.dll $RELEASE/
#NEED TO MOVE build/windows/x64/runner TO build/windows/runner
flutter pub run msix:create