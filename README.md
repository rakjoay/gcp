Set the below ENV variables.
	Please go through the names once. They have been kept self explanatory.
	You can easily change any of those to any valid values supported by google cloud and get desired output

	env variable GOOGLE_APPLICATION_CREDENTIALS points to the path where credentials file is stored.

	export GOOGLE_APPLICATION_CREDENTIALS=/Users/anandk/Anand/Self/demo/gcloud/01Rajesh/secrets/myFirstProject-9b6e4b094f95.json

	export TF_VAR_env=demoenv3
	export TF_VAR_gce_project=radiant-cycle-196820
	export TF_VAR_gce_region=us-central1
	export TF_VAR_vpc_name=testvpc
	export TF_VAR_vpc_cidr=10.0.0.0/16
	export TF_VAR_dbusername=anand
	export TF_VAR_dbpassword=anand
	export TF_VAR_dbhost=%
	export TF_VAR_dbsize=db-n1-standard-1
	export TF_VAR_dbversion=MYSQL_5_7
	export TF_VAR_kubernetes_username=anand
	export TF_VAR_kubernetes_password=anandanandanandanand
	export TF_VAR_topic=publisher
	export TF_VAR_subscription=subscriber

	Note: variable "TF_VAR_env" governs the names of the resources created for that particular env. Modify it to appropriate name for creation of new envs

To start up your infrastructure run below commands
	terraform init  (onetime on fresh code checkout. It initialises terraform) 
	terraform apply -auto-approve -input=true

After complete execution of terraform you should see output similar to

	Outputs:

	bastion_ip = 104.198.50.198
	google_compute_network.newvpc.name = testvpc
	google_k8s_endpoint = 35.225.205.236
	google_sql_database_ip = 23.236.49.11

	It will give you all the necessary endpoints

To delete your infrastructure run below command
	terraform destroy -force

	upon successful deletion you should see below message at end

	"Destroy complete! Resources: 8 destroyed."



Important points:
	- For demo purpose the k8s cluster is only confined to single zone but if you want it to be in multi zone just edit the main.tf file and uncomment below lines

	  //additional_zones = [
  		//  "${var.gce_region}-b",
  		//  "${var.gce_region}-c",
  	  //]

  	 - Replication for sql isnt enabled as there is an open issue on terraform git once that is solved I will update the scripts. But currently once the infrastructre is started you can enable it through console just by one click.
		Issue on github
		https://github.com/terraform-providers/terraform-provider-google/issues/1146

	- modify the variable TF_VAR_dbhost to your ip or any other desired value. currently it is set to % which gives it global access.

