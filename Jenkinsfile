node{
      
      stage('Checkout'){
         git 'https://github.com/LovesCloud/java-tomcat-demo-app/'
      }
      stage('Build'){
         // Get maven home path and build
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'   
         sh "${mvnHome}/bin/mvn package -Dmaven.test.skip=true"
      }       
     
     stage ('Test'){
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'    
         sh "${mvnHome}/bin/mvn verify; sleep 3"
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
            def dockerContainerName = 'javademoapp_$JOB_NAME_$BUILD_NUMBER'
             def changingPermission='sudo chmod -x stopscript.sh'
            def scriptRunner='sudo ./stopscript.sh'           
            def dockerRun= "sudo docker run -p 8082:8080 -d --name ${dockerContainerName} rajnikhattarrsinha/javademoapp_$JOB_NAME:$BUILD_NUMBER" 
            withCredentials([string(credentialsId: 'deploymentserverpwd', variable: 'dpPWD')]) {
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no devops@107.23.253.3" 
                  sh "sshpass -p ${dpPWD} scp -r stopscript.sh devops@107.23.253.3:/home/devops" 
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no devops@107.23.253.3 ${changingPermission}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no devops@107.23.253.3 ${scriptRunner}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no devops@107.23.253.3 ${dockerRun}"
            }
      
      }
          
  }
      
