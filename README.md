# Scan your code with SonarQube

Using this GitHub Action, scan your code with SonarQube to detects bugs, vulnerabilities and code smells.

## Requirements

* Have an SonarQube server.

## Usage

Project metadata, including the location to the sources to be analyzed, must be declared in the file `sonar-project.properties` in the base directory:

```properties
sonar.projectKey=myawesomeproject

sonar.sources=.
```

The workflow, usually declared in `.github/workflows/build.yml`, looks like:

```yaml
on: push
name: Main Workflow
jobs:
  sonarQubeTrigger:
    name: SonarQube Trigger
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: SonarQube Scan
      uses: advancedcsg-open/action-ccq@master
      env:
        SONARQUBE_URL: 'https://mysonar.url'
        SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

### Secrets

- `SONAR_TOKEN` – **Required** this is the token used to authenticate access to SonarCloud. You can set the `SONAR_TOKEN` environment variable in the "Secrets" settings page of your repository.

## Do not use this GitHub action if you are in the following situations

* Your code is built with Maven: run 'org.sonarsource.scanner.maven:sonar' during the build
* Your code is built with Gradle: use the SonarQube plugin for Gradle during the build
* You want to analyze a .NET solution
