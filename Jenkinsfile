terraformModules = ['live/non-prod/us-east-1/qa/dynamodb']
node {
   docker.withTool('docker') 
   {  
      docker.withRegistry('https://005901988046.dkr.ecr.ca-central-1.amazonaws.com/','ecr:ca-central-1:aws-instance-role') 
      {
          docker.image('005901988046.dkr.ecr.ca-central-1.amazonaws.com/matter-compliance:0.5.3').inside 
          {
              
               stage('Checkout')
                {
                  checkout scm
                }
                stage('Execute') 
                {
                  executeStages(terraformModules)                    
                }
          }
      }
    }
}  
def executeStages(terraformModules)
{
  for(def terraformModule in terraformModules)
  {
      dir(terraformModule) 
      {
        stageValidate(terraformModule)
        stagePlan(terraformModule)
        stageCompliance(terraformModule)
        stageApply(terraformModule)
        stageCleanUp(terraformModule)
      }
  }
}

def stageValidate(tfModule)
{
  stage("Validating"){
    withEnv(["TERRAGRUNT_DISABLE_INIT=true"])
    {
      sh 'terragrunt validate'
    }
  }
}
def stagePlan(tfModule)
{
  stage('Plan')
  {
    sh 'terragrunt plan -out=tgf.plan  -lock=false'
    sh 'terragrunt show -json tgf.plan > tgf.json'
    sh 'terragrunt graph > tgf.graph'
  }
}
def stageCompliance(tfModule) {
  stage("Compliance Check")
  {
    sh 'snitch2 static -c ./compliance.config.yml -p tgf.json  -g tgf.graph'
  }
}

def stageApply(tfModule) {
  stage('Deploy')
  {
    sh 'echo Apply Terraform..'
  }
}
def stageCleanUp(tfModule) {
  stage('Clean Up')
  {
     sh 'rm tgf.graph tgf.json'
  }
}