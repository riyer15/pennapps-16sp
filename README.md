# Setup 

1. If you don't already have the CocoaPods tool, install it on OS X by running the following command from the terminal.

	```
	$ sudo gem install cocoapods
	```

2. Open a terminal and go to the directory containing the `Podfile`:

	```
	$ cd <path-to-project>
	```

3. Run the `pod install` command. This will install the APIs specified in the Podspec, along with any dependencies they may 
have.

	```
	$ pod install
	```

4. Close Xcode, and then open (double-click) your project's `.xcworkspace` file to launch Xcode. From this time onwards, you 
must use the `.xcworkspace` file to open the project.

5. Create a new plist ([property list](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/PropertyLists/Introduction/Introduction.html)) file called `api_keys.plist` in `pennapps-16sp`: 

	File > New > File... > OS X / Resource > Property List
	
6. In `api_keys.plist`, create a new key-value pair under the Root. The key should be `google_maps_sdk`, and the value should be of type String. Ask Veronica for the API key. 