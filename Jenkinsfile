pipeline {
    agent none
    stages {
        stage('Example Build') {
            agent {
               label 'slave_1'	
               }
            steps {
                echo 'Hello, Maven'                
            }
        }      
    }
}
