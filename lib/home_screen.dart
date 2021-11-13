import 'package:flutter/material.dart';
import 'package:learn_flutter/todo_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  bool isLoggedIn;
  Function? setLoggedIn;
  SharedPreferences? prefs;
  MyHomePage({Key? key, this.isLoggedIn = false, this.setLoggedIn, this.prefs})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textEditingController = TextEditingController();

  final primaryColor = const Color(0xFF151026);
  final inPrimaryColor = const Color(0xFF151030);

  String text = "Add item";
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    if (widget.prefs != null) {
      items = widget.prefs?.getStringList('items') ?? [];
    }
  }

  addToDo() {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        items.add(_textEditingController.text);
        _textEditingController.clear();
      });
    }
    FocusScope.of(context).unfocus();
  }

  logout() {
    widget.setLoggedIn!(false);
  }

  @override
  Widget build(BuildContext context) {
    widget.prefs?.setStringList('items', items);

    var dropdownMenu = PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: const ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
          onTap: logout,
        ),
      ],
    );

    var addContainer = Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: inPrimaryColor),
        child: Column(
          children: [
            const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                backgroundImage: AssetImage("assets/images/avatar.png")),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _textEditingController,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  addToDo();
                },
                decoration: InputDecoration(
                  hintText: 'Item',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: addToDo,
                child: const Text('Add'),
              ),
            ),
          ],
        ));

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: const Text('Todo Page'),
          actions: [
            dropdownMenu,
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              addContainer,
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: inPrimaryColor),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodoDetailsScreen(
                                    title: items[index],
                                    description: '',
                                    position: index),
                              ),
                            );
                          },
                          title: Text(
                            items[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text(
                            'Subtitle',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 40,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                items.removeAt(index);
                              });
                            },
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
