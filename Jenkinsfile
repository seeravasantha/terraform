
pipeline{
  agent any
  parameters {
        choice (
            name: 'action',
            choices: 'no\napply\ndestroy',
            description: "Apply and destroy app1 infrastructure"
        )
    } 
  stages{
    stage('init'){
      when{
        expression{
          params.action == 'apply'
      steps{
        sh "terraform init"
      }
      stage('validate'){
        when{
        expression{
          params.action == 'apply'
        steps{
          sh "terraform validate"}
      }
        stage('plan'){
          when{
        expression{
          params.action == 'apply'
          steps{
            sh "terraform plan"}
    }
      stage('apply'){
        steps{
          sh "terraform apply --auto-approve"
        }
      }
            stage('destroy'){
              when{
        expression{
          params.action == 'destroy'
    }
  }
              steps{
                sh "terraform destroy"}
}
          }
        }
        }
      }
        }
      }
    }
  }
}
