node{
      
      stage('Checkout'){
         git 'https://github.com/LovesCloud/java-tomcat-demo-app/'
      }
      stage('Build'){
         // Get maven home path and build
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'   
         sh "${mvnHome}/bin/mvn package"
      }       
       
       stage('Build Docker Image'){
         sh 'docker build -t rajnikhattarrsinha/javademoapp6:2.0.0 .'
      }  
   
      stage('Publish Docker Image'){
         withCredentials([string(credentialsId: 'dockerpwd', variable: 'dockerPWD')]) {
              sh "docker login -u rajnikhattarrsinha -p ${dockerPWD}"
         }
        sh 'docker push rajnikhattarrsinha/javademoapp6:2.0.0'
      }
  }
      
