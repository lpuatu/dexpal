import 'package:DexPal/pokeInfoPage.dart';
import 'package:DexPal/pokeMon.dart';
import 'package:DexPal/dataload.dart';
import 'package:DexPal/navBar.dart';
import 'package:flutter/material.dart';

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
  List<bool> isPressed = [];

  var searchController = TextEditingController();

  List<String> filters = [];
  bool typeCheck = false;

  @override
  void initState() {
    dexLoad();
    super.initState();
    // On page load action.
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  dexLoad() async {
    setState(() {
      isLoading = true; // your loader has started to load
    });

    fullDexTable = await dexTableLoad();
    viewDexTable = fullDexTable;
    typeTable = typeTableLoad();
    isPressed = List<bool>.filled(typeTable.length, false);

    setState(() {
      isLoading = false;
    });
  }

  void searchFunction(String searchTerm) {
    setState(() {
      isLoading = true; // your loader has started to load
    });

    List<pokeMon> searchDexTable = [];

    if (searchTerm.isEmpty) {
      searchDexTable = fullDexTable;
      searchController.clear;
    } else {
      searchDexTable = viewDexTable
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
      searchController.clear();
    });

    if (filters.contains(type)) {
      filters.remove(type);
    } else {
      filters.add(type);
    }

    List<pokeMon> filterDexTable = [];

    if (filters.isNotEmpty) {
      fullDexTable.forEach(
        (item) {
          if (filters.length == 1) {
            if ((item.type1 == filters[0] || item.type2 == filters[0])) {
              filterDexTable.add(item);
            }
          } else {
            if ((item.type1 == filters[0] && item.type2 == filters[1]) ||
                (item.type1 == filters[1] && item.type2 == filters[0])) {
              filterDexTable.add(item);
            }
          }
        },
      );
    }

    setState(() {
      isLoading = false;
      viewDexTable = filterDexTable;
      if (filters.isEmpty) {
        viewDexTable = fullDexTable;
      }
    });
  }

  void clearSearch() {
    setState(() {
      isLoading = true; // your loader has started to load
      searchController.clear();
      filters.clear();
      isPressed = List.filled(isPressed.length, false);
      viewDexTable = fullDexTable;
    });

    setState(() {
      isLoading = false; // your loader has started to load
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
          title: const Text(
            'PokeDex',
          ),
          centerTitle: true,
          elevation: 2,
        ),
      ),
      //bottomNavigationBar: navBar(),
      endDrawer: Drawer(
        backgroundColor: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: (1 / .4),
                  ), // 3 buttons in a row
                  itemCount: typeTable.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          filterFunction(typeTable[index]);
                          setState(() {
                            isPressed[index] = !isPressed[index];
                          });
                        },
                        child: Stack(
                          children: [
                            Image.asset(
                              'pokeSprites/types/' + typeTable[index] + '.png',
                            ),
                            if (isPressed[index])
                              Container(
                                color: Colors.grey.withOpacity(0.4),
                                width: 50,
                                height: 20,
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                /*child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(3),
                itemCount: typeTable.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: CheckboxListTile(
                        value: typeCheck, //Fix checkbox not checking right
                        onChanged: (bool? value) {
                          filterFunction(typeTable[index]);
                          setState(() {
                            typeCheck = !typeCheck;
                          });
                        },
                        secondary: Image.asset(
                            'pokeSprites/types/' + typeTable[index] + '.png'),
                      ),
                    ),
                  );
                },
              ),*/
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
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
                          clearSearch();
                        },
                        icon: const Icon(Icons.clear),
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
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.78,
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(3),
                          itemCount: viewDexTable.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Ink(
                              color: Colors.white,
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
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
                                    Image.asset(
                                      'pokeSprites/teamSprite/' +
                                          viewDexTable[index].teamSprite,
                                      height: 50,
                                      width: 50,
                                      cacheHeight: 50,
                                      cacheWidth: 50,
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Text(viewDexTable[index].dexName),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
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
