library my_modal_component;

import 'package:angular/angular.dart';
import 'package:angular_ui/angular_ui.dart';
import 'dart:async';

@Component(
    selector: 'my-modal',
    templateUrl: 'packages/modal_update/component/my_modal.html',
    useShadowDom: false,
    exportExpressions: const ["tmp", "ok"]
)
class MyModalComponent implements ScopeAware  {

  @NgOneWay('items')
  List<String> items = ["1111", "2222", "3333", "4444"];
  String selected;
  String tmp;

  Modal modal;
  ModalInstance modalInstance;
  Scope scope;

  int _openSecs;
  int get openSecs => _openSecs;

  Duration get _duration => new Duration(seconds: _interval);

  int _interval = 1;
  Timer _timer;
  DateTime _openTime;

  MyModalComponent(this.modal) {
    print('Creating MyModalComponent');
  }

  void openUrl(templateUrl) {

    String backdrop = "static";
    modalInstance = modal.open(new ModalOptions(templateUrl:templateUrl, backdrop:backdrop), scope);

    modalInstance.opened
      ..then((v) {
      print('Opened');

      _openSecs = 0;
      _openTime = new DateTime.now();
      _timer = new Timer.periodic(_duration, handleTimeout);

    }, onError: (e) {
      print('Open error is $e');
    });

    // Override close to add you own functionality
    modalInstance.close = (result) {
      selected = result;
      print('Closed with selection $selected');
      modal.hide();
      _timer.cancel();
    };

    // Override dismiss to add you own functionality
    modalInstance.dismiss = (String reason) {
      print('Dismissed with $reason');
      modal.hide();
      _timer.cancel();
    };
  }

  void ok(sel) {
    modalInstance.close(sel);
    _timer.cancel();
  }

  void handleTimeout(Timer timer) {
    DateTime now = new DateTime.now();
    Duration diff = now.difference(_openTime);
    _openSecs = diff.inSeconds;

    print('open time $openSecs');
  }
}
