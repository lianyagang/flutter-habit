import 'package:flutter/material.dart';
import 'package:habit_example/viewmodel/child_provider_example.dart';
import 'package:habit_example/viewmodel/list_example.dart';
import 'package:habit_example/viewmodel/provider_example.dart';

class ViewModelExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                push(context, ProviderExample());
              },
              child: Text("BaseExample"),
            ),
            ElevatedButton(
              onPressed: () {
                push(context, ProviderWidgetExample());
              },
              child: Text("BaseExtendsExample"),
            ),
            ElevatedButton(
              onPressed: () {
                push(context, ChildProviderExapmle());
              },
              child: Text("ChildExapmle"),
            ),
            ElevatedButton(
              onPressed: () {
                push(context, ListProviderExapmle());
              },
              child: Text("ListExapmle"),
            ),
          ],
        ),
      ),
    );
  }

  push(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SafeArea(top: true, child: widget);
    }));
  }
}
