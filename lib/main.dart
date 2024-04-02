import 'package:flutter/material.dart';
import 'package:ic_flutter_stateful_widget/dice_roller.dart';

import 'gradient_container.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: DiceRoller(),
    ),
  );
}
