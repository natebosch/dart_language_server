import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:stream_channel/stream_channel.dart';

import 'wirelog.dart';

final _lspWireLog = new WireLog();
final analyzerSink = new StreamController<String>.broadcast();
StreamChannelTransformer<String, String> lspChannel = _lspWireLog.transformer;

final _logs = <IOSink>[];

void startLogging(String clientName, String traceLevel) {
  if (traceLevel == 'verbose') {
    var logSink = new File(path.join(
            Directory.systemTemp.path, 'dart-lang-server-$clientName.log'))
        .openWrite();
    _logs.add(logSink);
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      logSink
          .writeln('${record.level.name}: ${record.time}: ${record.message}');
      if (record.error != null) {
        logSink.writeln('[Exception]: ${record.error}');
      }
      logSink.flush();
    });
  }
  if (traceLevel == 'verbose' || traceLevel == 'messages') {
    var analyzerLog = new File(path.join(
            Directory.systemTemp.path, 'analyzer-wirelog-$clientName.log'))
        .openWrite();
    analyzerSink.stream.transform(UTF8.encoder).pipe(analyzerLog);
    _logs.add(analyzerLog);
    var lspLog = new File(
            path.join(Directory.systemTemp.path, 'lsp-wirelog-$clientName.log'))
        .openWrite();
    _lspWireLog.attach(lspLog);
    _logs.add(lspLog);
  }
}

Future<Null> closeLogs() => Future.wait(_logs.map(_close));

Future _close(IOSink sink) async {
  await sink?.flush();
  await sink?.close();
}
