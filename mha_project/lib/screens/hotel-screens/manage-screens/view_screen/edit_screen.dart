import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final List<String> roomType = [
  "SINGLE",
  "DOUBLE",
  "QUAD",
  "TWIN",
  "STANDARD",
  "SUPERIOR",
  "DELUXE",
  "EXECUTIVE",
];
final List<String> serviceType = [
  "CLEAN UP",
  "LAUNDRY",
  "RECEPTION",
  "LUGGAGE",
  "Food & Beverage",
  "TRANSPORT",
  "CALLING",
];
final List<String> customerType = [
  "International",
  "National",
];

class EditScreen extends StatefulWidget {
  EditScreen(
      {super.key,
      required this.categoryName,
      required this.parameter1,
      required this.parameter2,
      required this.parameter3,
      required this.parameter4,
      required this.parameter5,
      required this.showBottomSheetHeight,
      required this.docId});
  final String parameter1,
      parameter2,
      parameter4,
      parameter5,
      docId,
      categoryName;
  String? parameter3;
  final double showBottomSheetHeight;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String _setImage() {
    if (widget.categoryName == 'room') {
      return 'assets/images/room.jpg';
    } else if (widget.categoryName == 'service') {
      return 'assets/images/service.jpg';
    } else if (widget.categoryName == 'employee') {
      return 'assets/images/employee.jpg';
    }
    return 'assets/images/customer.jpg';
  }

  final TextEditingController _parameter1Controller = TextEditingController();
  final TextEditingController _parameter2Controller = TextEditingController();
  final TextEditingController _parameter4Controller = TextEditingController();
  final TextEditingController _parameter5Controller = TextEditingController();
  void initState() {
    _parameter1Controller.text = widget.parameter1;
    _parameter2Controller.text = widget.parameter2;
    _parameter4Controller.text = widget.parameter4;
    _parameter5Controller.text = widget.parameter5;
    super.initState();
  }

  void EditDialog(context, id, categoryName) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Edit!'),
              content: Text('Are you sure you want to update this object?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _EditObject(context, id, categoryName);
                    // Navigator.of(context).pop(context);
                  },
                  child: Text('Sure'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text('Cancel'),
                ),
              ],
            ));
  }

  void _EditObject(context, id, categoryName) async {
    final enterParameter1 = _parameter1Controller.text;
    final enterParameter2 = _parameter2Controller.text;
    final enterParameter4 = _parameter4Controller.text;
    final enterParameter5 = _parameter5Controller.text;
    if (categoryName == 'room') {
      await FirebaseFirestore.instance.collection(categoryName).doc(id).update({
        'address': enterParameter1,
        'floor': enterParameter2,
        'type': widget.parameter3,
        'beds': enterParameter4,
        'price': enterParameter5,
      });
    } else if (categoryName == 'service') {
      await FirebaseFirestore.instance.collection(categoryName).doc(id).update({
        'id': enterParameter1,
        'name': enterParameter2,
        'type': widget.parameter3,
        'number': enterParameter4,
        'price': enterParameter5,
      });
    } else if (categoryName == 'employee') {
      await FirebaseFirestore.instance.collection(categoryName).doc(id).update({
        'id': enterParameter1,
        'name': enterParameter2,
        'type': widget.parameter3,
        'number': enterParameter4,
        'email': enterParameter5,
      });
    } else if (categoryName == 'customer') {
      await FirebaseFirestore.instance.collection(categoryName).doc(id).update({
        'id': enterParameter1,
        'name': enterParameter2,
        'type': widget.parameter3,
        'number': enterParameter4,
        'email': enterParameter5,
      });
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Edit sucess!'),
      ),
    );

    // pop 2 screens
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 3);

    // SnackBar(content: const Text('Delete sucess!'));
  }

  @override
  void dispose() {
    _parameter1Controller.dispose();
    _parameter2Controller.dispose();
    _parameter4Controller.dispose();
    _parameter5Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Edit ${widget.categoryName[0].toUpperCase()}${widget.categoryName.substring(1).toLowerCase()}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              letterSpacing: 3.0,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: Text(
                      (widget.categoryName == 'room')
                          ? 'Room\'s address:'
                          : '${widget.categoryName[0].toUpperCase()}${widget.categoryName.substring(1).toLowerCase()}\'s Id:',
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0)),
                ),
                Expanded(
                  child: TextField(
                    controller: _parameter1Controller,
                    decoration: InputDecoration(
                      hintText: widget.parameter1,
                      hintStyle: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ]),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        (widget.categoryName == 'room') ? 'Floor :' : 'Name:',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _parameter2Controller,
                      keyboardType: widget.categoryName == 'room'
                          ? TextInputType.number
                          : TextInputType.text,
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: widget.parameter2,
                        hintStyle: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Type:',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                  ),
                  Expanded(
                    child: Container(
                      child: DropdownButton(
                        isExpanded: true,
                        value: widget.parameter3,
                        items: widget.categoryName == 'room'
                            ? roomType
                                .map((data) => DropdownMenuItem(
                                    value: data, child: Text(data)))
                                .toList()
                            : widget.categoryName == 'service'
                                ? serviceType
                                    .map((data) => DropdownMenuItem(
                                        value: data, child: Text(data)))
                                    .toList()
                                : widget.categoryName == 'employee'
                                    ? serviceType
                                        .map((data) => DropdownMenuItem(
                                            value: data, child: Text(data)))
                                        .toList()
                                    : customerType
                                        .map((data) => DropdownMenuItem(
                                            value: data, child: Text(data)))
                                        .toList(),
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        underline: SizedBox(),
                        onChanged: (value) => setState(() {
                          widget.parameter3 = value;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        (widget.categoryName == 'room')
                            ? 'Number of bed:'
                            : 'Number:',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _parameter4Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: widget.parameter4,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      (widget.categoryName == 'room' ||
                              widget.categoryName == 'service')
                          ? 'Price:'
                          : 'Email:',
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _parameter5Controller,
                      keyboardType: widget.categoryName == 'room' ||
                              widget.categoryName == 'service'
                          ? TextInputType.number
                          : TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: widget.parameter5,
                          prefixIcon: widget.categoryName == 'room' ||
                                  widget.categoryName == 'service'
                              ? Icon(Icons.attach_money)
                              : Icon(Icons.email),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 25,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Ink(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)), //<-- SEE HERE
                child: InkWell(
                  borderRadius: BorderRadius.circular(100.0),
                  onTap: () {
                    EditDialog(context, widget.docId, widget.categoryName);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.check,
                      size: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
