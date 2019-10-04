#!/bin/bash

set -e

if [[ -z "${SONAR_TOKEN}" ]]; then
  echo "Set the SONAR_TOKEN env variable."
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

if [[ -z "${SONARQUBE_URL}" ]]; then
  SONARQUBE_URL="https://ccq.svc.oneadvanced.com"
fi

sonar-scanner -Dsonar.host.url=${SONARQUBE_URL}