These custom docker images were created to be used in the CI/CD pipeline on CircleCI, 
to avoid having to download and install the additional libraries at every run

The alpine image is used in building packages for ECR (hence the need for AWS), while the dotnet-2.2 image is used to run integration tests
They will both be referenced in the circleci config.yml file. Note that github credentials are required in order to use these images
