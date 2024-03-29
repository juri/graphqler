# Changelog

All notable changes to this project will be documented in this file.

## [0.3.2](https://www.github.com/juri/graphqler/compare/0.3.1...0.3.2) (2023-03-19)

### Other Changes

- Test compilation with Swift 5.7. Fix warnings.
- Switch from Jazzy to DocC.

## [0.3.1](https://www.github.com/juri/graphqler/compare/0.3.0...0.3.1) (2021-03-07)

### Bug Fixes

- Make the `append` methods on `Arguments` public 🤦‍♂️


## [0.3.0](https://www.github.com/juri/graphqler/compare/0.2...0.3.0) (2021-03-07)

### Bug Fixes

- Fix version format to be semver compliant with three digits.
- Upgrade Jazzy to a version that doesn't have a security vulnerability. Add configuration to ensure it does the right thing.

### Features

- Add `EnumValue` for representing values of an Enum type.
- Replace most `let`s inside the structs with `var`s.
- Add mutating `append` methods to `Arguments`.

### Other changes

- Remove the unnecessary and broken workspace from the repository.
- Change spec links to link to graphql.org.
