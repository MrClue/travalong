import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';

// * STEP 1: Hent current_user fra firebase (getter)
// * STEP 2: Få fat i current_users "age" (getter)
// * STEP 3: Update current_users "age" i DB (setter)
// * STEP 4: Få fat i den opdateret current_users "age" og print i Text() (getter)

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldPure(
      child: Column(children: []),
    );
  }
}


