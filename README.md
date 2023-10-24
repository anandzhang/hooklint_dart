# hooklint

Format and analyze code using pre-commit.

> Windows platform is debugging.

## Installation

Add `hooklint` as a [dev_dependencies in your pubspec.yaml file](https://dart.dev/tools/pub/pubspec#dependencies).

```yaml
dev_dependencies:
  hooklint: ^0.1.3
```

Then execute the following command from your project directory:

```shell
dart run hooklint install
```

>Alternatively, you can use `global activate` as a global command.
>
>```shell
>dart pub global activate hooklint
>```
>
>Then install pre-commit hook.
>
>```shell
>hooklint install
>```

## Usage

![usage](https://raw.githubusercontent.com/anandzhang/hooklint_dart/main/screenshots/usage.gif)

## Configuration

If you need automatic `dart fix`, you can define it in pub.yaml.

```yaml
hooklint:
  autofix: true
```

## Troubleshooting

<details>
  <summary>Warning: Pub installs executables into $HOME/.pub-cache/bin, which is not on your path.</summary>

    You can fix that by adding this to your shell's config file (.bashrc, .bash_profile, etc.):
    
    ```shell
    export PATH="$PATH":"$HOME/.pub-cache/bin"
    ```
    
    Then re-run activate `hooklint`:
    
    ```shell
    dart pub global activate hooklint
    ```

</details>

