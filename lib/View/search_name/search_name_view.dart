import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Class/Baby_Name_Class.dart';

class SearchNamesScreen extends StatefulWidget {
  @override
  _SearchNamesScreenState createState() => _SearchNamesScreenState();
}

class _SearchNamesScreenState extends State<SearchNamesScreen> {
  List<BabyName> searchResults = [];
  String searchQuery = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Names'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                searchQuery = value;
                searchNames(searchQuery);
              },
              decoration: InputDecoration(
                hintText: 'Search for a name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index].name),
                    subtitle: Text(searchResults[index].meaning),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
