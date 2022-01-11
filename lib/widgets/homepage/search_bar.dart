import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/museums.dart';

class SearchBar extends StatefulWidget {
  //final String text;
  final ValueChanged<String> onChanged;

  const SearchBar(this.onChanged);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _folded = true;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 16, 0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: _folded ? 56 : 170,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Theme.of(context).primaryColorLight,
          boxShadow: kElevationToShadow[6],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 16),
                  child: !_folded
                      ? TextField(
                          controller: controller,
                          decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark),
                              border: InputBorder.none),
                              onChanged: widget.onChanged,
                        )
                      : null),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_folded ? 32 : 0),
                    topRight: Radius.circular(32),
                    bottomLeft: Radius.circular(_folded ? 32 : 0),
                    bottomRight: Radius.circular(32),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(_folded ? Icons.search : Icons.close,
                        color: Theme.of(context).primaryColorDark),
                  ),
                  onTap: () {
                    setState(() {
                      _folded = !_folded;
                      widget.onChanged('');
                      controller.text = '';
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
