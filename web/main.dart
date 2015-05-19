// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library angular.ui.modal.update;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular_ui/angular_ui.dart';

import 'package:modal_update/component/my_modal.dart';

@MirrorsUsed(targets: const[
  'angular.ui'
], override: '*')
import 'dart:mirrors';


class ModalUpdateModule extends Module {
  ModalUpdateModule() {
    install(new AngularUIModule());
    bind(MyModalComponent);
  }
}

void main() {
  applicationFactory()
  .addModule(new ModalUpdateModule())
  .run();
}
