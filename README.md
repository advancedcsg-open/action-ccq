# Scan your code with SonarQube

Using this GitHub Action, scan your code with SonarQube to detects bugs, vulnerabilities and code smells.

## Requirements

* Have an SonarQube server.

## Usage

Project metadata, including the location to the sources to be analyzed, must be declared in the file `sonar-project.properties` in the base directory:

```properties
sonar.projectKey=bu:division:project:repo

sonar.sources=.
```

The workflow, usually declared in `.github/workflows/build.yml`, looks like:

```yaml
on: push
name: Main Workflow
jobs:
  sonarCloudTrigger:
    name: SonarCloud Trigger
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: SonarCloud Scan
      uses: sonarsource/sonarcloud-github-action@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

### Secrets

- `SONAR_TOKEN` – **Required** this is the token used to authenticate access to SonarCloud. You can generate a token on your [Security page in SonarCloud](https://sonarcloud.io/account/security/). You can set the `SONAR_TOKEN` environment variable in the "Secrets" settings page of your repository.

## Do not use this GitHub action if you are in the following situations

* Your code is built with Maven: run 'org.sonarsource.scanner.maven:sonar' during the build
* Your code is built with Gradle: use the SonarQube plugin for Gradle during the build
* You want to analyze a .NET solution: use the [SonarCloud Azure DevOps Extension](https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarcloud) to analyze your code on SonarCloud with Azure Pipelines
* You want to analyze C/C++ code: rely on our [Travis-CI extension](https://docs.travis-ci.com/user/sonarcloud/) and look at [our sample C/C++ project](https://github.com/SonarSource/sq-com_example_c-sqscanner-travis)
