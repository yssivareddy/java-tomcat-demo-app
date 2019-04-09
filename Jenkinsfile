node{
      
      stage('Checkout'){
         git 'https://github.com/LovesCloud/java-tomcat-demo-app/'
      }
      stage('Build'){
         // Get maven home path and build
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'   
         sh "${mvnHome}/bin/mvn package -Dmaven.test.skip=true"
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
            //def stopContainer='sudo docker stop $(docker ps -a -q)'
            //def removeContainer='sudo docker rm $(docker ps -a -q)'
            def dockerContainerName = 'javademoapp_$JOB_NAME_$BUILD_NUMBER'
            def scriptRunner='sudo ./stopscript.sh'
            def dockerRun= "sudo docker run -p 8082:8080 -d --name ${dockerContainerName} rajnikhattarrsinha/javademoapp_$JOB_NAME:$BUILD_NUMBER" 
            withCredentials([string(credentialsId: 'deploymentserverpwd', variable: 'dpPWD')]) {
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no devops@18.205.113.108" 
                  sh "sshpass -p ${dpPWD} scp -r stopscript.sh devops@18.205.113.108:/home/devops" 
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ubuntu@18.205.113.108 ${scriptRunner}"
                 // sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no devops@3.84.59.37 ${stopContainer}"
                  //sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no devops@3.84.59.37 ${removeContainer}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no devops@18.205.113.108 ${dockerRun}"
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
      
