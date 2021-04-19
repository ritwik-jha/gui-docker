# Launching Docker Programs in Graphical Environment

Checkout the final demostration video: 
https://user-images.githubusercontent.com/59885389/115184602-c5298480-a0fb-11eb-9b8a-09afe654db0d.mp4




## Objective 
The main objective of this project is to demostrate how to launch graphical programs in docker container. 

## Explaination
Anyone familiar with docker or any other container engine would know that the container engies don't support graphical programs by default. Here also docker doesn't supports 
graphical programs and if we try to launch a graphical program from container it would fail. This happens because the container doesn't has a display. 

To launch graphical program in our container we need to connect the display of our base system to the container. This will launch the graphical program on the display of the base system. 
To connect the display of our base system to the container we use Xserver program. (To know more about xserver click [here](https://en.wikipedia.org/wiki/X_Window_System))

## Steps

### Step-1
In this step we create a docker image which will have xauth installed and also the desired software to run. Here we have used a ubuntu image as base image and have installed xauth
and firefox. 

We have used Dockerfile to create this image.

To create the image:

```bash
docker build . -t <image_name>
```

You can create your image or you can use my pre-created image:
```bash 
docker pull ritwik46/ubuntu-xauth:latest
```

Now we have the image which has xauth and firefox installed. 
![Screenshot (302)](https://user-images.githubusercontent.com/59885389/115183316-2b60d800-a0f9-11eb-9960-9241290f7b00.png)

### Step-2
In this step we do the base system configuration of X server.
Xauth is a simple mechanism which would allow docker containers to access control of the X Servers also called the display servers. However, we need to manually add a randomly generated cookie for the session on which the X server is currently running.

To list the cookies available in the base system:
```bash
xauth list
```

![Screenshot (303)](https://user-images.githubusercontent.com/59885389/115183368-42072f00-a0f9-11eb-8b06-f70f205d9835.png)



We use this cookie to establish the session. We copy this cookie as it would be used in later steps.

### Step-3
Now we launch the container in which we want to launch the graphical program. 

To launch the container:
```bash
docker run -ti --net=host -e DISPLAY -v /tmp/.X11-unix <image_name> bash
```

![Screenshot (304)](https://user-images.githubusercontent.com/59885389/115183443-63681b00-a0f9-11eb-8b41-ad955ee62923.png)


This will give us the shell of the launched container. Now we connect this container to the X server using the copied cookie. 

To add the cookie in container:
```bash
xauth add <copied_cookie>
```

![Screenshot (306)](https://user-images.githubusercontent.com/59885389/115183481-7844ae80-a0f9-11eb-9c95-93312241aa9c.png)


To confirm if the cookie has been copied and configured or not we can use:
```bash
xauth list
```
![Screenshot (307)](https://user-images.githubusercontent.com/59885389/115183496-7ed32600-a0f9-11eb-81f7-99a263f7359f.png)

Now the display has been connected and the session has started. Now we can launch the program in the container.
```bash
/usr/bin/firefox
```

![Screenshot (309)](https://user-images.githubusercontent.com/59885389/115183550-9d392180-a0f9-11eb-95b1-59fcc4742e59.png)


![Screenshot (308)](https://user-images.githubusercontent.com/59885389/115183527-91e5f600-a0f9-11eb-9458-7b9516b79e52.png)







