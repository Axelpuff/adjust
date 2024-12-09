# Adjust

Adjust is a time tracking utility built on Google Calendar. It allows the user to track their time across multiple focus areas using a start and stop interface. Because it is built on the API, the user can access their data from any device.

Since the app has no backend apart from Google Calendar, it could theoretically be hosted as a static site.

## Downloading the project
In order to start working with this project, first clone the repository:

``
https://github.com/Axelpuff/adjust
``

This is a web application built with Flutter.  To get started with Flutter web app development, the easiest way is to follow the [official installation instructions](https://docs.flutter.dev/get-started/install) for the appropriate platform. (On MacOS, this involves installing Visual Studio Code with the Flutter and Dart plugins, as well as Google Chrome.) After opening the project in VS Code, use the prompt to run `pub get` for the necessary packages.

This application also uses generated code for Riverpod. To regenerate the code (and keep the build_runner in watch mode while modifying code), use
``
dart run build_runner watch
``

To start the application, run
``
flutter run --web-port=8080
``
(The web port is important for Google authorization.)

## Usage
Log in to your Google account by clicking the "Login to Google Calendar" button. This will prompt you to authorize the app to create and access secondary calendars on your Google account.

After authorizing the app, the login screen will be replaced by the track screen. The track screen has a button in the top right corner, which allows you to create new focuses with custom names.

These focuses can then be triggered by clicking on the corresponding start buttons. When a focus is triggered, the app will begin tracking time, and will continue until the corresponding stop button is clicked or a new focus is started. When the tracking is stopped, a Google Calendar event corresponding to the tracked time will be saved in a corresponding secondary calendar.

Because the app is build on Google Calendar using the corresponding APIs, the time tracking data will sync between any device as long as the user logs in to the same Google account. You can also view and modify the app's data easily using any interface that works with Google Calendar.

