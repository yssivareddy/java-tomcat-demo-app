node{
      
      stage('Checkout'){
         git 'https://github.com/rajnikhattarrsinha/Java-Demo-Application'
      }
      stage('Build'){
         // Get maven home path and build
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'   
         sh "${mvnHome}/bin/mvn package"
      }       
       
      stage ('Test'){
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'    
         sh "${mvnHome}/bin/mvn verify; sleep 3"
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
           
      stage ('copy'){                        
          withCredentials([string(credentialsId: 'k8pwd', variable: 'k8PWD')]) {
             sh "sshpass -p ${k8PWD} ssh -o StrictHostKeyChecking=no ubuntu@104.211.190.132"  
             sh 'sshpass -p ${k8PWD} scp -r deployment.yaml ubuntu@104.211.190.132:/home/ubuntu'           
         }
      }
      
      stage('Deploy'){
         def k8Apply= "kubectl apply -f deployment.yaml" 
         withCredentials([string(credentialsId: 'k8pwd', variable: 'k8PWD')]) {
            sh "sshpass -p ${k8PWD} ssh -o StrictHostKeyChecking=no ubuntu@104.211.190.132 ${k8Apply}"
         }
       }

}
