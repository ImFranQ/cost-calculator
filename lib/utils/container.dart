import 'package:cost_calculator/utils/helpers.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {

  final Widget child;
  final Widget? footer;
  final String? title;
  final List<Widget>? actions;
  final bool loading;
  
  const AppContainer({ 
    Key? key,
    required this.child,
    this.title,
    this.footer,
    this.actions,
    this.loading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).padding.top + 100,
        ),
        SafeArea(child: _content(context))
      ],
    );
  }

  Widget _content(BuildContext context){
    var appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(title ?? ''),
      actions: actions,
    );
    
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constrains){
        var screenHeigth = constrains.maxHeight;

        List<Widget> content = [
          Expanded(child:SingleChildScrollView( child: child )),
          footer ?? Container()
        ];
        
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              appBar,
              Container(
                height: screenHeigth - appBar.preferredSize.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  )
                ),
                child: Column( children: loading ? [ spacerHorizontal(), const CircularProgressIndicator() ] : content ),
              )
            ]
          ),
        );
      }
    );
  }
}