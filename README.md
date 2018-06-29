[![Pub Package](https://img.shields.io/pub/v/dart_language_server.svg)](https://pub.dartlang.org/packages/dart_language_server)
[![Build Status](https://travis-ci.org/natebosch/dart_language_server.svg?branch=master)](https://travis-ci.org/natebosch/dart_language_server)
[![Build status](https://ci.appveyor.com/api/projects/status/ydol1ue3oql4g6hw/branch/master?svg=true)](https://ci.appveyor.com/project/natebosch/dart-language-server/branch/master)


# Dart Language Server

Wraps the [dart analysis server] and adapts its [default protocol] to the
[language server protocol].

[dart analysis server]: https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server
[default protocol]: https://goo.gl/02kGvm
[language server protocol]: https://github.com/Microsoft/language-server-protocol

## Features

This server supports:

- Diagnostic notifications
- Completion suggestions
- Jump to definition
- List references
- List implementations
- Hover information
- Document reference highlights
- Document outlines
- Workspace symbol search
- Quick Fixes / Code Actions
- Symbol Rename

## Installing

`pub global activate dart_language_server`

If you have the pub bin directory in your path (you should be warned during the
previous command if not) the server can be run as `dart_language_server`.

Integration with an editor depends on the details of the editor. All
communication with this server is through stdin/stdout.

>*Make sure you haved installed Dart SKD 1.x. Dart 2.x isn't supported yet!*
