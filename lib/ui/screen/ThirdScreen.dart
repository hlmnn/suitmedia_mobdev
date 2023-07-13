import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_mobdev/data/data_state.dart';
import 'package:suitmedia_mobdev/data/model/user_model.dart';
import 'package:suitmedia_mobdev/ui/cubit/list_user_cubit.dart';
import 'package:suitmedia_mobdev/ui/screen/SecondScreen.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key, required this.title, required this.name});

  final String title;
  final String name;

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  int id = 0;
  String email = "";
  String firstName = "";
  String lastName = "";
  String avatar = "";

  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future refresh() async {
    setState(() {
      id = 0;
      email = "";
      firstName = "";
      lastName = "";
      avatar = "";
    });
    BlocProvider.of<ListUserCubit>(context)
        .getAllUser(true, id, email, firstName, lastName, avatar);
  }

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<ListUserCubit>(context)
              .getAllUser(false, id, email, firstName, lastName, avatar);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    BlocProvider.of<ListUserCubit>(context)
        .getAllUser(false, id, email, firstName, lastName, avatar);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color:Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<ListUserCubit, DataState>(
        builder: (context, state) {
          if (state is LoadingPaginationState && state.isFirstFetch) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          List<UserModel> items = [];
          bool isLoading = false;

          if (state is LoadingPaginationState) {
            items = state.oldData;
            isLoading = true;
          } else if (state is SuccessState) {
            items = state.data;
          }

          if (items.isEmpty) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 5, left: 20, right: 20),
                      child: Column(
                        children: [
                          const Text("List user is empty!",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15
                            ),
                          ),
                          Image.asset(
                            'assets/images/empty.png',
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              controller: scrollController,
              itemCount: items.length + (isLoading ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index < items.length) {
                  final item = items[index];
                  return InkWell(
                    onTap: () {
                      String selectedUserName = '${item.firstName} ${item.lastName}';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Screen2(title: 'Second Screen', name: widget.name, selectedName: selectedUserName,),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.network(
                                item.avatar,
                                width: 70,
                              ),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 13, bottom: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${item.firstName} ${item.lastName}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                                Text(item.email,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          );
        }
      )
    );
  }
}