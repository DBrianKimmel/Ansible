# Create Your Own Docker Image Running Ansible

Vince Sesto

Ok, I know it’s been an eternity since we’ve posted last.
But we’re still here and working hard.
We’ve had a few projects on the go over the past few months including an update and republish of our book “Practical Ansible: Configuration Management from Start to Finish”.
You should see some more work coming out in the coming months on Medium, so stay tuned.

Ok, why on earth would you want to do something like this.
Well, I think one thing we’ve learn’t about Docker is that it’s the perfect way to test and spin up environments on a clean image.
During the process of writing “Practical Ansible”, I actually saw it as the perfect way to test out the Ansible commands and playbooks I was developing without the need to make sure there was nothing running on my own laptop that could be causing my code to fail, or in some cases, complete when it shouldn’t have.

The code used as part of this article can be located in the following repository:

* [Ansible](https://github.com/vincesesto/ansible-docker-image)

If you’ve tried to do this before, setting up and running Ansible on a container, is not 100% straight forward, but is achievable.
There is a few things that need to be worked out before you can install and run Ansible on your Docker container.
These include:

* Installing Ansible
* Installing SSH
* Ensuring SSH is running on the container when it is started
* Setting up your container so you can SSH without using a password

Below is a copy of the Dockerfile I am using to get this working, but if you’re in a hurry,
I have created an image which is available on Docker Hub at the following
[location:](https://hub.docker.com/repository/docker/vincesestodocker/try-ansible/general)

``` bash
01 FROM ubuntu
02
03 ENV TZ=Pacific/Auckland
04 RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
05
06 RUN apt-get update 
07 RUN apt-get install -y curl vim python3 python3-pip git libffi-dev libssl-dev supervisor openssh-server 
08 RUN apt-get install -y ansible
09
10 COPY id_rsa.pub /root/.ssh/id_rsa.pub
11 COPY id_rsa /root/.ssh/id_rsa 
12 RUN cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys 
13 RUN chmod 600 -R /root/.ssh/ 
14
15 RUN service ssh start
16
17 COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf 
18 EXPOSE 22 
19 CMD ["/usr/bin/supervisord"]
```

For clarity, we have numbered the lines and spread out some of the Dockerfile directives across numerous lines.
Please don’t include the line numbers in your Dockerfile and feel free to chain some of the directives together to reduce size of the Dockerfile and image.

## Installing Ansible

Nothing too difficult here, but you need to make sure you are using the correct package management for your image.
We are simply running apt-get install ansible in line 8.
I prefer using pip3 as it is usually a more up to date version, but due to corporate proxies being used in my corporate environment, I do occasionally have issues with this and is why I went for this option.

## Installing SSH

Again no big issue, but you need to remember one thing, openssh-server will need to be configured during installation time which can mess with your docker build command.
To work around this, set the Timezone Environment Variables in lines 3 and 4 to make sure the installation is not prompting you for this information during build time.

## Running SSH

Once again there is not too much to this, we could simply set a CMD statement at the end of our Dockerfile to make sure the SSH daemon is running when we start up our container.
Instead we have installed supervisord onto the container, and set up a basic configuration file that we have below.
The supervisord.conf file gets copied into the Docker image in line 18 of our Dockerfile and we then run “/usr/bin/supervisord” at the end of the Dockerfile as our CMD directive.
This gives us the opportunity to run any other daemons we need to as part of supervisord instead of only being limited to the one item running.

Below is the basic supervisord.conf file we add to our image:

``` bash
[supervisord]
nodaemon=true[program:sshd]
command=/usr/sbin/sshd -D
```

NOTE: we also expose port 22 as part of our Dockerfile to allow SSH via this port.

## SSH Without Passwords

Once again, if you are happy typing in passwords all the time, then this option could be skipped as long as you then create a user with a username and password.

## Putting It All Together

We don’t have any SSH keys set up, but with the tiny build script called build-ansible-image.sh we have below, we can generate the keys, build the image and then run a simply test to verify Ansbile is installed:

``` bash
01 #!/bin/bash
02
03 ssh-keygen -q -t rsa -N '' -f ./id_rsa <<<y 2>&1 >/dev/null
04 docker build -t docker-ansible .
05 docker run --rm -it docker-ansible ansible --version
```

To run this, all we need to do is:

``` bash
sh ./build-ansible-image.sh
```

We can then, run the container image as a daemon:

``` bash
docker run --rm -itd --name test-ansible docker-ansible
```

Connect to the running container:

``` bash
docker exec -it test-ansible /bin/bash
```

And start running Ansible commands:

``` bash
ansible all -i “localhost,” -m shell -a ‘echo Ansible is fun’localhost | CHANGED | rc=0 >>
Ansible is fun
```

Remember, if you’re interested in learning more about Ansible, feel free to checkout our latest publication through Apress, “Practical Ansible: Configuration Management from Start to Finish”.

Found this post useful? Kindly tap the clap button below! :)

About The Author

DevOps Engineer, Endurance Athlete and Author.
As a DevOps Engineer I specialize in Linux and Open Source Applications.
Particularly interested in Search Marketing and Analytic’s, and is currently developing my skills in devops, continuous integration, security, and development(Python).
Splunk User Developer Administrator
