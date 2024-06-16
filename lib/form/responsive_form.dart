import 'package:flutter/material.dart';

class ResponsiveForm{
  static const mobileSize = 400;
  static Widget responsiveForm({
            required List<Widget> children,
            double vericalSpace = 8,
            double horizontalSpace = 8,
      }){

        return LayoutBuilder(
            builder: (context, constraint){
              var count = (constraint.maxWidth ~/ (mobileSize * .8)) == 0 ? 1 : (constraint.maxWidth ~/ (mobileSize * .8));
              var mod = children.length % count;
              List<Widget> list = List.generate(
                (children.length ~/ count),
                (index) => Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 0 : vericalSpace),
                    child: Row(
                      children: List.generate(count, (index2) {
                        int i = index2 + (index * count);
                        return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index2 == count - 1 ? 0 : horizontalSpace),
                              child: children[i],
                            )
                        );
                      }),
                    )
                ));
              if(mod > 0){
                list.add(Padding(
                    padding: EdgeInsets.only(top: vericalSpace),
                    child: Row(
                      children: List.generate((count), (index){
                        if(mod == 0){
                          return const Spacer();
                        }
                        var widget = children[children.length - mod];
                        mod--;
                        return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: horizontalSpace),
                              child: widget,
                            ));
                      }),
                    ),
                ));
              }
              return Column(
                children: list,
              );
            },
        );
      }
}

