import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'your_delegate_viewmodel.dart';

class YourDelegateView extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=> YourDelegateViewModel(), builder: (context, viewmodel, child){
			return Scaffold(

			);
		});
	}
}
