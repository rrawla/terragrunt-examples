#!/bin/bash
terragrunt plan -out=tgf.plan  -lock=false 
terragrunt show -json tgf.plan > tgf.json
terragrunt graph > tgf.graph
snitch2 static -c ./compliance.config.yml -p "tgf.json"  -g "tgf.graph"
rm tgf.graph tgf.json 
