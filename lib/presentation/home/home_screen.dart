import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvmsearchimage/presentation/home/home_view_model.dart';
import 'package:mvvmsearchimage/presentation/home/components/photo_widget.dart';
import 'package:mvvmsearchimage/presentation/home/home_ui_event.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //text가 변경되면 _controller를 통해 해당 값에 접근할수있다.
  final _controller = TextEditingController();

  StreamSubscription? _subscription;

  //Stream을 사용할때 UI를 그리는 용도라면 StreamBuilder를 사용하는게 좋지만,
  //스낵바의경우 지속적으로 UI를 그리는것이아니라 특정타이밍에 이벤트를 캐치만하면되기떄문에,
  //initState에서 stream.listen으로 이벤트를 리슨해준다.
  @override
  void initState() {
    super.initState();

    //근데 initState에서 context.read를 할경우 온전하게 context를 read.해오지못한다.
    //그래서 꼼수가 필요하다. viewmodel를 가지고 오지를 못하낟. context참조가안된다.
    //그래서 initState 내부에서는 Future.microtask 메소드를 사용하여 극히 짧은 약간의 딜레이를 주면 올바른 context참조가 가능해진다.
    //근데 최신 flutter 에서 microtask안써도 정상작동 되는것같다
    final viewModel = context.read<HomeViewModel>();
    _subscription = viewModel.eventStream.listen((event) {
      if (event is ShowSnackBar) {
        final snackBar = SnackBar(content: Text(event.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    // Future.microtask(() {
    //   //initState에서는 context.watch를 사용하지 못한다.
    //   final viewModel = context.read<HomeViewModel>();
    //   _subscription = viewModel.eventStream.listen((event) {
    //     if (event is ShowSnackBar) {
    //       final snackBar = SnackBar(content: Text(event.message));
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     }
    //   });
    // });
  }

//다 쓰고 나서 controller 해제를 해줘야함
  @override
  void dispose() {
    //initState될때마다 계속에서 스트림listen을 등록해주면 안되니까
    //dispose될때는 cancel 해줘야한다.
    _subscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<HomeViewModel>(context);
    //Provider.of 보다 더 .watch가 더 최신식이다.
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '이미지 검색 앱',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        await viewModel.fetch(_controller.text);
                      },
                      icon: const Icon(Icons.search))),
            ),
          ),
          viewModel.state.isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: viewModel.state.photos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: ((context, index) {
                      final photo = viewModel.state.photos[index];
                      return PhotoWidget(photo: photo);
                    }),
                  ),
                )
        ],
      ),
    );
  }
}
