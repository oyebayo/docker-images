This custom docker image was created to be used in the CI/CD pipeline on CircleCI, 
to avoid having to download and install the additional libraries at every run

It's based on the microsoft sdk-3.1 alpine image will be referenced in the circleci config.yml file. You may host this built image in any registry you like, but bear the costs of download bandwidth in mind!
