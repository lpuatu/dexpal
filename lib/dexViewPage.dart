import 'package:DexPal/pokeInfoPage.dart';
import 'package:DexPal/pokeMon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

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
  List<String> typeTable = [];
  var searchController = TextEditingController();

  void initState() {
    dexLoad();
    super.initState();
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
    for (int i = 1; i < dexCsv.length; i++) {
      //Start at row 1 becuase row 0 is the column names
      fullDexTable.add(pokeMon(
          dexCsv[i][0],
          dexCsv[i][1],
          dexCsv[i][2],
          dexCsv[i][3],
          dexCsv[i][4],
          dexCsv[i][5],
          dexCsv[i][6],
          dexCsv[i][7],
          dexCsv[i][8],
          dexCsv[i][9],
          dexCsv[i][10],
          dexCsv[i][11],
          dexCsv[i][12],
          dexCsv[i][13]));
    }
    print('Done');

    viewDexTable = fullDexTable;
    typeTable.add('Grass');
    typeTable.add('Bug');
    typeTable.add('Dark');
    typeTable.add('Dragon');
    typeTable.add('Electric');
    typeTable.add('Fairy');
    typeTable.add('Fighting');
    typeTable.add('Fire');
    typeTable.add('Flying');
    typeTable.add('Ghost');
    typeTable.add('Ground');
    typeTable.add('Ice');
    typeTable.add('Normal');
    typeTable.add('Poison');
    typeTable.add('Psychic');
    typeTable.add('Rock');
    typeTable.add('Steel');
    typeTable.add('Water');

    setState(() {
      isLoading = false; // your loader will stop to finish after the data fetch
    });
  }

  void searchFunction(String searchTerm) {
    setState(() {
      isLoading = true; // your loader has started to load
    });
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
      isLoading = false;
      viewDexTable = searchDexTable;
    });
  }

  void filterFunction(String type) {
    setState(() {
      isLoading = true; // your loader has started to load
    });
    List<pokeMon> filterDexTable = [];

    setState(() {
      isLoading = false;
      viewDexTable = filterDexTable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
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
      /*bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 10,
              ),
              label: 'PokeDex',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
          ],
        ),
      ),*/
      endDrawer: Drawer(
        backgroundColor: Colors.grey[200],
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(3),
                itemCount: typeTable.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          child: ElevatedButton(
                        onPressed: () {},
                        child: Image.asset(
                            'pokeSprites/types/' + typeTable[index] + '.png'),
                      )),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
                    onChanged: (_) => searchFunction(searchController.text),
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: IconButton(
                        onPressed: () {
                          //Fix clear button to reset the dex view
                          searchController.clear;
                        },
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Row(children: [
                                    Image.asset('pokeSprites/teamSprite/' +
                                        viewDexTable[index].teamSprite),
                                    const Spacer(),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(viewDexTable[index].dexName),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: Text(viewDexTable[index]
                                          .dexNum
                                          .toString()),
                                    )
                                  ]),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
