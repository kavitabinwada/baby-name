import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddNameView extends StatefulWidget {
  const AddNameView({super.key});

  @override
  State<AddNameView> createState() => _AddNameViewState();
}

class _AddNameViewState extends State<AddNameView> {
  final TextEditingController GenderController = TextEditingController();
  final TextEditingController RashiController = TextEditingController();
  final TextEditingController NameController = TextEditingController();
  final TextEditingController ReligionController = TextEditingController();
  final TextEditingController MeaningController = TextEditingController();

/*  final FocusNode _focusNode = FocusNode();*/
  String? _selectedValue;

  Future<void> sendDataToFirebase() async {
    await Firebase.initializeApp();
    CollectionReference namesCollection =
        FirebaseFirestore.instance.collection('Names');

    try {
      await namesCollection.add({
        'gender': GenderController.text,
        'rashi': RashiController.text,
        'name': NameController.text,
        'meaning': MeaningController.text,
        'religion': ReligionController.text,
      });
      // Success logic here
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add data: $e'),
      ));
    }

    // Clear the text fields after data submission
    GenderController.clear();
    RashiController.clear();
    NameController.clear();
    MeaningController.clear();
    ReligionController.clear();

    // Show a success message to the user
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data added to Firebase successfully!'),
    ));
  }

/*  @override
  void dispose() {
    GenderController.dispose();
    _focusNode.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Name"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: GenderController,
                decoration: InputDecoration(
                  hintText: "Gender",
                  suffixIcon: PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Male',
                          child: Text('Male'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                      ];
                    },
                    onSelected: (String value) {
                      setState(() {
                        _selectedValue = value;
                        GenderController.text = _selectedValue!;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: RashiController,
                decoration: InputDecoration(
                  hintText: "Rashi",
                  suffixIcon: PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Aries',
                          child: Text('Aries'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Taurus',
                          child: Text('Taurus'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Gemini',
                          child: Text('Gemini'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Cancer',
                          child: Text('Cancer'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Leo',
                          child: Text('Leo'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Virgo',
                          child: Text('Virgo'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Libra',
                          child: Text('Libra'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Scorpio',
                          child: Text('Scorpio'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Sagittarius',
                          child: Text('Sagittarius'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Capricorn',
                          child: Text('Capricorn'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Aquarius',
                          child: Text('Aquarius'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Pisces',
                          child: Text('Pisces'),
                        ),
                      ];
                    },
                    onSelected: (String value) {
                      setState(() {
                        _selectedValue = value;
                        RashiController.text = _selectedValue!;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: NameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: MeaningController,
                decoration: InputDecoration(
                  hintText: "Meaning",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: ReligionController,
                decoration: InputDecoration(
                  hintText: "Religion",
                  suffixIcon: PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Hindu',
                          child: Text('Hindu'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Muslim',
                          child: Text('Muslim'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Sikh',
                          child: Text('Sikh'),
                        ),
                      ];
                    },
                    onSelected: (String value) {
                      setState(() {
                        _selectedValue = value;
                        ReligionController.text = _selectedValue!;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: sendDataToFirebase,
              child: Text(
                "Add Name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
