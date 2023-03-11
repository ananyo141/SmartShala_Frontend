import 'package:flutter/material.dart';
import '../constants/routes.dart';
import '../models/dash_testmodel.dart';
import '../static_data/dash_data.dart' as data;

class Subjectdetails extends StatefulWidget {
  const Subjectdetails({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<Subjectdetails> createState() => _SubjectdetailsState();
}

class _SubjectdetailsState extends State<Subjectdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 21, 37),
          title: const Text('Test'),
        ),
        body: const Testlist(tests: data.tests));
  }
}

class Testlist extends StatelessWidget {
  const Testlist({super.key, required this.tests});

  final List<DashTestModel> tests;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      // Let the ListView know how many items it needs to build.
      itemCount: tests.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = tests[index];
        return Center(
          child: Container(
            height: 640.0,
            width: 370.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Color.fromARGB(255, 255, 255, 255)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
            child: Column(
              children: [
                Text(item.subject,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: const Color.fromARGB(255, 2, 25, 44))),
                const SizedBox(
                  height: 20,
                ),
                Text(item.topic,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white)),
                const SizedBox(
                  height: 25,
                ),
                Text('Class:${item.forClass}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white)),
                const SizedBox(
                  height: 50,
                ),
                IconButton(
                    iconSize: 100,
                    onPressed: (() {
                      // Navigator.pushNamed(context, '/edgecamera/');
                      Navigator.of(context).pushNamed(
                        resultRoute,
                        arguments: (item.testid).toString(),
                      );
                    }),
                    icon: Image.asset(
                      'images/result.png',
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
