import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

part 'auth_provider.g.dart';

const scopes = [
  'https://www.googleapis.com/auth/calendar.app.created',
  'https://www.googleapis.com/auth/calendar.calendarlist.readonly'
];
const calendarPrefix = "adjust_focus:";

final googleSignIn = GoogleSignIn(
    clientId:
        "223057502563-34d9n0hpkc5l004vv2ujqmt1n2aoi3l6.apps.googleusercontent.com",
    scopes: [CalendarApi.calendarEventsScope, CalendarApi.calendarScope]);

GoogleSignInAccount? userAccount;
CalendarApi? globalCalendarApi;

// Foci is structured as a dictionary
// id : dictionary
// where dictionary contains:
// name: String
// color: String (the hex code of the color)
Map<String, Map<String, String>> foci = {};

// Stores the id (not name) of the current focus 
String? currentFocus;
//List<CalendarListEntry> focusCalendars = [];

Future<Map<String, Map<String, String>>> updateFoci(
    CalendarApi calendarApi) async {
  Map<String, Map<String, String>> newFoci = {};

  var list = await calendarApi.calendarList.list();
  var calendars = list.items;
  if (calendars == null) {
    return newFoci;
  }

  for (var calendar in calendars) {
    final calendarName = calendar.summary;
    final calendarId = calendar.id;
    final calendarColor = calendar.backgroundColor;
    if (calendarName != null &&
        calendarId != null &&
        calendarColor != null &&
        calendarName.length >= calendarPrefix.length &&
        calendarName.substring(0, calendarPrefix.length) == calendarPrefix) {
      //focusCalendars.add(calendar);
      newFoci[calendarId] = {
        "name": calendarName.substring(calendarPrefix.length),
        "color": calendarColor,
      };
    }
    //print(calendar.id);
  }
  return newFoci;
}

@riverpod
class IsAuthenticated extends _$IsAuthenticated {
  @override
  bool build() {
    return false;
  }

  void tryAuth() async {
    final GoogleSignInAccount? account = await googleSignIn.signInSilently();
    if (account == null) {
      //print("Login failed");
      state = false;
      return;
    }
    //print("User has an account!");

    final bool canAccessScopes = await googleSignIn.canAccessScopes(scopes);
    if (!canAccessScopes) {
      //print("Can't access scopes! Trying to approve:");
      final bool requestedScopesSuccess =
          await googleSignIn.requestScopes(scopes);
      if (!requestedScopesSuccess) {
        //print("User didn't approve scopes");
        state = false;
        return;
      }
      //print("Scopes approved!");
    }
    //print("Can access scopes!");
    var httpClient = (await googleSignIn
        .authenticatedClient())!; // Should always be non-null
    globalCalendarApi = CalendarApi(httpClient);

    // Update state
    state = true;
    //print("Yeah!");
  }
}

@riverpod
class Foci extends _$Foci {
  @override
  Future<Map<String, Map<String, String>>> build() async {
    assert(globalCalendarApi != null);
    return updateFoci(globalCalendarApi!);
  }

  void reloadFoci() async {
    if (globalCalendarApi == null)
    {
      return;
    }
    var newFoci = await updateFoci(globalCalendarApi!);
    //foci = newFoci;
    state = AsyncData(newFoci);
  }

  void addFoci(String name) async {
    if (globalCalendarApi == null)
    {
      return;
    }
    await globalCalendarApi!.calendars
        .insert(Calendar(summary: calendarPrefix + name));

    reloadFoci();
  }
  //await calendarApi.calendars.insert(Calendar(summary: "Test calendar."));
}

Future<Event?> getLastOpenEvent(CalendarApi calendarApi, String calendarId) async {
  final events = await calendarApi.events.list(calendarId);
  final eventsList = events.items;
  if (eventsList == null)
  {
    return null;
  }

  try {
    final lastEvent = eventsList.last;
    if (lastEvent.summary == "OPEN") {
      return lastEvent;
    }
    return null;
  }
  on StateError { // No events
    return null; // Nothing to do
  }
}

Future stopTrackingFocus(CalendarApi calendarApi, String calendarId) async {
  final lastEvent = await getLastOpenEvent(calendarApi, calendarId);
  if (lastEvent == null) {
    return; // Nothing to do
  }
  final nowDateTime = EventDateTime(dateTime: DateTime.now());
  final lastEventStart = lastEvent.start!; //This should be non-null
    calendarApi.events.patch(Event(
            summary: "CLOSED",
            start: lastEventStart,
            end: nowDateTime,
          )
          , calendarId, lastEvent.id!); // Assume non- null
}

Future<String?> findCurrentFocus(CalendarApi calendarApi) async {
  for (var calendarId in (await updateFoci(calendarApi)).keys) {
    if (await getLastOpenEvent(calendarApi, calendarId) != null) {
      currentFocus = calendarId;
      // print("Found current focus");
      return calendarId; // Assumes that only one focus can be open at once
    }
    // print("Iterated over calendar $calendarId");
  }
  // print("No current focus");
  return null;
}


@riverpod
class CurrentFocus extends _$CurrentFocus {
  @override
  Future<String?> build() async {
    assert(globalCalendarApi != null);
    return findCurrentFocus(globalCalendarApi!);
  }

  void stopTracking() async {
    assert(globalCalendarApi != null);
    if (currentFocus != null) {
      await stopTrackingFocus(globalCalendarApi!, currentFocus!);
      state = const AsyncData(null);
    }
  }

  void startTracking(String focus) async {
    assert(globalCalendarApi != null);
    if (currentFocus == focus) {
      return;
    }

    stopTracking();

    // Future functionality: add time zones
    final nowDateTime = EventDateTime(dateTime: DateTime.now());
    await globalCalendarApi!.events
        .insert(
          Event(
            summary: "OPEN",
            start: nowDateTime,
            end: nowDateTime,
          ),
          focus
        );

    currentFocus = focus;
    state = AsyncData(focus);
  }
  //await calendarApi.calendars.insert(Calendar(summary: "Test calendar."));
}