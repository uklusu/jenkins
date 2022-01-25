pipeline {
    agent none
    stages {
        stage('Example Build') {
            agent {slave_1} 
            steps {
                echo 'Hello, Maven'                
            }
        }
        stage('Example Test') {
            agent {slave_1} 
            steps {
                echo 'Hello, JDK'                
            }
        }
    }
}
