`````
flutter pub run flutter_launcher_icons
`````



rm -rf ~/.gradle/caches/
`````
flutter build appbundle
`````
`````
flutter build apk --release --no-tree-shake-icons
`````
flutter run --release






`````
cd android
`````
`````
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
`````


`````
cd ios
`````
`````
gem which cocoapods
`````
`````
/Library/Ruby/Gems/2.6.0/gems/cocoapods-1.15.2/lib/cocoapods.rb
/Users/phu/.gem/ruby/2.6.0/gems/cocoapods-1.15.2/lib/cocoapods.rb
`````
`````
/Users/phu/.gem/ruby/2.6.0/bin/pod install
`````
if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self
}
WorkmanagerPlugin.register(with: self.registrar(forPlugin: "com.bundleId.workmanager.WorkmanagerPlugin")!)





`````
flutter run -d chrome --web-renderer html
`````
`````
flutter build web --no-tree-shake-icons --web-renderer html
`````
