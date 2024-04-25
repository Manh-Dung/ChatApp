
import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

import '../../../../../configs/app_colors.dart';
import '../../../../../notifications/notification_widget.dart';

class NotificationTabPage extends StatefulWidget {
  @override
  State<NotificationTabPage> createState() => _NotificationTabPageState();
}

class _NotificationTabPageState extends State<NotificationTabPage> {
  TorchController torchController = TorchController();
  // late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    NotificationWidget.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              NotificationWidget.showNotification(
                  id: 0,
                  title: 'Hello',
                  body: 'This is a notification',
                  payload: 'This is a notification');
              torchController.toggle();
            },
            child: Text('Show '
                'Notification')),
      ),
    );
  }
}
