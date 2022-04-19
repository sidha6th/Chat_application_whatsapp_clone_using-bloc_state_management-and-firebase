import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/view/contacts/contacts_page.dart';

TextEditingController controller = TextEditingController();
final counterRef = FirebaseDatabase.instance.ref('counter');
ValueNotifier<int> currentIndex = ValueNotifier(1);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1,
    );
    _tabController.addListener(
      _handleTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(
      _handleTabIndex,
    );
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    currentIndex.value = _tabController.index;
    // currentIndex.notifyListeners();
  }

  final List<IconData> floatingIcon = [
    Icons.message,
    Icons.message,
    Icons.camera_alt,
    Icons.add_call,
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: homeColor,
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => <Widget>[
              SliverAppBarWidget(
                controller: _tabController,
              ),
            ]),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            const Center(
              child: Text(
                'data',
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height,
              child: const MainChatScreen(),
            ),
            SizedBox(
              width: size.width,
              height: size.height,
              child: const StatusPage(),
            ),
            SizedBox(
              width: size.width,
              height: size.height,
              child: const MainCallsScreen(),
            ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (context, int current, _) {
          return currentIndex.value > 0
              ? FloatingActionButton(
                  backgroundColor: darkGreen,
                  child: Icon(
                    floatingIcon[current],
                  ),
                  onPressed: (() async {
                    getcontacts() async =>
                        BlocProvider.of<HomeBloc>(context).add(
                          GetContacts(),
                        );
                    await getcontacts().then(
                      (value) => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return const ContactScreen();
                          }),
                        ),
                      ),
                    );
                  }),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
