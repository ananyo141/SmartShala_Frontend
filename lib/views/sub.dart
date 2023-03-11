import 'package:flutter/material.dart';
import '../static_data/substd_data.dart' as data;

class SubjectDetails extends StatefulWidget {
  const SubjectDetails({Key? key}) : super(key: key);
  @override
  State<SubjectDetails> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  int? standard;
  int? subject;
  List<List<int>> standards = data.standards;
  List<List<dynamic>> subjects = data.subjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Subjects"),
          backgroundColor: const Color.fromARGB(255, 3, 37, 1),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final item = subjects[index];
            return Center(
              child: Container(
                height: 100.0,
                width: 420.0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 4, 22, 31),
                  border: Border.all(
                    color: const Color.fromARGB(255, 243, 241, 241),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(item[1],
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255))),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
