import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:smart_shala/api/testdetails_api.dart';
import 'package:smart_shala/models/testdetailsmodel.dart';
import 'test_creation.dart';
import '../utils/validators.dart' as valid;
import '../static_data/substd_data.dart' as data;

/// Get the test details from the user and send to api;
/// then display the test creation page
class TestDetails extends StatefulWidget {
  const TestDetails({Key? key}) : super(key: key);

  @override
  State<TestDetails> createState() => _TestDetailsState();
}

class _TestDetailsState extends State<TestDetails> {
  final _formkey = GlobalKey<FormState>();

  int? standard;
  int? subject;
  final name = TextEditingController();
  final desc = TextEditingController();
  final topic = TextEditingController();
  final quesNum = TextEditingController();
  String? _accessToken;
  List<List<int>>? standards;
  List<List<dynamic>>? subjects;

  @override
  void initState() {
    _getSubAndStd();
    super.initState();
  }

  void _getSubAndStd() async {
    setState(() {
      standards = data.standards;
      subjects = data.subjects;
    });
  }

  /// Override the default destructor to destruct resources taken by
  /// controllers first
  @override
  void dispose() {
    name.dispose();
    desc.dispose();
    topic.dispose();
    quesNum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan, title: const Text('Create Test')),
      body: Stack(
        children: [
          Image.asset('images/addtest_bg.png'),
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Test Name Field
                    _getPaddedText('Test Name', controller: name),
                    // Test Description Field
                    _getPaddedText('Description', controller: desc),
                    // Year and Section Row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Standard',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic)),
                                  Text('Subject',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic)),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: DropdownButtonFormField<int?>(
                                    hint: const Text('Choose'),
                                    value: standard,
                                    validator: (value) =>
                                        value != null ? null : "Required",
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        standard = newValue!;
                                      });
                                    },
                                    items: (standards ?? [])
                                        .map<DropdownMenuItem<int?>>((value) {
                                      return DropdownMenuItem<int>(
                                        value: value[0],
                                        child: Text(
                                          value[1].toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Flexible(
                                  child: DropdownButtonFormField<int>(
                                    hint: const Text('Choose'),
                                    validator: (value) =>
                                        value != null ? null : "Required",
                                    value: subject,
                                    icon: const Icon(Icons.arrow_circle_down,
                                        size: 18),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        subject = newValue!;
                                      });
                                    },
                                    items: (subjects ?? [])
                                        .map<DropdownMenuItem<int>>((value) {
                                      return DropdownMenuItem<int>(
                                        value: value[0],
                                        child: Text(value[1]),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // Test Topic Field
                    _getPaddedText('Topic', controller: topic),

                    // Question Number Field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: TextFormField(
                        validator: valid.isInt,
                        controller: quesNum,
                        decoration: const InputDecoration(
                            labelText: "Enter number of questions"),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    // Creation Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // On callback validate the form and send the details to api
                          onPressed: createCallback,
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 247, 86, 75),
                          ),
                          child: const Text('Create'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPaddedText(String label,
      {required TextEditingController controller,
      double px = 8,
      double py = 16,
      bool outlineborder = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: px, vertical: py),
      child: Container(
        color: Colors.grey[200],
        child: TextFormField(
          controller: controller,
          validator: valid.isShort,
          decoration: InputDecoration(
            border: outlineborder ? const OutlineInputBorder() : null,
            labelText: label,
          ),
        ),
      ),
    );
  }

  void createCallback() async {
    if (_formkey.currentState!.validate()) {
      int testId = 32;
      log("Test id -> ${testId.toString()}");
      if (!mounted) return;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => TestCreationPage(
          totalQuestions: int.parse(quesNum.text),
          testId: testId,
        ),
      ));
    }
  }
}
