#!/bin/bash

pipeline {
    agent any
    tools {
        maven "maven3"
        jdk "OracleJDK8"
    }

    environment {
        SNAP_REPO = "vprofile-snapshot"
        CENTRAL_REPO = "vprofile-maven-central"
        RELEASE_REPO = "vprofile-release"
        NEXUS_GRP_REPO = "vprofile-grouped"
        NEXUS_IP = "172.31.23.49"
        NEXUS_PORT = "8081"
    }

    stages {
        stage ("Build Artifact") {
            steps {
                script {
                    sh 'mvn -s settings.xml -DskipTests install'
                }
            }
        }
    }
}