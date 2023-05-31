# hooklint

Format and analyze code using pre-commit.

> Windows platform is debugging.

## Usage

First you need to activate the `hooklint`:

```shell
dart pub global activate hooklint
```

Then you just need to execute it in the project that needs to add pre-commit:

```
hooklint
```

> Maybe you don't want to use `global activate` , you can:
>
> ```shell
> dart pub add --dev hooklint
> dart run hooklint
> ```

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

