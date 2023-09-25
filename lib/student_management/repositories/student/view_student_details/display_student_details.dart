// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase/student_management/repositories/student/student_operation/services/student_services.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('student details'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'addscreen');
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              )),
          // IconButton(
          //     icon: const Icon(Icons.logout_outlined),
          //     onPressed: () {
          //       Provider.of<AuthService>(context, listen: false).signOut();
          //       Navigator.of(context)
          //           .pushNamedAndRemoveUntil('login', (route) => false);
          //     }),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _reference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list
            return ListView.separated(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                //Get the item at this index
                Map thisItem = items[index];

                return // Card(
                    // elevation: 15,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10)),
                    Listtile(thisItem: thisItem);
              },
              separatorBuilder: (context, index) => const Divider(
                indent: 110,
                color: Colors.green,
              ),
            );
          }

          //Show loader
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
  });

  final Map thisItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${thisItem['name']}',
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      contentPadding: EdgeInsets.only(left: 20),
      horizontalTitleGap: 30,
      subtitle: Text('${thisItem['course']}',
          style: const TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 193, 191, 191))),
      //trailing: const Icon(Icons.arrow_forward_ios),

      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(45),
        ),
        child: thisItem.containsKey('imageUrl')
            ? CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(
                  '${thisItem['imageUrl']}',
                ),
              )
            : Container(),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'profile', arguments: thisItem);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Do you want to delete Student.?"),
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No")),
                TextButton(
                    onPressed: () {
                      Provider.of<StudentProvider>(context, listen: false)
                          .deleteStudent(thisItem['name']);
                      Navigator.pop(context);
                    },
                    child: const Text("Yes")),
              ],
            );
          }),
        );
      },
    );
  }
}
