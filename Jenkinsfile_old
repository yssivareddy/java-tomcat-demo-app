node{
      
      stage('Checkout'){
         git 'https://github.com/rajnikhattarrsinha/Java-Demo-Application'
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
      stage('Run docker image'){        
             def dockerContainerName = 'javademo-$BUILD_NUMBER'
             def dockerRun="sudo docker run -p 8080:8080 -d --name ${dockerContainerName} rajnikhattarrsinha/javademoapp6:2.0.0"
             sh "sshpass -p 'UbuntuUbuntu@123' ssh -o StrictHostKeyChecking=no ubuntu@104.211.166.183"  
             sh "sshpass -p 'UbuntuUbuntu@123' ssh -o StrictHostKeyChecking=no ubuntu@104.211.166.183 ${dockerRun}"
            //def dockerRun= "sudo docker run -p 8080:8080 -d --name ${dockerContainerName} rajnikhattarrsinha/javademo:2.0.0"         
            //sshagent(['dockerdeployserver2']) {
            //  sh "ssh -o StrictHostKeyChecking=no ubuntu@18.215.68.236 ${dockerRun}"
                   
         }
         
      //}
      
   /*   stage('Build'){
         // Get maven home path and build
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'   
         sh "${mvnHome}/bin/mvn package"
      }  
      
      stage ('Test'){
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'    
         sh "${mvnHome}/bin/mvn verify; sleep 3"
      }
      
       stage('Build Docker Image'){
         sh 'docker build -t rajnikhattarrsinha/javademoapp5:1.0.0 .'
      }  
   
      stage('Publish Docker Image'){
         withCredentials([string(credentialsId: 'dockerpwd', variable: 'dockerPWD')]) {
              sh "docker login -u rajnikhattarrsinha -p ${dockerPWD}"
         }
        sh 'docker push rajnikhattarrsinha/javademoapp5:1.0.0'
      }
      
      stage ('copy'){                        
          withCredentials([string(credentialsId: 'k8pwd', variable: 'k8PWD')]) {
             sh "sshpass -p ${k8PWD} ssh -o StrictHostKeyChecking=no ubuntu@104.211.163.224"  
             //sh "sshpass -p 'Alpha#757575' scp -r deployment.yaml ubuntu@104.211.186.165:/home/ubuntu"
             sh 'sshpass -p ${k8PWD} scp -r deployment.yaml ubuntu@104.211.163.224:/home/ubuntu'
             //sh 'sshpass -p ${k8PWD} scp -r deployment.yaml ubuntu@104.211.186.199:/home/ubuntu'
         }
      }
      
      stage('Deploy'){
         def k8Apply= "kubectl apply -f deployment.yaml" 
         withCredentials([string(credentialsId: 'k8pwd', variable: 'k8PWD')]) {
            sh "sshpass -p ${k8PWD} ssh -o StrictHostKeyChecking=no ubuntu@104.211.163.224 ${k8Apply}"
         }
       }
  /*
      stage ('Test'){
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'    
         sh "${mvnHome}/bin/mvn verify; sleep 3"
      }
      stage('Build'){
         // Get maven home path and build
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'   
         sh "${mvnHome}/bin/mvn package"
      }    
      
      stage('Build Docker Image'){
         sh 'docker build -t rajnikhattarrsinha/javademoapp3:1.0.0 .'
      }  
   
      stage('Publish Docker Image')
      {
         withCredentials([string(credentialsId: 'dockerpwd', variable: 'dockerPWD')]) {
              sh "docker login -u rajnikhattarrsinha -p ${dockerPWD}"
         }
        sh 'docker push rajnikhattarrsinha/javademoapp3:1.0.0'
      }
      
      stage ('copy'){
            sh "sshpass -p 'Alpha#757575' scp -r deployment.yaml ubuntu@104.211.186.165:/home/ubuntu"
             /*withCredentials([string(credentialsId: 'k8pwd', variable: 'k8PWD')]) {
      sh 'sshpass -p ${k8PWD} scp -r deployment.yaml ubuntu@104.211.186.199:/home/ubuntu'
      }*/
      //}
     /* stage('Copy deployment file')
      {
         withCredentials([string(credentialsId: 'k8pwd', variable: 'k8PWD')]) {
              // sh "sshpass -p ${k8PWD} scp -r deployment.yaml ubuntu@104.211.186.199:/home/ubuntu"
              sh "sshpass -p ${k8PWD} StrictHostKeyChecking=no scp -r deployment.yaml ubuntu@104.211.186.199:/home/ubuntu "
         }
      }
       */
      /*stage ('copy'){
            //sh "sshpass -p 'Alpha#757575' scp -r deployment.yaml ubuntu@104.211.186.199:/home/ubuntu"
            sh "sshpass -p 'Alpha#757575' scp -r deployment.yaml ubuntu@104.211.186.165:/home/ubuntu"
             /*withCredentials([string(credentialsId: 'k8pwd', variable: 'k8PWD')]) {
      sh 'sshpass -p ${k8PWD} scp -r deployment.yaml ubuntu@104.211.186.199:/home/ubuntu'
      }*/
     // }
     /* stage ('copy'){
            //sh "sshpass -p 'Alpha#757575' scp -r deployment.yaml ubuntu@104.211.186.199:/home/ubuntu"
            sh "sshpass -p 'Alpha#757575' scp -r deployment.yaml ubuntu@104.211.186.165:/home/ubuntu"
             /*withCredentials([string(credentialsId: 'k8pwd', variable: 'k8PWD')]) {
      sh 'sshpass -p ${k8PWD} scp -r deployment.yaml ubuntu@104.211.186.199:/home/ubuntu'
      }
      }
      stage('Deploy')
      {
         def k8Apply= "kubectl apply -f deployment.yaml" 
         withCredentials([string(credentialsId: 'k8pwd', variable: 'k8PWD')]) {
               //sh "sshpass -p ${k8PWD} ssh ubuntu@104.211.186.199 ${k8Apply}"
             //  sh "sshpass -p ${k8PWD} ssh -o StrictHostKeyChecking=no ubuntu@104.211.186.199 ${k8Apply}"
               sh "sshpass -p ${k8PWD} ssh -o StrictHostKeyChecking=no ubuntu@104.211.186.165 ${k8Apply}"
               
         }
       }
     */  
   
}
