abcs = ['a', 'b', 'c']
node('master') {

            stage('checkout code')
            {
                git 'https://github.com/rrawla/terragrunt-examples.git'
            }
            stage('Test 1: loop of echo statements') 
            {
              echo_all(abcs)
            }
  }

@NonCPS // has to be NonCPS or the build breaks on the call to .each
def echo_all(list) {
    list.each { item ->
        echo "Hello ${item}"
    }
}
