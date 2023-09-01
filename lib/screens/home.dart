// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_application_12/models/config.dart';
import 'package:flutter_application_12/models/users.dart';
import 'package:flutter_application_12/screens/login.dart';

import '../main.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountName = 'N/A';
    String accountEmail = 'N/A';
    String accountUrl =
        'https://img.salehere.co.th/p/1200x0/2021/04/12/7grsfosme3cy.jpg';

    Users user = Configure.login;
    //print(user.toJson().toString());
    if (user.id != null) {
      accountName = user.fullname!;
      accountEmail = user.email!;
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(accountUrl),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, Home.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Login'),
            onTap: () {
              Navigator.pushNamed(context, Login.routeName);
            },
          )
        ],
      ),
    );
  }
}

// class Home extends StatefulWidget {
//   static const routeName = '/';
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Widget mainBody = Container();
  // List<Users> _userList = [];

  // Future<void> getUsers() async {
  //   var url = Uri.http(Configure.server, 'users');
  //   var resp = await http.get(url);
  //   setState(() {
  //     _userList = usersFromJson(resp.body);
  //     mainBody = showUsers();
  //   });
  // }

  // Future<void> removeUsers(user) async {
  //   var url = Uri.http(Configure.server, 'users/${user.id}');
  //   var resp = await http.delete(url);
  //   print(resp.body);
  //   return;
  // }

  // Future<void> addNewUser(user) async {
  //   var url = Uri.http(Configure.server, 'users');
  //   var resp = await http.post(url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTP-8',
  //       },
  //       body: jsonEncode(user.toJson()));
  //   var rs = usersFromJson('[${resp.body}]');

  //   if (rs.length == 1) {
  //     Navigator.pop(context, 'refresh');
  //   }
  //   return;
  // }

  // Future<void> updateData(user) async {
  //   var url = Uri.http(Configure.server, 'users/${user.id}');
  //   var resp = await http.put(url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTP-8',
  //       },
  //       body: jsonEncode(user.toJson()));
  //   var rs = usersFromJson('[${resp.body}]');

  //   if (rs.length == 1) {
  //     Navigator.pop(context, 'refresh');
  //   }
  //   return;
  // }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Home'),
//         ),
//         drawer: const SideMenu(),
//         body: mainBody,
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             String result = await Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => UserForm()));
//             if (result == 'refresh') {
//               getUsers();
//             }
//           },
//           child: const Icon(Icons.person_add_alt_1),
//         ));
//   }

//   @override
//   void initState() {
//     super.initState();
//     Users user = Configure.login;
//     if (user.id != null) {
//       getUsers();
//       mainBody = showUsers();
//     }
//   }

//   Widget showUsers() {
//     return ListView.builder(
//       itemCount: _userList.length,
//       itemBuilder: (context, index) {
//         Users user = _userList[index];
//         return Dismissible(
//           key: UniqueKey(),
//           direction: DismissDirection.endToStart,
//           child: Card(
//             child: ListTile(
//               title: Text('${user.fullname}'),
//               subtitle: Text('${user.email}'),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => UserInfo(),
//                         settings: RouteSettings(arguments: user)));
//               },
//               trailing: IconButton(
//                 onPressed: () async {
//                   String result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => UserForm(),
//                           settings: RouteSettings(arguments: user)));
//                   if (result == 'refresh') {
//                     getUsers();
//                   }
//                 },
//                 icon: Icon(Icons.edit),
//               ),
//             ),
//           ),
//           onDismissed: (direction) {
//             removeUsers(user);
//           },
//           background: Container(
//             color: Colors.red,
//             margin: EdgeInsets.symmetric(horizontal: 15),
//             alignment: Alignment.centerRight,
//             child: Icon(
//               Icons.delete,
//               color: Colors.white,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
