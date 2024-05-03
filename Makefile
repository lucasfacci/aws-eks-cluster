APP = aws-eks-cluster

fmt:
	@terraform fmt \
		-recursive

plan:
	@terraform plan \
		-var="region=us-east-1" \
		-var="project_name=aws-eks-cluster" \
		-var="cidr_block=10.0.0.0/16" \
		-var='tags={"Department"="DevOps"}'

apply:
	@terraform apply \
		-var="region=us-east-1" \
		-var="project_name=aws-eks-cluster" \
		-var="cidr_block=10.0.0.0/16" \
		-var='tags={"Department"="DevOps"}'