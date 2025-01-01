import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CalendarScrollableSection extends StatefulWidget {
  const CalendarScrollableSection({super.key});

  @override
  State<CalendarScrollableSection> createState() => _CalendarScrollableState();
}

class _CalendarScrollableState extends State<CalendarScrollableSection> {
  final List<DateTime> _items = List.generate(20, (index) => DateTime.now().add(Duration(days: index)));
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_isLoading) {
        _loadMoreItems();
      }
    });
  }

  void _loadMoreItems() async {
    setState(() => _isLoading = true);

    //await Future.delayed(const Duration(seconds: 2));
    final newItems = List.generate(20, (index) => _items.last.add(Duration(days: index + 1)));

    setState(() {
      _items.addAll(newItems);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);
    return SizedBox(
      height: 75,

      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _items.length +1,
        itemBuilder: (context, index) {
          if (index == _items.length) {
            return _isLoading
                ? const SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
                : const SizedBox.shrink();
          }
          return GestureDetector(
            onTap: () {
                goRouter.go("/home/${_items[index]}");
              },
            child: DateContainer(current: _items[index] ),
          );

        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class DateContainer extends StatelessWidget{
  const DateContainer({super.key, required this.current});
  final DateTime current;

  @override
  Widget build(BuildContext context) {

    return
      Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.only(right: 10),
      child: Center(

        child: Column(
          children: [
            Text(
              DateFormat('EEEE').format(current)[0],
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              '${current.day}',
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),

          ],
        )

      ),
    );
  }
}
