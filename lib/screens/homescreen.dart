import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:whatsappshortlink/listcountry.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCountryCode;
  Text text;
  final TextEditingController telController = new TextEditingController();

  final TextEditingController messageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image.asset(
            "background.png",
            color: Colors.white.withOpacity(.3),
            colorBlendMode: BlendMode.dstOut,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(.3)),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        child: SearchableDropdown.single(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          displayClearIcon: false,
                          iconSize: 0,
                          underline: Container(),
                          items: listCountry
                              .map((e) => DropdownMenuItem(
                                    value: e['dialCode'].toString(),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          e['flag'],
                                          height: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            e['dialCode'] + " " + e['name'],
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                          value: selectedCountryCode == null
                              ? "+62"
                              : selectedCountryCode,
                          hint: "Select one",
                          searchHint: "Search your country code",
                          searchFn: (String keyword, items) {
                            List<int> ret = List<int>();
                            if (keyword != null &&
                                items != null &&
                                keyword.isNotEmpty) {
                              keyword.split(" ").forEach((k) {
                                int i = 0;
                                items.forEach((item) {
                                  if (k.isNotEmpty &&
                                      (item.child.children[2].child.data
                                          .toString()
                                          .toLowerCase()
                                          .contains(k.toLowerCase()))) {
                                    ret.add(i);
                                  }
                                  i++;
                                });
                              });
                            }
                            if (keyword.isEmpty) {
                              ret =
                                  Iterable<int>.generate(items.length).toList();
                            }
                            return (ret);
                          },
                          onChanged: (String value) {
                            setState(() {
                              selectedCountryCode = value.replaceFirst("+", "");
                              print(selectedCountryCode);
                            });
                          },
                          dialogBox: true,
                          isExpanded: true,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: telController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Your Destination Number"),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(.3)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Your message"),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff25D366),
        onPressed: () async {
          await FlutterOpenWhatsapp.sendSingleMessage(
              selectedCountryCode + telController.text, messageController.text);
        },
        child: Icon(Icons.send_rounded),
      ),
    );
  }
}
