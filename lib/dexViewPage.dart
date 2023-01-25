import 'package:DexPal/dexInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

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
  String filterTerm = '';
  List<pokeMon> dexTable = [];
  TextEditingController? searchController;

  void initState() {
    super.initState();
    dexLoad();
    // On page load action.
  }

  void dispose() {
    searchController?.dispose();
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
      dexTable
          .add(pokeMon(dexCsv[i][0], dexCsv[i][1], dexCsv[i][2], dexCsv[i][3]));

    setState(() {
      isLoading = false; // your loader will stop to finish after the data fetch
    });
  }

  bool searchFunction(
    String searchFor,
    String searchIn,
  ) {
    return searchIn.toLowerCase().contains(searchFor.toLowerCase());
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          obscureText: false,
                          maxLines: 1,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(3),
                          itemCount: dexTable.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Visibility(
                              visible: true,
                              child: Ink(
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
                                                  detailPoke: dexTable[index]),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    child: Row(children: [
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Image.asset(
                                              'pokeSprites/teamSprite/' +
                                                  dexTable[index].teamSprite)),
                                      Spacer(),
                                      Text(dexTable[index].dexName),
                                      Spacer(),
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                          child: Text(dexTable[index]
                                              .dexNum
                                              .toString()))
                                    ]),
                                  ),
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
