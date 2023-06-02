import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sistem_kriptografi/resources/storage_method.dart';
import 'package:sistem_kriptografi/services/encrypt.dart';

class AdminEncryptDetail extends StatefulWidget {
  final detail;
  const AdminEncryptDetail({required this.detail, super.key});

  @override
  State<AdminEncryptDetail> createState() => _AdminEncryptDetailState();
}

class _AdminEncryptDetailState extends State<AdminEncryptDetail> {
  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          // backgroundColor: "#2E4053".toColor(),
          backgroundColor: Colors.grey,
          title: const Text(
            'Image Encrypt',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              offset: Offset(0.0, appBarHeight),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              onSelected: (value) async {
                if (value == 'download') {
                  await StorageMethod().downloadEncryptImage(
                      widget.detail['imageUrl'], widget.detail['imageName']);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Downloaded ${widget.detail['imageName']}')));
                } else if (value == 'delete') {
                  // logout();
                }
              },

              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                      value: 'download',
                      child: Row(
                        children: [
                          Icon(
                            Icons.download,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'download',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      )),
                  const PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'delete',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      )),
                ];
              },
              iconSize: 30,
              icon: const Icon(Icons.menu), // Ikonya di sini
            ),
          ],
        ),
        body: content());
  }

  Widget content() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      width: MediaQuery.of(context).size.width,
      height: 430,
      child: PhysicalModel(
        elevation: 3,
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey,

                      // image: DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: Image.network(
                      //             '${(widget.listAllDocument[index].data() as Map<String, dynamic>)["imageUrl"]}')
                      //         .image),
                    ),
                    child: Center(
                      child: Text(
                        'Encrypted',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              widget.detail['imageName'],
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(widget.detail['createdAt'].toDate()),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
