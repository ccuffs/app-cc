import 'package:cc_uffs/app/pages/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:navigate/navigate.dart';

Handler loginHandler = Handler(
  transactionType: TransactionType.fromRight,
  pageBuilder: (BuildContext context, dynamic arg){
    return LoginView();
  }
);

// define your route here
Map<String,Handler> route = <String, Handler>{
  'login' : loginHandler,
};