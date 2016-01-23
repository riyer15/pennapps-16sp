If you don't already have the CocoaPods tool, install it on OS X by running the following command from the terminal.

```
$ sudo gem install cocoapods
```

Open a terminal and go to the directory containing the `Podfile`:

```
$ cd <path-to-project>
```

Run the `pod install` command. This will install the APIs specified in the Podspec, along with any dependencies they may have.

```
$ pod install
```

Close Xcode, and then open (double-click) your project's `.xcworkspace` file to launch Xcode. From this time onwards, you must 
use the `.xcworkspace` file to open the project.

