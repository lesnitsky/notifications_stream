import 'dart:async';

import 'package:flutter/widgets.dart';

@immutable
abstract class NotificationWithPayload<T> extends Notification {
  final T payload;

  NotificationWithPayload(this.payload);
}

class NotificationsStream<T extends NotificationWithPayload<K>, K>
    extends NotificationListener {
  final EventSink<K> sink;

  NotificationsStream({Widget child, this.sink})
      : super(
          child: child,
          onNotification: (Notification n) {
            if (n is T) {
              final p = n.payload;
              sink.add(p);
              return true;
            }

            return false;
          },
        );
}
