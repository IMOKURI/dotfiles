#!groovy

def proxy = "http://proxy.houston.hpecorp.net:8080"

def secrets = ''

pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr:'10'))
        timestamps()
        ansiColor('xterm')
    }
    agent {
        label 'docker-v18.03'
    }
    stages {
        stage('SetWorkspace') {
            steps {
                script {
                    workspace = pwd()
                }
            }
        }
        stage('Vault') {
            steps {
                script {
                    secrets = vaultGetSecrets()
                }
            }
        }
        stage('Shell') {
            steps {
                sh """
                """
            }
        }
        stage('Parallel') {
            steps {
                parallel (
                    'CaseA': {
                        sh """
                        """
                        script {
                            hello = sh (
                                script: "echo 'hello'",
                                returnStdout: true
                            ).trim()
                        }
                    },
                    'CaseB': {
                        sh """
                        """
                    }
                )
            }
        }
        stage('Mask') {
            when {
                branch "master"
            }
            steps {
                script {
                    def passwordMask = [
                        $class: 'MaskPasswordsBuildWrapper',
                        varPasswordPairs: [
                            [password: secrets.TOKEN]
                        ]
                    ]
                    wrap(passwordMask) {
                        sh """
                            echo ${secrets.TOKEN}
                        """
                    }
                }
            }
        }
        stage('Function') {
            steps {
                script {
                    funcName(argA, argB)
                }
            }
        }
    }
}

final funcName(argA, argB) {
    sh """
    """
}
