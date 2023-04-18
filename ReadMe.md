https://registry.terraform.io/namespaces/mm-devops-cloud

Source Code: github.com/mm-devops-cloud/terraform-aws-s3-static-website

Requirements:
The list below contains all the requirements for publishing a module:

    * GitHub. The module must be on GitHub and must be a public repo. This is only a requirement for the public registry. 
      If you're using a private registry, you may ignore this requirement.

    * Named terraform-<PROVIDER>-<NAME>. Module repositories must use this three-part name format, where <NAME> reflects the type of infrastructure the module manages and <PROVIDER> is the main provider where it creates that infrastructure. 
      The <NAME> segment can contain additional hyphens.
      Examples: terraform-google-vault or terraform-aws-ec2-instance.

    * Repository description. The GitHub repository description is used to populate the short description of the module. This should be a simple one sentence description of the module.
      Standard module structure. The module must adhere to the standard module structure. This allows the registry to inspect your module and generate documentation, track resource usage, parse submodules and examples, and more.

    * x.y.z tags for releases. The registry uses tags to identify module versions. Release tag names must be a semantic version, which can optionally be prefixed with a v. 
      For example, v1.0.4 and 0.9.2. To publish a module initially, at least one release tag must be present. Tags that don't look like version numbers are ignored.


- for structure the module follow the steps here :
    https://developer.hashicorp.com/terraform/language/modules/develop/structure


- i make my own module on this repository :
    https://github.com/mm-devops-cloud/terraform-aws-s3-static-website

- i main the module on public repositories for terraform you can check here :
    https://registry.terraform.io/modules/mm-devops-cloud/s3-static-website/aws/latest?tab=inputs