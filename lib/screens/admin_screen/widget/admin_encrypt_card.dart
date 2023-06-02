import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sistem_kriptografi/screens/admin_screen/admin_encrypt_detail.dart';

class AdminEncryptCard extends StatefulWidget {
  final listAllDocument;
  const AdminEncryptCard({required this.listAllDocument, super.key});

  @override
  State<AdminEncryptCard> createState() => _AdminEncryptCardState();
}

class _AdminEncryptCardState extends State<AdminEncryptCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.listAllDocument.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                var detail = widget.listAllDocument[index].data()
                    as Map<String, dynamic>;
                Get.to(AdminEncryptDetail(detail: detail));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    // ignore: prefer_const_constructors
                    BoxShadow(
                      blurRadius: 6,
                      color: Color(0x34000000),
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),

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
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 230,
                          child: Text(
                            "${(widget.listAllDocument[index].data() as Map<String, dynamic>)["imageName"]}",
                            style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: 230,
                          child: Text(
                            DateFormat.yMMMd().format(
                                (widget.listAllDocument[index].data()
                                        as Map<String, dynamic>)['createdAt']
                                    .toDate()),
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                color: Colors.black54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
