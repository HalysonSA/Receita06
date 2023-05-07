import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("MyApp");

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

final ValueNotifier<List> props = new ValueNotifier([]);

List<VoidCallback> dataValues = [
  carregarCafes,
  carregarCervejas,
  carregarPaises
];

void carregarCervejas() {
  props.value = [
    {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
    {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
    {"name": "Duvel", "style": "Pilsner", "ibu": "82"}
  ];
}

void carregarPaises() {
  props.value = [
    {"name": "Nação 1", "capital": "Capital 1", "population": "10M"},
    {"name": "Nação 2", "capital": "Capital 2", "population": "5M"},
    {"name": "Nação 3", "capital": "Capital 3", "population": "2M"},
    {"name": "Nação 4", "capital": "Capital 4", "population": "1M"},
    {"name": "Nação 5", "capital": "Capital 5", "population": "500k"}
  ];
}

void carregarCafes() {
  props.value = [
    {"name": "Café 1", "type": "Expresso", "price": "5"},
    {"name": "Café 2", "type": "Cappuccino", "price": "8"},
    {"name": "Café 3", "type": "Latte", "price": "7"}
  ];
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    print("MyHomePage");

    dataValues[0]();

    return Scaffold(
      appBar: AppBar(
        title: Text("teste"),
      ),
      body: ValueListenableBuilder(
          valueListenable: props,
          builder: (_, value, __) {
            return GenericItem(objects: [...value]);
          }),
      bottomNavigationBar: NavbarCustom(),
    );
  }
}

class NavbarCustom extends HookWidget {
  NavbarCustom();

  @override
  Widget build(BuildContext context) {
    final buttontapped = useState(0);
    print("NavbarCustom");

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.coffee_outlined),
        ),
        BottomNavigationBarItem(
            label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
        BottomNavigationBarItem(
            label: "Nações", icon: Icon(Icons.flag_outlined))
      ],
      onTap: (index) {
        buttontapped.value = index;
        dataValues[index]();
      },
      currentIndex: buttontapped.value,
    );
  }
}

class GenericItem extends StatelessWidget {
  List<Map<String, dynamic>> objects;

  GenericItem({this.objects = const []});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(30),
      itemCount: objects.length,
      itemBuilder: (context, index) {
        final titles = objects[index].keys.toList();
        final values = objects[index].values.toList();

        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: titles
                .map((e) => Text(
                      "$e: ${values[titles.indexOf(e)]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ))
                .toList(),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

// Usar apenas na receita 5
class NewNavbar extends StatefulWidget {
  const NewNavbar({super.key});
  @override
  _NewNavbarState createState() => _NewNavbarState();
}

class _NewNavbarState extends State<NewNavbar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.coffee_outlined),
        ),
        BottomNavigationBarItem(
            label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
        BottomNavigationBarItem(
            label: "Nações", icon: Icon(Icons.flag_outlined))
      ],
      onTap: (value) => setState(() {
        _selectedIndex = value;
      }),
      currentIndex: _selectedIndex,
    );
  }
}
