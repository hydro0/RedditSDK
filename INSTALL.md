If you have no CocoaPods installed, you need to get it to build a project:
```
sudo gem install cocoapods
```

You can simply download and install all dependencies with next script:  
```
git clone git@github.com:hydro0/RedditClient.git
git clone git@github.com:hydro0/RedditSDK.git
cd RedditSDK
pod install
cd ../RedditClient
pod install
```

After that, you should be able to open `RedditClient.xcworkspace` and `RedditSDK.xcworkspace` in you XCode.
IMPORTANT: user xcworkspace, not xcodeproj files.
