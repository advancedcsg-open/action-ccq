#!/bin/bash

set -e

if [[ -z "${SONAR_TOKEN}" ]]; then
  echo "Set the SONAR_TOKEN env variable."
  exit 1
fi

if [[ -z "${SONARQUBE_URL}" ]]; then
  echo "Set the SONARQUBE_URL env variable."
  exit 1
fi

if [[ -f "pom.xml" ]]; then
  echo "Maven project detected. You should run the goal 'org.sonarsource.scanner.maven:sonar' during build rather than using this GitHub Action."
  exit 1
fi

if [[ -f "build.gradle" ]]; then
  echo "Gradle project detected. You should use the SonarQube plugin for Gradle during build rather than using this GitHub Action."
  exit 1
fi

if [[ "${GITHUB_EVENT_NAME}" == "pull_request" ]]; then
  EVENT_ACTION=$(jq -r ".action" "${GITHUB_EVENT_PATH}")
  if [[ "${EVENT_ACTION}" != "opened" ]]; then
	  echo "No need to run analysis. It is already triggered by the push event."
	  exit 78
  fi
fi

if [[ -z "${VERSION}" ]]; then
  sonar-scanner -Dsonar.host.url=${SONARQUBE_URL} -Dsonar.login=${SONAR_TOKEN} -Dsonar.projectVersion=${VERSION} $*
else
  sonar-scanner -Dsonar.host.url=${SONARQUBE_URL} -Dsonar.login=${SONAR_TOKEN} $*
fi
