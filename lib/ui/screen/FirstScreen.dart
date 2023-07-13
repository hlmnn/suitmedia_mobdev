import 'package:flutter/material.dart';
import 'package:suitmedia_mobdev/ui/screen/SecondScreen.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key, required this.title});

  final String title;

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _sentence = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String _resultMessage = '';

  @override
  void dispose() {
    _name.dispose();
    _sentence.dispose();
    super.dispose();
  }

  void checkPalindrome() {
    String sentence = _sentence .text.toLowerCase();
    String reversedSentence = sentence.split('').reversed.join('');

    if (sentence == reversedSentence) {
      setState(() {
        _resultMessage = 'isPalindrome';
      });
    } else {
      setState(() {
        _resultMessage = 'not palindrome';
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check Palindrome'),
          content: Text(_resultMessage),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background@2x.png"),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left:31, right: 31),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Image.asset(
                    'assets/images/ic_photo@2x.png',
                    width: 116,
                    height: 116,
                  ),
                ),
                const SizedBox(height: 35),
                Form(
                  key: _formKey,
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextFormField(
                            controller: _name,
                            validator: (value) {
                              return (value == null || value.isEmpty) ? 'Please fill Name field!' : null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(15),
                              hintText: 'Name',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xff6867775C),
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                          ),
                        ),

                        // Password
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            controller: _sentence,
                            validator: (value) {
                              return (value == null || value.isEmpty) ? 'Please fill Palindrome field!' : null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(15),
                              hintText: 'Palindrome',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xff6867775C),
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checkPalindrome();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(310, 41),
                      backgroundColor: const Color(0xff2B637B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "CHECK",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          name = _name.text;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Screen2(title: 'Second Screen', name: name, selectedName: 'Selected User Name',),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(310, 41),
                      backgroundColor: const Color(0xff2B637B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("NEXT",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}