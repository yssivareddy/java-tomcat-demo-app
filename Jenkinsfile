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
         sh 'docker build -t rajnikhattarrsinha/javademoapp_$JOB_NAME:$BUILD_NUMBER .'
      }  
   
      stage('Publish Docker Image'){
         withCredentials([string(credentialsId: 'dockerpwd', variable: 'dockerPWD')]) {
              sh "docker login -u rajnikhattarrsinha -p ${dockerPWD}"
         }
        sh 'docker push rajnikhattarrsinha/javademoapp_$JOB_NAME:$BUILD_NUMBER'
      }
      
      stage('Run Docker Image'){
             def dockerContainerName = 'javademoapp_$JOB_NAME:$BUILD_NUMBER'
            def dockerRun= "sudo docker run -p 8081:8080 -d --name ${dockerContainerName} rajnikhattarrsinha/javademoapp_$JOB_NAME:$BUILD_NUMBER" 
            withCredentials([string(credentialsId: 'deploymentserverpwd', variable: 'dpPWD')]) {
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no devops@54.173.16.4 ${dockerRun}"
            }
      
      }
      
      
     /* stage('Deploy'){
         def k8Apply= "kubectl apply -f deployment.yaml" 
         withCredentials([string(credentialsId: 'k8pwdrajni', variable: 'k8PWD')]) {
             sh "sshpass -p ${k8PWD} ssh -o StrictHostKeyChecking=no devops@54.196.52.131"  
             sh "sshpass -p ${k8PWD} scp -r deployment.yaml devops@54.196.52.131:/home/devops" 
             sh "sshpass -p ${k8PWD} ssh -o StrictHostKeyChecking=no devops@54.196.52.131 ${k8Apply}"
         }
       }
      */
  }
      
