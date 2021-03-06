import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RouF/globals.dart' as globals;

class FriendStatus extends StatefulWidget {
  const FriendStatus({Key? key}) : super(key: key);

  @override
  State<FriendStatus> createState() => _FriendStatusState();
}

class _FriendStatusState extends State<FriendStatus> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int actionKey = 8;
  bool isBreathing = false;

  @override
  Widget build(BuildContext context) {
    // print('\n \n currentUid는 지금 ${globals.currentUid}');
    // print('\n \n currentUsername은 지금 ${globals.currentUsername}');
    // print('\n \n currentEmail은 지금 ${globals.currentEmail}');
    return Container(
        height: MediaQuery.of(context).size.height * 0.37,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user/${globals.currentUid}/friends')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    // child: Text('친구를 추가하고 실시간으로 친구들과 일상을 공유해보세요!',
                    //     style: TextStyle(
                    //         fontSize: 11, fontWeight: FontWeight.w200)),
                    child: Container(),
                  );
                  // return Center(
                  //   child: CircularProgressIndicator(),
                  // );
                }
                final docs = snapshot.data!.docs;

                return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: docs.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            if (docs.length == 0)
                              return Container(
                                //height: 300,
                                alignment: Alignment.bottomCenter,
                                child: Center(
                                  child: Text('친구를 추가하고 실시간으로 친구들과 일상을 공유해보세요!',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200)),
                                ),
                              );
                            else
                              return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('user')
                                      .doc('${docs[index]['uid']}')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<
                                              DocumentSnapshot<
                                                  Map<String, dynamic>>>
                                          snapshot2) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return SizedBox(
                                        height: 0,
                                        width: 0,
                                      );
                                      // Center(
                                      //   child: CircularProgressIndicator(),
                                      // );
                                    }
                                    try {
                                      actionKey = snapshot2.data!['statusKey'];
                                      if (actionKey == 8)
                                        isBreathing = true;
                                      else
                                        isBreathing = false;
                                    } catch (e) {
                                      return SizedBox(
                                        height: 0,
                                        width: 0,
                                      );
                                    }

                                    return Container(
                                        //padding:,
                                        child: ListTile(
                                      horizontalTitleGap: 6.0,
                                      dense: true,
                                      // 친구 프로필사진
                                      leading: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: isBreathing
                                            ? Colors.transparent
                                            : Color(0xffddeacf),
                                        child: Image.asset(
                                          'assets/images/TaskIcon/${globals.tasks[actionKey]}.png',
                                          height: isBreathing ? 21 : 20,
                                          width: isBreathing ? 21 : 20,
                                        ),
                                      ),
                                      // 친구 이름
                                      title: Text(
                                          docs[index]['name'] +
                                              '는 ' +
                                              globals.action[actionKey],
                                          style: TextStyle(fontSize: 16)),
                                    ));
                                  });
                          },
                        )
                      : Container(
                          child: Center(
                            child: Text('친구를 추가하고 실시간으로 친구들과 일상을 공유해보세요!',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ),
                        ),
                );
              },
            )
          ],
        ));
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:RouF/globals.dart' as globals;

// class FriendStatus extends StatefulWidget {
//   const FriendStatus({Key? key}) : super(key: key);

//   @override
//   State<FriendStatus> createState() => _FriendStatusState();
// }

// class _FriendStatusState extends State<FriendStatus> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   int actionKey = 8;
//   bool isBreathing = false;

//   @override
//   Widget build(BuildContext context) {
//     // print('\n \n currentUid는 지금 ${globals.currentUid}');
//     // print('\n \n currentUsername은 지금 ${globals.currentUsername}');
//     // print('\n \n currentEmail은 지금 ${globals.currentEmail}');
//     return Container(
//         padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//         child: Column(
//           children: [
//             StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('user/${globals.currentUid}/friends')
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   // return Center(
//                   //   child: Text('친구를 추가하고 실시간으로 친구들과 일상을 공유해보세요!',
//                   //       style: TextStyle(
//                   //           fontSize: 11, fontWeight: FontWeight.w200)),
//                   // );
//                   // return Center(
//                   //   child: CircularProgressIndicator(),
//                   // );

//                 }
//                 final docs = snapshot.data!.docs;

//                 return Container(
//                   height: MediaQuery.of(context).size.height * 0.39,
//                   child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: docs.length,
//                     itemBuilder: (context, index) {
//                       return StreamBuilder(
//                           stream: FirebaseFirestore.instance
//                               .collection('user')
//                               .doc('${docs[index]['uid']}')
//                               .snapshots(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<
//                                       DocumentSnapshot<Map<String, dynamic>>>
//                                   snapshot2) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Text('친구를 추가하고 실시간으로 친구들과 일상을 공유해보세요!',
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w200));
//                               // Center(
//                               //   child: CircularProgressIndicator(),
//                               // );
//                             }
//                             try {
//                               actionKey = snapshot2.data!['statusKey'];
//                               if (actionKey == 8)
//                                 isBreathing = true;
//                               else
//                                 isBreathing = false;
//                             } catch (e) {
//                               return SizedBox(
//                                 height: 0,
//                                 width: 0,
//                               );
//                             }
//                             // actionKey = snapshot2.data!['statusKey'];

//                             return Container(
//                                 //padding:,
//                                 child: ListTile(
//                               horizontalTitleGap: 6.0,
//                               dense: true,
//                               // 친구 프로필사진
//                               leading: CircleAvatar(
//                                 radius: 18,
//                                 backgroundColor: isBreathing
//                                     ? Colors.transparent
//                                     : Color(0xffddeacf),
//                                 child: Image.asset(
//                                   'assets/images/TaskIcon/${globals.tasks[actionKey]}.png',
//                                   height: isBreathing ? 21 : 20,
//                                   width: isBreathing ? 21 : 20,
//                                 ),
//                               ),
//                               // 친구 이름
//                               title: Text(
//                                   docs[index]['name'] +
//                                       '는 ' +
//                                       globals.action[actionKey],
//                                   style: TextStyle(fontSize: 16)),
//                             ));
//                           });
//                     },
//                   ),
//                 );
//               },
//             )
//           ],
//         ));
//   }
// }
