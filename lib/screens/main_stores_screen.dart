import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_2/components/custom_loading.dart';
import 'package:test_2/components/try_again.dart';
import 'package:test_2/logic/bloc/stores_bloc/stores_bloc.dart';
import 'package:test_2/logic/model/category.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stores_test'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
            ),
          )
        ],
      ),
      body: BlocConsumer<StoresBloc, StoresState>(
        listener: (context, state) {
          if (state is StoresError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.mes.massage.toString())));
          }
        },
        builder: (context, state) {
          if (state is StoresLoaded) {
            final category = state.model.hydraMember;
            return SingleChildScrollView(child: getCategory(category));
          } else if (state is StoresInitial) {
            return const CustomLoading();
          } else if (state is StoresError) {
            return TryAgain(
              message: state.mes.massage,
            );
          }
          return const CustomLoading();
        },
      ),
    );
  }

///////////////////////////////
  Widget getCategory(List<HydraMember> categories) {
    return DelayedDisplay(
      delay: const Duration(milliseconds: 500),
      child: Column(
        children: categories
            .map<Widget>(
              (e) => Column(
                children: [
                  ExpansionTile(
                    title: Text(e.name),
                    subtitle: const Text('Выберите категорию'),
                    children: <Widget>[
                      ...e.categories.map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ExpansionTile(
                            title: Text(e.name),
                            subtitle: Text('Каталог товров "${e.name}"'),
                            children: <Widget>[
                              getCategoryElement(const SizedBox(),
                                  e.categories.reversed.toList()),
                              const SizedBox(height: 32)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ].toList(),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget getCategoryElement(Widget child, List<CategoryElement> elements) {
    if (elements.isEmpty) return child;
    return Row(
      children: [
        const SizedBox(width: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: elements
              .map(
                (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 44,
                          width: 316,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 8),
                            child: Text(
                              e.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16,
                        )
                      ],
                    ),
                    Container(
                      width: 316,
                      height: 0.500,
                      color: Colors.grey,
                    ),
                    getCategoryElement(const SizedBox(height: 16),
                        e.categories.reversed.toList()),
                  ],
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
