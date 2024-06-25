import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_submission/providers/user_provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if(currentScroll == maxScroll && context.read<UserProvider>().hasMore) {
      context.read<UserProvider>().getUserList();
    }
  }

  Future _onRefresh() async{
    context.read<UserProvider>().refresh();
  }

  @override
  void initState() {
    context.read<UserProvider>().getUserList();
    super.initState();
    _scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: 
      (context, value, child) => Scaffold( 
        appBar: AppBar( 
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff554af0)),
            onPressed: () => Navigator.of(context).pop(),
          ), 
          centerTitle: true,
          title: const Text(
            "Third Screen",
            style: TextStyle( 
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
                color: Colors.grey.withOpacity(0.5),
                height: 1,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 0),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              controller: _scrollController,
              itemCount:value.hasMore ? value.users.length + 1 : value.users.length,
              itemBuilder: (context, index) {
                if(index < value.users.length) {
                  return ListTile( 
                    leading: CircleAvatar( 
                      backgroundImage: NetworkImage(value.users[index].avatar != null ? value.users[index].avatar! : 'https://w7.pngwing.com/pngs/205/731/png-transparent-default-avatar-thumbnail.png'),
                    ),
                    title: Text(value.users[index].getFullName),
                    subtitle: Text(value.users[index].email ?? ''),
                    onTap: () {
                      final setUser = context.read<UserProvider>();
                      setUser.setSelectedUser(value.users[index].getFullName);
                      Navigator.pop(context);
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.black,),
                    ),
                  );
                }
              },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.grey.withOpacity(0.5),);
              }, 
            ),
          ),
        )
      ),
    );
  }
}