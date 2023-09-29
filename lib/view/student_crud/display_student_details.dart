// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase/view_model/student_services/student_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetails extends StatelessWidget {
  StudentDetails({super.key});

  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  final _reference =
      FirebaseFirestore.instance.collection('student_management');

  @override
  Widget build(BuildContext context) {
    //print('build');
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text(
          'student details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFE5E5E5),
        elevation: 0,
        centerTitle: true,
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'addscreen');
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              )),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _reference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data.docs;
            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list
            return ListView.separated(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot studentSnap = snapshot.data.docs[index];
                String id = studentSnap.id;

                Map thisItem = items[index];

                return Listtile(
                  thisItem: thisItem,
                  id: id,
                );
              },
              separatorBuilder: (context, index) => const Divider(
                indent: 110,
                color: Colors.green,
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

//

class Listtile extends StatelessWidget {
  const Listtile({
    super.key,
    required this.thisItem,
    required this.id,
  });

  final Map thisItem;
  final String id;

  void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Do you want to delete Student.?"),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No")),
            TextButton(
              onPressed: () {
                Provider.of<StudentProvider>(context, listen: false)
                    .deleteStudent(id);
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${thisItem['name']}',
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      contentPadding: const EdgeInsets.only(left: 20),
      horizontalTitleGap: 30,
      subtitle: Text(
        '${thisItem['course']}',
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(45),
        ),
        child: thisItem.containsKey('imageUrl')
            ? CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFE5E5E5),
                backgroundImage: NetworkImage(
                  '${thisItem['imageUrl']}',
                ),
              )
            : Container(),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'edit',
            arguments: {'myMap': thisItem, 'id': id});
      },
      onLongPress: () {
        deleteDialog(context);
      },
    );
  }
}
