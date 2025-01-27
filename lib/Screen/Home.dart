import 'package:flutter/material.dart';
import 'package:news_/Screen/News_vi.dart';
import 'package:news_/Screen/img_tit.dart';
import 'package:news_/Screen/news_p_v.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class News_h extends StatefulWidget {
  const News_h({super.key});

  @override
  State<News_h> createState() => _News_hState();
}

class _News_hState extends State<News_h> {
  String? searchterm;
  bool isSearching = false;
  late Future<List<Article>> future;
  TextEditingController searchcont = TextEditingController();
  List<String> selected = [
    "us",
    "eg",
  ];
  List<String> categoryItem = [
    "GENERAL",
    "BUSINESS",
    "ENTERTAINMENT",
    "HEALTH",
    "SCIENCE",
    "SPORTS",
    "TECHNOLOGY"
  ];
  String? selectedcatogry;
  String? selectedcountry = "us";

  @override
  void initState() {
    selectedcatogry = categoryItem[0];
    future = getNewsdata();
    super.initState();
  }

  Future<List<Article>> getNewsdata() async {
    NewsAPI newsAPI = NewsAPI(apiKey: "6d3d6ebea6004e4995939bb7a62f9f5c");
    return await newsAPI.getTopHeadlines(
        country: selectedcountry,
        query: searchterm,
        category: selectedcatogry,
        pageSize: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching ? searchApp() : Appbar(),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryItem.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => categoryItem[i] == selectedcatogry
                                  ? const Color.fromARGB(255, 207, 197, 197)
                                  : Colors.grey)),
                      onPressed: () {
                        setState(() {
                          selectedcatogry = categoryItem[i];
                        });
                        future = getNewsdata();
                      },
                      child: Text(
                        categoryItem[i],
                        style: TextStyle(color: Colors.white),
                      )),
                );
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error Loding the News"),
                  );
                } else {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return News_viwe(
                      article: snapshot.data as List<Article>,
                    );
                  } else {
                    return const Center(
                      child: Text("No News is Available"),
                    );
                  }
                }
              },
            ),
          ),
        ],
      )),
    );
  }

  Appbar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: Text(
        "News Now",
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      actions: [
        Icon(
          Icons.flag,
          color: Colors.white,
        ),
        DropdownButton(
            value: selectedcountry,
            items: selected
                .map(
                  (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(color: Colors.amber),
                      )),
                )
                .toList(),
            onChanged: (v) {
              setState(() {
                selectedcountry = v;
                future = getNewsdata();
              });
            }),
        IconButton(
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ))
      ],
    );
  }

  searchApp() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      iconTheme: IconThemeData(color: Colors.white),
      title: TextField(
        onChanged: (v) {
          setState(() {
            searchterm = v;
            future = getNewsdata();
          });
        },
        controller: searchcont,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white70),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent))),
      ),
      leading: IconButton(
          onPressed: () {
            setState(() {
              isSearching = false;
              searchterm = null;
              searchcont.text = "";
              future = getNewsdata();
            });
          },
          icon: Icon(Icons.arrow_back)),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                searchterm = searchcont.text;
                future = getNewsdata();
              });
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ))
      ],
    );
  }
}
