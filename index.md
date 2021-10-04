# App Activity Viewer

A viewer for the iOS 15 "Record App Activity" export.

<img src="https://github.com/JannikArndt/AppActivityViewer/raw/main/Logo.png" width="200">
<a href="https://apps.apple.com/us/app/app-activity-viewer/id1587607541"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-EN?size=250x83" alt="Download on the App Store" style="border-top-left-radius: 13px; border-top-right-radius: 13px; border-bottom-right-radius: 13px; border-bottom-left-radius: 13px; width: 250px; height: 83px;"></a>

<img src="https://github.com/JannikArndt/AppActivityViewer/raw/main/Submission/1/en/iphone65/screen1_overview.png" width="200">
<img src="https://github.com/JannikArndt/AppActivityViewer/raw/main/Submission/1/en/iphone65/screen2_whatsapp.PNG" width="200">
<img src="https://github.com/JannikArndt/AppActivityViewer/raw/main/Submission/1/en/iphone65/screen3_gmaps.PNG" width="200">
<img src="https://github.com/JannikArndt/AppActivityViewer/raw/main/Submission/1/en/iphone65/screen4_howto.PNG" width="200">

## FAQ

#### How do I create an App Activity Report?

Go to the "Settings" app of your device, "Privacy" and choose "Record App Activity". Turn on the toggle. From now on, all app activity will be recorded, for up to seven days.

Come back after you used the apps you want to investigate and click "Save App Activity". Save the file to your files.

Now open _App Activity Viewer_ and open the file.

#### Where can I report errors?

You can create a new issue [here](https://github.com/JannikArndt/AppActivityViewer/issues/new).

#### Does the app send my data somewhere?

No. The data stays on your phone. The app only tries to load the icons and names of the apps that you recorded, because the file only contains the "bundleID". This is done via the official Apple iTunes API.

## Contact

If you need to get in contact with the developer, you can write to apps@jannikarndt.de.

## Background

* Apple's original announcement: https://www.apple.com/newsroom/2021/06/apple-advances-its-privacy-leadership-with-ios-15-ipados-15-macos-monterey-and-watchos-8/
* iOS 15 release notes: https://developer.apple.com/documentation/ios-ipados-release-notes/ios-ipados-15-release-notes#Privacy
* Developer Documentation: https://developer.apple.com/documentation/foundation/urlrequest/inspecting_app_activity_data

## Privacy

The app is intended to display sensitive, personal data: the usage of the apps on your iPhone. 
For this reason, it only displays this information and processes it on the device. 
No data is sent to any server, at any time. 
The app also contains no tracking and sends no logs.
