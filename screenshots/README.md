# Screenshots Checklist for Assignment Submission (Section 3.4)

All required screenshots proving container lifecycle and cross-machine verification:

1. docker_build.png: Successful execution of docker build -t bd-a1:latest .
2. docker_images.png: Output of docker images showing bd-a1:latest and base image.
3. docker_ps.png: Output of docker ps showing running container and port mapping.
4. docker_ps_a.png: Output of docker ps -a listing active and past containers.
5. docker_logs.png: Output of docker logs bd-a1-container showing JupyterLab startup.
6. docker_inspect.png: Output of docker inspect bd-a1-container showing bind mount.
7. jupyter_running.png: Browser view of JupyterLab running analysis.ipynb with workspace.
8. docker_hub_push.png: Successful push of the image to Docker Hub under repository salahtarek/bd-a1:latest.
