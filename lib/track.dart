import 'package:adjust/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _textController = TextEditingController();

Icon getIcon(String? one, String two) {
  if (one == two) {
    return Icon(Icons.stop);
  } else {
    return Icon(Icons.play_arrow);
  }
}

Color getColor(String? hex) {
  if (hex == null) {
    return Colors.black;
  }
  try {
    return Color(int.parse("0xff${hex.substring(1)}"));
  } catch (error) {
    return Colors.black;
  }
}

class TrackPage extends ConsumerStatefulWidget {
  const TrackPage({super.key});

  @override
  ConsumerState<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends ConsumerState<TrackPage> {
  @override
  Widget build(BuildContext context) {
    final fociAsync = ref.watch(fociProvider);
    final currentFocus = ref.watch(currentFocusProvider);
    return Container(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton.small(
                        onPressed: () async {
                          final name = await showDialog<String>(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('Add new focus'),
                                content: TextField(
                                  controller: _textController,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                      hintText: "Enter focus name"),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Add'),
                                    onPressed: () {
                                      Navigator.pop(
                                          dialogContext, _textController.text);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          if (name != null) {
                            ref.watch(fociProvider.notifier).addFoci(name);
                          }
                        }, // Functionality: Add new foci
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: switch (fociAsync) {
                AsyncData(:final value) => ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (BuildContext focusContext, int index) {
                      final thisFocus = value.keys.elementAt(index);
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: getColor(value.values.elementAt(index)["color"]),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          value.values
                                                .elementAt(index)["name"] ??
                                            "missing name",
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0, 1.0),
                                                  blurRadius: 5.0,
                                                  color: Color.fromARGB(125, 0, 0, 0)
                                                )
                                              ]
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: switch (currentFocus)
                                        {
                                          AsyncData(:final value) => FloatingActionButton.large(
                                          onPressed: () {
                                            if (value == thisFocus) {
                                              ref
                                                  .watch(currentFocusProvider
                                                      .notifier)
                                                  .stopTracking();
                                              return;
                                            }
                                            ref
                                                .watch(currentFocusProvider
                                                    .notifier)
                                                .startTracking(thisFocus);
                                          }, // Functionality: Start tracking this foci
                                          child:
                                              getIcon(value, thisFocus),
                                        ),
                                          _ => FloatingActionButton.large(
                                          onPressed: () {},
                                          child: const CircularProgressIndicator(),
                                        ),
                                        }
                                        
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                AsyncError() => const Text("An error occurred, please reload."),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}
