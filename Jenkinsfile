terraformModules = ['/non-prod/us-east-1/qa/dynamodb']
node {
   docker.withTool('docker') 
   {  
      docker.withRegistry('https://005901988046.dkr.ecr.ca-central-1.amazonaws.com/','ecr:ca-central-1:aws-instance-role') 
      {
          docker.image('005901988046.dkr.ecr.ca-central-1.amazonaws.com/matter-compliance:latest').inside 
          {
                stage('Checkout')
                {
                  git 'https://github.com/rrawla/terragrunt-examples.git'
                }
                stage('Setup') 
                {
                  for(def terraformModule in terraformModules)
                  {
                    executeStages(terraformModule)
                  }
                }
          }
      }
    }
}  

@NonCPS
def executeStages(terraformModule)
{
  dir(terraformModule) {
    stageValidate(terraformModule)
  }
}

@NonCPS
def stageValidate(tfModule)
{
  stage("Validate ${tfModule}")
  withEnv("TERRAGRUNT_DISABLE_INIT=true")
  {
    sh 'terragrunt validate'
    sh 'terragrunt fmt -recursive -diff'
  }
}
