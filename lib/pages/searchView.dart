// ignore_for_file: unnecessary_import, unused_import

import 'package:textingslap/chat/chatService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/chat/secondChat.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List _allResults = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();
  final AuthService _authService = AuthService();
  // final ChatService _chatService = ChatService();

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var clientData in _allResults) {
        var name = clientData['Name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientData);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .orderBy('Name')
        .get();
    setState(() {
      _allResults = data.docs.map((doc) => doc.data()).toList();
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['Name'] != _authService.getCurrentUser()!.email) {
      return ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SecondChat(
              receiverEmail: userData['Name'],
              receiverId: userData['Uid'],
            );
          }));
        },
        subtitle: Padding(
          padding: const EdgeInsets.only(),
          // child: Divider(),
        ),
        title: Text(
          userData['Name'],
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 111, 57, 132),
          title: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            // ignore: sort_child_properties_last
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search user...",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 205, 204, 204)),
                  border: InputBorder.none,
                  // prefixIcon: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.manage_search_outlined,
                  //       color: Colors.red,
                  //     ))
                ),
              ),
            ),
            width: 301,
            height: 34,
          )),
      body: ListView.builder(
        itemCount: _resultList.length,
        itemBuilder: (context, index) {
          return _buildUserListItem(_resultList[index], context);
        },
      ),
    );
  }
}







// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:textingslap/auth/authService.dart';
// import 'package:textingslap/chat/chatService.dart';
// import 'package:textingslap/components/userTile.dart';
// import 'package:textingslap/pages/secondChat.dart';

// class SearchView extends StatefulWidget {
//   const SearchView({super.key});

//   @override
//   State<SearchView> createState() => _SearchViewState();
// }

// class _SearchViewState extends State<SearchView> {
//    final ChatService _chatService = ChatService();
//   final AuthService _authService = AuthService();
//   //searchView:[1]
//   List _allResults = [];
//   List _resultList = [];
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     _searchController.addListener(_onSearchChanged);
//     super.initState();
//   }

//   _onSearchChanged() {
//     print(_searchController.text);
//     searchResultList();
//   }

//   searchResultList() {
//     var showResults = [];
//     if (_searchController.text != "") {
//       for (var clientSnapShot in _allResults) {
//         var name = clientSnapShot['Name'].toString().toLowerCase();
//         if (name.contains(_searchController.text.toLowerCase())) {
//           showResults.add(clientSnapShot);
//         }
//       }
//     } else {
//       showResults = List.from(_allResults);
//     }
//     setState(() {
//       _resultList = showResults;
//     });
//   }

//   getClientStream() async {
//     var data = await FirebaseFirestore.instance
//         .collection('Users')
//         .orderBy('Name')
//         .get();
//     setState(() {
//       _allResults = data.docs;
//     });
//     searchResultList();
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeDependencies() {
//     getClientStream();

//     super.didChangeDependencies();
//   }

//   //searchView:[2]
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: CupertinoSearchTextField(
//           controller: _searchController,
//         ),
//       ),
//       body: ListView.builder(
//           itemCount: _resultList.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.only(top: 10, bottom: 24),
//               child: Container(
//                 width: double.infinity,
//                 height: 40,
//                 child: ListTile(
//                   onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (context){
//                   return    _buildUserListItem( userData  , context);
//                  }));
//                   },
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(top: 19),
//                     child: Divider(),
//                   ),
//                   // subtitle: Text(_resultList[index]['E-mail']),
//                   title: Text(_resultList[index]['Name']),
//                 ),
//               ),
//             );
//           }),
//     );
//   }

//      Widget _buildUserListItem(
//       Map<String, dynamic> userData, BuildContext context) {
//     if (userData['Name'] != _authService.getCurrentUser()!.email) {
//       return UserTile(
//         text: userData["Name"],
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return SecondChat(
//               receiverEmail: userData['Name'],
//               receiverId: userData['Uid'],
//             );
//           }));
//         },
//       );
//     } else {
//       return Container();
//     }
//   }



// }
