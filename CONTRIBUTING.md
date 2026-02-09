# Contributing

**Thank you for considering contributing to this project!** If you’d like to help but can’t open a pull request, starring the repository is still a great way to support the project and help it reach more people. To improve the chances of your pull request being merged, please follow the guidelines in this document.

## Devcontainers

I case you're not able to install the dependencies there is the option to run the project from a [devcontainer](https://containers.dev/). This is a workspace created using [docker](http://docker.com/). This environment has all the required tools and dependencies for you to work in. See the documentation for your IDE on how to work with [devcontainers](https://containers.dev/).

## Commit Message Conventions

All commit messages must follow the [conventional commit specification](https://www.conventionalcommits.org/en/v1.0.0/#specification). This is to autogenerate the changelog and keep commits constant. There are pre-commit checks to help you not push wrongly formed commits by mistake. Here is a list of allowed types:

- **feat**: For new features.
- **fix**: For bug fixes.
- **test**: For changes to tests.
- **docs**: For changes to the documentation.
- **ci**: For changes to the CI workflows.
- **refactor**: A code change that neither fixes a bug nor adds a feature.
- **perf**: A code change that improves performance.
- **style**: Changes that do not affect the meaning of the code (formatting).
- **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm).
- **chore**: Other changes that don't modify source or test files.
- **revert**: Reverts a previous commit.

If your commit is a breaking change, please mark it as follows: `<type>!: <commit message>`. We strive to keep backwards compatibility as much as possible.

### Line Length

Please keep your title 66 characters or less, and your body lines 80 characters or less.

### Example commit

This is a valid conventional commit:

```Commit
fix: all bugs in the repository

This commit fixes all bugs in the repository.
```

## Branch Naming Conventions

Much like conventional commits we use conventional branch naming. This means that depending on what you're working on you should name your branch differently. For example:

- Name it `docs/*`, when working on documentation.
- Name it `feat/*`, when working on a feature.
- Name it `fix/*`, when working on a bug fix.
- ...

Where `*` describes your branch. So for example: `dependencies/update-xyz-from-v1.2.3-to-v4.5.6`. Make sure to use [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case). These branch names will make it clear what your working on, and allows the CI/CD to label your PR better.

## License

By contributing, you agree that your contributions will be licensed under the same licence as the rest of the repository. See [the LICENCE file](./LICENSE) for more information.
