# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [v2.0] - 2016-04-11

### Changed

- Front-end chart and map creation is no longer done with Java. This means there is no front-end dependency on Java. All plotting is done with Javascript, so there is no longer an Applet, which leads to the following improvements:

  1. The page loads *much* faster
  2. The VWT is functional on tablets and smart phones
  3. No need to jump through hoops with confirmation boxes to allow the applet to runStatus
  4. No need to sign the dependency jar files - so no need to create/renew the code-signing certificate
  5. No more browser crashes
  6. Much better, more interactive charts and maps
  7. Plots/maps and underlying data can be edited/saved using Plotly (free to make an account online)

### Missing features

The ability to plot verification scores for separate/specific forecast categories has been disabled until v2.1.
