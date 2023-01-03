// ignore_for_file: unnecessary_this, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class Model {
  String id;
  String name;
  String title;

  Model({required this.id, required this.name, required this.title});
}

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = Text(
    " Grid View Search",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.orange,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  late List<Model> _list;
  List<Model> _searchList = [];

  late bool _IsSearching;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    init();
  }

  void init() {
    _list = [];
    _list.add(
      Model(id: "1", name: "Vinayak", title: "Bansode"),
    );
    _list.add(
      Model(id: "2", name: "Gaurav", title: "Abuj"),
    );
    _list.add(
      Model(id: "3", name: "Kunal ", title: "Bhavsar"),
    );
    _list.add(
      Model(id: "4", name: "Bhagwat", title: "shinde"),
    );
    _list.add(
      Model(id: "5", name: "Karan", title: "Lase"),
    );
    _searchList = _list;

    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
          _buildSearchList();
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
          _buildSearchList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: buildBar(context),
        ),
        body: GridView.builder(
            itemCount: _searchList.length,
            itemBuilder: (context, index) {
              return GridItem(_searchList[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            )));
  }

  List<Model> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchList = _list;
    } else {
      _searchList = _list
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()) ||
              element.title.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
      print('${_searchList.length}');
      return _searchList;
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(400);
  Widget buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: appBarTitle,
      iconTheme: IconThemeData(color: Colors.orange),
      backgroundColor: Colors.black,
      actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = Icon(
                  Icons.close,
                  color: Colors.orange,
                );
                this.appBarTitle = TextField(
                  controller: _searchQuery,
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                  decoration: InputDecoration(
                      hintText: "Search here..",
                      hintStyle: TextStyle(color: Colors.white)),
                );
                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            });
          },
        ),
      ],
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(
        Icons.search,
        color: Colors.orange,
      );
      this.appBarTitle = Text(
        "Search Demo",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class GridItem extends StatelessWidget {
  final Model model;
  GridItem(this.model);

  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
      elevation: 10.0,
      child: InkWell(
        splashColor: Colors.orange,
        onTap: () {
          print(model.id);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/mobigic.jpeg')),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.model.name,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                    maxLines: 1,
                  ),
                  SizedBox(height: 0.0),
                  Text(
                    model.title,
                    style: TextStyle(fontFamily: 'Roboto'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
