# notifications_stream

[![lesnitsky.dev](https://lesnitsky.dev/shield.svg?hash=96680)](https://lesnitsky.dev?utm_source=notifications_stream)
[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/notifications_stream.svg?style=social)](https://github.com/lesnitsky/notifications_stream)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_dev)

Utilitary widget which writes notifications into stream

## Installation

pubspec.yaml:

```yaml
dependencies:
  notifications_stream: ^1.0.0
```


## Example

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notifications_stream/notifications_stream.dart';

void main() {
  runApp(CounterApp());
}

class Increment extends NotificationWithPayload<int> {
  Increment() : super(1);
}

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = StreamController<int>();
    int prevValue = 0;

    final count = controller.stream.map((event) => prevValue += event);

    return MaterialApp(
      home: NotificationsStream<Increment, int>(
        sink: controller,
        child: HomePage(count: count, initialValue: prevValue),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Stream<int> count;
  final int initialValue;

  const HomePage({Key key, this.count, this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications stream demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
              initialData: initialValue,
              stream: count,
              builder: (context, snapshot) {
                final count = snapshot.data;
                final style = Theme.of(context).textTheme.headline4;
                return Text(count.toString(), style: style);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Increment().dispatch(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

```


## License

MIT
