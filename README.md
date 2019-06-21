# Clima
Learn to make iOS Apps with [The App Brewery](https://www.appbrewery.co) 📱 | Project Stub | (Swift 4.0/Xcode 9) - Clima App

Beginner: Download the starter project files as .zip and extract the files to your desktop.

Pro: Git clone to your Xcode projects folder.

## Finished App
![Finished App](https://github.com/londonappbrewery/Images/blob/master/Clima.gif)

## Fix for Cocoapods v1.0.1 and below

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
```

## Fix for App Transport Security Override

```XML
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>openweathermap.org</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
				<true/>
			</dict>
		</dict>
	</dict>
```


Copyright © The App Brewery

Screenshots from running the app on IPhone 

![IMG_7294](https://user-images.githubusercontent.com/17294536/59944022-8dad0b00-9485-11e9-8035-f0aa0e356a49.PNG)
![IMG_7293](https://user-images.githubusercontent.com/17294536/59944023-8dad0b00-9485-11e9-8d16-aa10db0a852e.PNG)
![IMG_7292](https://user-images.githubusercontent.com/17294536/59944024-8dad0b00-9485-11e9-8d2b-de643ca3463c.PNG)

