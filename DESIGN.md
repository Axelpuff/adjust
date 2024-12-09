# Design

This is a Flutter app that primarily leans on Riverpod and Google APIs.

Flutter is a cross-platform UI framework that can compile natively to a variety of platforms. To minimize development time, I have opted for a web app, which is essentially cross platform in itself. Flutter made it very easy to design the UI and manipulate widgets on screen.

Riverpod is one of several state management solutions for Flutter. I used it to manage the state in such a way that the on screen widgets directly represent what is represented in the user's secondary Google calendars without any intermediate state, despite the asynchronous nature of the data. I also used Riverpod's AsyncValue feature to show when information was loading from the server visually.

Google Calendar API formed the basis of my application. By leaning on this API, I was able to create a time-tracking solution where the data is easily exported and manipulated by external applications and accessible between multiple devices, without any server hosting on the application's part. Instead, the client uses the Google Calendar API to interact directly with the Google Calendar service, which is already widely used by students. This required creating a Google Cloud application for my app so I could access Oauth authorization.