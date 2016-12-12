



Initial concourse login

```
fly --target name_for_pipeline_target login -n sample_team_name --concourse-url https://your_concourse_url
```


From root of this project

```
fly -t name_for_pipeline_target sp --load-vars-from=credentials.yml -c pipeline.yml -p nodejs_simple_test
```


credentials.yml example with dumbie data


docker-hub-email: <dockerhub_email_here>
docker-hub-username: <dockerhub_username_here>
docker-hub-password: <dockerhub_password_here>


repo-username: <github_username_here>
private-repo-key: |-
  -----BEGIN OPENSSH PRIVATE KEY-----
  <blahblah_private_key_here>
  -----END OPENSSH PRIVATE KEY-----




Values to adjust in pipeline for similiar functionality but different project.

resources:
    git-nodejs-simple-test-develop
        description: Arbitrary name given to git repo develop branch for project. Used in pipeline for referencing that "resource".

        uri: change uri to your projects ssh uri on github.

        branch: develop
            desc: obviously change to whatever branch you watching to start the pipeline.


    nodejs_simple_test_image_build
        description: Arbitrary name given to docker image for this project. Used in pipeline for referencing that "resource".

        repository: gregorycox/nodejs_simple_test
            desc: image name on dockerhub that this resource will use(push/pull)
        tag: build
            desc: tag for the image above, "build" is used as a temporary image to test, changed to latest after tests have passed.


    git-nodejs-simple-test-master
        description: Arbitrary name given to git repo master branch for project. Used in pipeline for referencing that "resource".

        uri: change uri to your projects ssh uri on github.

        branch: master
            desc: obvious, this is referencing the master branch for the repo.

tasks:
    build-docker-image
        desc: this is the arbitrary name given to this task.  Used in pipeline for referencing that "task".

        params:
          build: git-nodejs-simple-test-develop
            desc: this is telling this task to "build" based on the resource given.


    test-docker-image
        desc: this is the arbitrary name given to this task.  Used in pipeline for referencing that "task".


        source: {repository: gregorycox/nodejs_simple_test, tag: build}
            desc: this describes where the image is location to pull for testing.

        path: /usr/src/app/node_modules/mocha/bin/mocha
            desc: this is the path to the file to run to initiate the testing.


    promote-nodejs_simple_test-repo
        desc: this is the arbitrary name given to this task.  Used in pipeline for referencing that "task".




Notes for docker portions:

```
docker build -t gregorycox/simple_node_test .

docker run -it --rm gregorycox/simple_node_test

docker run -it --rm gregorycox/simple_node_test node_modules/mocha/bin/mocha
```


