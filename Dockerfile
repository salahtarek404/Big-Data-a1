# Base image as specified in Assignment #1, Section 3.1
FROM quay.io/jupyter/scipy-notebook:latest

# Set working directory inside the container
WORKDIR /home/jovyan/work

# Copy requirements file first for Docker layer caching
COPY --chown=${NB_UID}:${NB_GID} requirements.txt .

# Install additional packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the dataset and notebook folders into the container image
COPY --chown=${NB_UID}:${NB_GID} data/ ./data/
COPY --chown=${NB_UID}:${NB_GID} notebook/ ./notebook/

# Create output and figures directories
RUN mkdir -p output/figures screenshots && \
    fix-permissions "/home/jovyan/work"

# Set default working directory
WORKDIR /home/jovyan/work
