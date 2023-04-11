import 'package:flutter/material.dart';
import 'package:myapp/constant.dart';
import 'package:myapp/repository/character_repository.dart';
import 'package:myapp/widgets/character_item.dart';
import 'package:provider/provider.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<CharacterListModel>(context, listen: false).loadMoreData();
      }
    });

    if (!Provider.of<CharacterListModel>(context, listen: false)
        .isInitialized) {
      Provider.of<CharacterListModel>(context, listen: false).loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterListModel>(
      builder: (context, model, child) {
        if (model.hasError) {
          return const Center(
            child: Text('Error loading items'),
          );
        }

        if (model.items.isEmpty && model.isLoading) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  h16SizedBox,
                  Text('Loading data...')
                ],
              )),
            ),
          );
        }

        if (model.items.isEmpty && !model.isLoading) {
          return const Center(
            child: Text('No items to display'),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: model.items.length + 1,
          itemBuilder: (context, index) {
            if (index == model.items.length) {
              if (model.isLoading) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      h8SizedBox,
                      Text('Loading more data'),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }

            final item = model.items[index];
            return CharacterWidget(item: item);
          },
        );
      },
    );
  }
}
