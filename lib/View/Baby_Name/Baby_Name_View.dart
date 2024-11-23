import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Add_Name/Add_Name_View.dart';
import '../search_name/search_name_view.dart';

class BabyNamesScreen extends StatefulWidget {
  @override
  _BabyNamesScreenState createState() => _BabyNamesScreenState();
}

class _BabyNamesScreenState extends State<BabyNamesScreen> {
  late List<BabyName> allNames = [];
  late List<BabyName> filteredNames = [];
  late List<String> favoriteNames = [];
  String? selectedGender;
  String? selectedRashi;
  String? selectedAlpha;
  String? selectedReligion;
  List<BabyName> searchResults = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // fetchNamesFromFirebase();
  }

  void searchNames(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    print('Searching for: $query'); // Debugging line

    FirebaseFirestore.instance
        .collection('Names')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get()
        .then((querySnapshot) {
      searchResults = querySnapshot.docs.map((doc) {
        return BabyName.fromFirestore(doc);
      }).toList();

      print('Found ${searchResults.length} results'); // Debugging line
      setState(() {});
    }).catchError((error) {
      print('Error fetching names: $error');
    });
  }

  void fetchNamesFromFirebase() {
    FirebaseFirestore.instance
        .collection('baby_names')
        .get()
        .then((querySnapshot) {
      allNames = querySnapshot.docs.map((doc) {
        return BabyName.fromFirestore(doc);
      }).toList();

      filteredNames =
          List.from(allNames); // Initialize filteredNames with all names
      print('Fetched names: ${allNames.length}'); // Debugging line
      setState(() {}); // Update the UI
    }).catchError((error) {
      print('Error fetching names: $error'); // Error handling
    });
  }

  void filterNames() {
    filteredNames = allNames.where((name) {
      if (selectedGender != null && name.gender != selectedGender) {
        return false;
      }
      if (selectedRashi != null && name.rashi != selectedRashi) {
        return false;
      }
      if (selectedAlpha != null && !name.name.startsWith(selectedAlpha!)) {
        return false;
      }
      if (selectedReligion != null && name.religion != selectedReligion) {
        return false;
      }
      return true;
    }).toList();
    setState(() {});
  }

  void searchByName(String query) {
    filteredNames = allNames.where((name) {
      return name.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {});
  }

  void toggleFavorite(String name) {
    if (favoriteNames.contains(name)) {
      favoriteNames.remove(name);
    } else {
      favoriteNames.add(name);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Names'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              fetchNamesFromFirebase(); // Refresh the list
            },
          ),
          /*IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favoriteNames');
            },
            icon: Icon(Icons.favorite),
          ),*/
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchNamesScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Baby Name',
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Add Name'),
              trailing: Icon(Icons.add),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNameView(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Religion'),
              trailing: Icon(Icons.temple_hindu_outlined),
              onTap: () {
                // Show religion selection dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Select Any Religion'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text('Hindu'),
                            onTap: () {
                              setState(() {
                                selectedReligion = 'Hindu';
                                filterNames();
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            title: Text('Muslim'),
                            onTap: () {
                              setState(() {
                                selectedReligion = 'Muslim';
                                filterNames();
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            title: Text('Sikh'),
                            onTap: () {
                              setState(() {
                                selectedReligion = 'Sikh';
                                filterNames();
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            title: Text('Other'),
                            onTap: () {
                              setState(() {
                                selectedReligion = 'Other';
                                filterNames();
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedGender,
                    hint: Text('Gender'),
                    items: <String>['Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                        filterNames(); // Apply filters on gender change
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedRashi,
                    hint: Text('Rashi'),
                    items: <String>[
                      'Aries',
                      'Taurus',
                      'Gemini',
                      'Cancer',
                      'Leo',
                      'Virgo',
                      'Libra',
                      'Scorpio',
                      'Sagittarius',
                      'Capricorn',
                      'Aquarius',
                      'Pisces',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRashi = newValue;
                        filterNames(); // Apply filters on rashi change
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedAlpha,
                    hint: Text('Alpha..'),
                    items: <String>[
                      'A',
                      'B',
                      'C',
                      'D',
                      'E',
                      'F',
                      'G',
                      'H',
                      'I',
                      'J',
                      'K',
                      'L',
                      'M',
                      'N',
                      'O',
                      'P',
                      'Q',
                      'R',
                      'S',
                      'T',
                      'U',
                      'V',
                      'W',
                      'X',
                      'Y',
                      'Z',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAlpha = newValue;
                        filterNames(); // Apply filters on alpha change
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value;
                      searchNames(searchQuery);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Text('Total Names: ${searchResults.length}'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index].name),
                  subtitle: Row(
                    children: <Widget>[
                      Flexible(
                          child: Text(
                              "meaning : ${searchResults[index].meaning} \n")),
                      Text("gender : ${searchResults[index].gender} \n"),
                      Text("rashi : ${searchResults[index].rashi} \n"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Name {
  String name;
  String gender;
  String rashi;
  String meaning;
  String religion; // Added religion field

  Name(
      {required this.name,
      required this.gender,
      required this.rashi,
      required this.meaning,
      required this.religion});
}

class BabyName extends Name {
  BabyName(
      {required String name,
      required String gender,
      required String rashi,
      required String meaning,
      required String religion})
      : super(
            name: name,
            gender: gender,
            rashi: rashi,
            meaning: meaning,
            religion: religion);

  factory BabyName.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BabyName(
      name: data['name'],
      gender: data['gender'],
      rashi: data['rashi'],
      meaning: data['meaning'],
      religion: data['religion'], // Ensure this field exists in Firestore
    );
  }
}
