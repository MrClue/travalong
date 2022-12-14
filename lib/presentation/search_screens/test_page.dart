import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldPure(
      child: Column(children: []),
    );
  }
}
