/// Execute from project package
const localTemplate = '''
#!/bin/bash

dart run hooklint
''';

/// Execute from global command
///
/// dart pub global activate hooklint
const globalTemplate = '''
#!/bin/bash

hooklint run
''';
