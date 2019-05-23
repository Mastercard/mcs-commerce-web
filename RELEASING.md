Releasing
=========

### Pre-release
1. Branch `develop` into `release/X.Y.Z` if non-release code is still being merged to `develop`
1. Update `info.plist` and `MCSCommerceWeb.podspec` to include `beta` version
1. Iterate this release over this branch
1. Update the version to a non-beta in `info.plist`
1. Update the version and tag number to a non-beta in `MCSCommerceWeb.podspec`
1. Update the `CHANGELOG.md` for the impending release.
1. Update the `README.md` with the new version and any new documentation.
1. `git commit -am "Prepare for release X.Y.Z."` (where X.Y.Z is the new version)

### Release
1. `pod lib lint`
1. Merge `release/X.Y.Z -> develop -> master`
1. Checkout `master`
1. Delete branch `release/X.Y.Z`
1. `git tag -a X.Y.Z -m "Version X.Y.Z"` (where X.Y.Z is the new version)
1. `git push --tags`
1. `pod trunk push MCSCommerceWeb.podspec`

### Post-release
1. Update the `info.plist` and `MCSCommerce.podspec` to the next alpha version.
1. `git commit -am "Prepare next development version."`
1. `git push`


### Versioning
**Semver** is used for versioning. After a new release is tagged with X.Y.Z, the version is updated to `X.Y.Z-alpha1` for the next release.

`alpha` is used when on develop branch;
`beta` is used when working in a release branch.


TODO:
Test the running of this in an actual CocoaPods installation