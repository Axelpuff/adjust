import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

class TrackPage extends StatelessWidget {
  final List<List> foci;
  TrackPage({required this.foci});

  Widget build(BuildContext buildContext) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(children: [
                  Row(
                    children: [Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: FloatingActionButton.small(
                              onPressed: () {}, // Add foci
                              child: const Icon(Icons.add),
                            ),
                          ),
                      ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: foci.length,
                    itemBuilder: (context, int index) => Row(children: [
                      Expanded(
                        child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: foci[index][1],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(foci[index][0]),
                          ),
                        ),
                      ),
                      ),
                    ]),
                  ))
                ]))),
        Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: DayView(),
              ),
            ))
      ],
    );
  }
}
