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

