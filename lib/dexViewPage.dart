import 'package:DexPal/dexInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:easy_debounce/easy_debounce.dart';

class pokeMon {
  String dexName;
  int dexNum;
  String teamSprite;
  String homeSprite;

  pokeMon(this.dexName, this.dexNum, this.teamSprite, this.homeSprite);
}

class DexPage extends StatefulWidget {
  const DexPage({Key? key}) : super(key: key);

  @override
  State<DexPage> createState() => DexPageState();
}

class DexPageState extends State<DexPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false; // This is initially false where no loading state
  List<pokeMon> fullDexTable = [];
  List<pokeMon> viewDexTable = [];
  var searchController = TextEditingController();

  void initState() {
    super.initState();
    dexLoad();
    viewDexTable = fullDexTable;
    // On page load action.
  }

  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  dexLoad() async {
    setState(() {
      isLoading = true; // your loader has started to load
    });
    final myData = await rootBundle.loadString("assets/mariadex1.csv");
    List<List<dynamic>> dexCsv = CsvToListConverter().convert(myData);
    for (int i = 1;
        i < dexCsv.length;
        i++) //Start at row 1 becuase row 0 is the column names{
      fullDexTable
          .add(pokeMon(dexCsv[i][0], dexCsv[i][1], dexCsv[i][2], dexCsv[i][3]));

    setState(() {
      isLoading = false; // your loader will stop to finish after the data fetch
    });
  }

  void searchFunction(String searchTerm) {
    List<pokeMon> searchDexTable = [];
    if (searchTerm.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      searchDexTable = fullDexTable;
    } else {
      searchDexTable = fullDexTable
          .where((poke) =>
              poke.dexName.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      viewDexTable = searchDexTable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
        // The title text which will be shown on the action bar
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Pokédex',
          ),
          centerTitle: true,
          elevation: 2,
        ),
      ),
      endDrawer: Drawer(
        child: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
        ]),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) => EasyDebounce.debounce(
                        'searchController', Duration(milliseconds: 2000),
                        () async {
                      searchFunction(value);
                    }),
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: IconButton(
                        onPressed: searchController.clear,
                        icon: Icon(Icons.clear),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    obscureText: false,
                    maxLines: 1,
                  )),
            ],
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(3),
                          itemCount: viewDexTable.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Ink(
                              color: Colors.white,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PokeInfo(
                                                detailPoke:
                                                    viewDexTable[index]),
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue[50]!,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Row(children: [
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: Image.asset(
                                            'pokeSprites/teamSprite/' +
                                                viewDexTable[index]
                                                    .teamSprite)),
                                    Spacer(),
                                    Text(viewDexTable[index].dexName),
                                    Spacer(),
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                        child: Text(viewDexTable[index]
                                            .dexNum
                                            .toString()))
                                  ]),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
          Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Row(
              children: [
                Spacer(),
                IconButton(
                  splashRadius: 10,
                  color: Colors.white,
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
