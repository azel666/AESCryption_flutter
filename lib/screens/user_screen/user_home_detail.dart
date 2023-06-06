import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sistem_kriptografi/resources/firestore_method.dart';

class UserHomeDetail extends StatefulWidget {
  final detail;
  const UserHomeDetail({required this.detail, super.key});

  @override
  State<UserHomeDetail> createState() => _UserHomeDetailState();
}

class _UserHomeDetailState extends State<UserHomeDetail> {
  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          // backgroundColor: "#2E4053".toColor(),
          backgroundColor: Colors.grey,
          title: const Text(
            'Image',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirestoreMethod().deleteImageUser(
                      widget.detail['imageUrl'], widget.detail['imageid']);
                  Get.back();
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: content());
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      width: MediaQuery.of(context).size.width,
      height: 430,
      child: PhysicalModel(
        elevation: 3,
        color: Colors.white,
        child: SizedBox(
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
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              Image.network(widget.detail['imageUrl']).image),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              widget.detail['imageName'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(widget.detail['createdAt'].toDate()),
                              style: const TextStyle(fontSize: 16),
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
