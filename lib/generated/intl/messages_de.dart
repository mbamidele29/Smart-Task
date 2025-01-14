// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static String m0(date, time) => "Erstellungsdatum: ${date} um ${time}";

  static String m1(date) => "Fälligkeitsdatum: ${date}";

  static String m2(hour) =>
      " {hour, Plural, eine{${hour} Stunde} andere{${hour} Stunden}}";

  static String m3(minute) =>
      " {Minute, Plural, eine{${minute} Minute} andere{${minute} Minuten}}";

  static String m4(seconds) => "${seconds} Sekunden";

  static String m5(time) => "Für die Aufgabe aufgewendete Zeit: ${time}";

  static String m6(count) =>
      "Verfolgen von ${Intl.plural(count, one: '${count} task', other: '${count} task')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addComment":
            MessageLookupByLibrary.simpleMessage("Kommentar hinzufügen"),
        "anErrorOccurred": MessageLookupByLibrary.simpleMessage(
            "Es ist ein Fehler aufgetreten"),
        "cannotMovebackward": MessageLookupByLibrary.simpleMessage(
            "kann sich nicht mehr als 1 Schritt rückwärts bewegen"),
        "comment": MessageLookupByLibrary.simpleMessage("Kommentar"),
        "comments": MessageLookupByLibrary.simpleMessage("Kommentare"),
        "connectionTimedout": MessageLookupByLibrary.simpleMessage(
            "Verbindungszeitüberschreitung. "),
        "create": MessageLookupByLibrary.simpleMessage("Erstellen"),
        "createNewProject":
            MessageLookupByLibrary.simpleMessage("Neues Projekt erstellen"),
        "createdDate": m0,
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "description": MessageLookupByLibrary.simpleMessage("Beschreibung"),
        "done": MessageLookupByLibrary.simpleMessage("Erledigt"),
        "dueDate": MessageLookupByLibrary.simpleMessage("Fälligkeitsdatum"),
        "dueDate_": m1,
        "edit": MessageLookupByLibrary.simpleMessage("Bearbeiten"),
        "high": MessageLookupByLibrary.simpleMessage("Hoch"),
        "hours": m2,
        "hurray": MessageLookupByLibrary.simpleMessage("Hurra 🎉"),
        "inProgress": MessageLookupByLibrary.simpleMessage("Im Gange"),
        "low": MessageLookupByLibrary.simpleMessage("Niedrig"),
        "medium": MessageLookupByLibrary.simpleMessage("Medium"),
        "minutes": m3,
        "newTaskFor": MessageLookupByLibrary.simpleMessage("Neue Aufgabe für"),
        "noCommentForThisTask": MessageLookupByLibrary.simpleMessage(
            "Kein Kommentar für diese Aufgabe.\n"),
        "noDoneTasks":
            MessageLookupByLibrary.simpleMessage("Keine erledigten Aufgaben"),
        "noInprogressTasks":
            MessageLookupByLibrary.simpleMessage("Keine laufenden Aufgaben"),
        "noInternetConnection":
            MessageLookupByLibrary.simpleMessage("keine Internetverbindung"),
        "noProjectSelected":
            MessageLookupByLibrary.simpleMessage("Kein Projekt ausgewählt"),
        "noTodotasks":
            MessageLookupByLibrary.simpleMessage("Keine ToDo-Aufgaben"),
        "notSet": MessageLookupByLibrary.simpleMessage("Nicht festgelegt"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "ongoingTask":
            MessageLookupByLibrary.simpleMessage("Laufende Aufgaben"),
        "pleaseSelectAProject": MessageLookupByLibrary.simpleMessage(
            "Bitte wählen Sie ein Projekt aus"),
        "pleaseWait": MessageLookupByLibrary.simpleMessage(
            "Bitte warten Sie, während wir Ihre Projekte einrichten.\n"),
        "priority": MessageLookupByLibrary.simpleMessage("Priorität"),
        "projectCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Projekt erfolgreich erstellt"),
        "projectName": MessageLookupByLibrary.simpleMessage("Projektname"),
        "seconds": m4,
        "startTracking": MessageLookupByLibrary.simpleMessage(
            "Beginnen Sie mit der Verfolgung"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "stopTracking":
            MessageLookupByLibrary.simpleMessage("Stoppen Sie die Verfolgung"),
        "taskCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Aufgabe erfolgreich erstellt"),
        "taskUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Aufgabe erfolgreich aktualisiert"),
        "thisFieldIsRequired": MessageLookupByLibrary.simpleMessage(
            "Dieses Feld ist erforderlich"),
        "timeSpentOnTask": m5,
        "title": MessageLookupByLibrary.simpleMessage("Titel"),
        "todo": MessageLookupByLibrary.simpleMessage("Zu tun"),
        "tracking": MessageLookupByLibrary.simpleMessage("Verfolgung"),
        "trackingOngoingTasks": m6,
        "update": MessageLookupByLibrary.simpleMessage("Aktualisieren"),
        "urgent": MessageLookupByLibrary.simpleMessage("Dringend"),
        "welcomeBack":
            MessageLookupByLibrary.simpleMessage("Willkommen zurück"),
        "youCompletedATask": MessageLookupByLibrary.simpleMessage(
            "Sie haben eine Aufgabe abgeschlossen")
      };
}
